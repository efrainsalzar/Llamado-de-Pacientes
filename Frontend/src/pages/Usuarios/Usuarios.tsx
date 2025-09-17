import { useState, useEffect, useCallback } from "react";
import axios from "axios";
import { getIO } from "../../services/socket";
import UsuariosVista from "./UsuariosVista";
import { Ficha } from '../../types/Ficha';
import { getUsuarioInfo } from "../../services/jwt";

// ================= Estados del componente =================
interface Medico { Medico: string }
interface Turno { Turno: string }

export default function Usuarios() {
  // =================  recuperar el jwt =================

  useEffect(() => {
    const savedToken = localStorage.getItem("token"); // Nombre de la clave usada en localStorage
    if (savedToken) {
      
      console.log("Token recuperado:", savedToken);
      // También puedes configurar axios para que use este token por defecto
      axios.defaults.headers.common['Authorization'] = `Bearer ${savedToken}`;
    } else {
      console.log("No hay token en localStorage");
      window.location.href = "/login"
    }

    const usuario = getUsuarioInfo();

    console.log("Usuario desde JWT:", usuario);
  }, []);

// ================= Estados del componente =================
  const [medicos, setMedicos] = useState<Medico[]>([]);
  const [turnos, setTurnos] = useState<Turno[]>([]);
  const [fechaSeleccionada, setFechaSeleccionada] = useState("");
  const [medicoSeleccionado, setMedicoSeleccionado] = useState("");
  const [turnoSeleccionado, setTurnoSeleccionado] = useState("");
  const [fichas, setFichas] = useState<Ficha[]>([]);

  // ================= Socket.IO =================
  useEffect(() => {
    const socket = getIO();
    console.log("Conectado a Socket.IO");

    const actualizarFicha = (f: Ficha) => {
      console.log("Evento Socket: fichaActualizada", f);
      setFichas(prev => {
        const index = prev.findIndex(p => p.idFicha === f.idFicha);
        if (index >= 0) {
          const oldEstado = prev[index].DesEstadoVista;
          if (oldEstado !== f.DesEstadoVista) {
            console.log(`[SOCKET] Ficha ${f.idFicha} actualizada: ${oldEstado} → ${f.DesEstadoVista}`);
          }
          const newFichas = [...prev];
          newFichas[index] = { ...prev[index], ...f, idFicha: f.idFicha, DesEstadoVista: f.DesEstadoVista };
          return newFichas;
        } else {
          console.log(`[SOCKET] Ficha nueva agregada: ${f.idFicha}`);
          return [...prev, { ...f, idFicha: f.idFicha }];
        }
      });
    };

    socket.on("fichaActualizada", actualizarFicha);
    return () => {
      console.log("Desconectando Socket.IO");
      socket.off("fichaActualizada", actualizarFicha);
    };
  }, []);
  // ================= Unirse a la room =================
useEffect(() => {
  const socket = getIO();
  if (fechaSeleccionada && medicoSeleccionado) {
    socket.emit("joinRoom", { medico: medicoSeleccionado, fecha: fechaSeleccionada });
    console.log(`[SOCKET] Join room medico=${medicoSeleccionado}, fecha=${fechaSeleccionada}`);
  }
}, [fechaSeleccionada, medicoSeleccionado]);

  // ================= Función genérica para cargar datos =================
  const fetchData = useCallback(
    async <T,>(url: string, setter: (data: T) => void, label: string) => {
      try {
        console.log(`[CARGA] ${label} desde: ${url}`);
        const res = await axios.get(url);
        setter(res.data.data as T);
        console.log(`[CARGA] ${label} cargados: ${res.data.data.length}`);
      } catch (err) {
        console.error(`[ERROR] al cargar ${label}:`, err);
      }
    },
    []
  );

  // ================= Funciones de carga =================
  const cargarMedicos = useCallback(() => {
    if (!fechaSeleccionada) return;
    fetchData<Medico[]>(`http://localhost:3000/medicos/${fechaSeleccionada}`, setMedicos, "Médicos");
  }, [fechaSeleccionada, fetchData]);

  const cargarTurnos = useCallback(() => {
    if (!fechaSeleccionada) return;
    fetchData<Turno[]>(`http://localhost:3000/turnos/${fechaSeleccionada}`, setTurnos, "Turnos");
  }, [fechaSeleccionada, fetchData]);

  const cargarFichas = useCallback(async () => {
    if (!fechaSeleccionada || !medicoSeleccionado) {
      alert("Seleccione fecha y médico");
      return;
    }
    const url = turnoSeleccionado
      ? `http://localhost:3000/medicoPeriodo/${fechaSeleccionada}/${medicoSeleccionado}/${turnoSeleccionado}`
      : `http://localhost:3000/medico/${fechaSeleccionada}/${medicoSeleccionado}`;
    await fetchData<Ficha[]>(url, setFichas, "Fichas");
  }, [fechaSeleccionada, medicoSeleccionado, turnoSeleccionado, fetchData]);

  // ================= Función genérica para procesar fichas =================
  const procesarFichas = useCallback(
    async (
      filtro: (f: Ficha) => boolean,
      nuevoEstado: string,
      codigoBackend: number,
      label: string,
      opciones?: { maxUno?: boolean }
    ) => {
      setFichas(prevFichas => {
        let fichasAFiltrar = prevFichas.filter(filtro);
        if (opciones?.maxUno) fichasAFiltrar = fichasAFiltrar.slice(0, 1);
        if (fichasAFiltrar.length === 0) {
          console.log(`[PROCESO] No hay fichas para ${label}`);
          return prevFichas;
        }
        console.log(`[PROCESO] ${fichasAFiltrar.length} ficha(s) para ${label}, nuevo estado: ${nuevoEstado}`);
        return prevFichas.map(f => fichasAFiltrar.some(ff => ff.idFicha === f.idFicha) ? { ...f, EstadoFicha: nuevoEstado } : f);
      });

      try {
        await Promise.all(
          fichas.filter(filtro).slice(0, opciones?.maxUno ? 1 : undefined)
            .map(async f => {
              await axios.put(`http://localhost:3000/actualizarEstadoFicha/${f.idFicha}`, { estado: codigoBackend });
            })
        );
      } catch (err) {
        console.error(`Error al ${label}:`, err);
      }
    },
    [fichas]
  );

  // ================= Acciones específicas =================
  const llamarSiguiente = useCallback(() => {
    if (fichas.some(f => f.DesEstadoVista === "Llamado")) return;
    procesarFichas(f => f.DesEstadoVista === "En espera", "Llamado", 2, "llamar siguiente", { maxUno: true });
  }, [fichas, procesarFichas]);

  const atenderSiguiente = useCallback(() => {
    procesarFichas(f => f.DesEstadoVista === "Llamado", "Atendido", 3, "atender siguiente", { maxUno: true });
  }, [procesarFichas]);

  const reiniciarSiguiente = useCallback(() => {
    procesarFichas(f => f.DesEstadoVista !== "En espera", "En espera", 1, "reiniciar siguiente");
  }, [procesarFichas]);

  const cancelarSiguiente = useCallback(() => {
    procesarFichas(f => f.DesEstadoVista !== "Cancelado" && f.DesEstadoVista !== "Atendido", "Cancelado", 4, "cancelar siguiente", { maxUno: true });
  }, [procesarFichas]);

  // ================= Render =================
  return (
    <UsuariosVista
      medicos={medicos}
      turnos={turnos}
      fichas={fichas}
      fechaSeleccionada={fechaSeleccionada}
      medicoSeleccionado={medicoSeleccionado}
      turnoSeleccionado={turnoSeleccionado}
      setFechaSeleccionada={setFechaSeleccionada}
      setMedicoSeleccionado={setMedicoSeleccionado}
      setTurnoSeleccionado={setTurnoSeleccionado}
      cargarMedicos={cargarMedicos}
      cargarTurnos={cargarTurnos}
      cargarFichas={cargarFichas}
      llamarSiguiente={llamarSiguiente}
      atenderSiguiente={atenderSiguiente}
      reiniciarSiguiente={reiniciarSiguiente}
      cancelarSiguiente={cancelarSiguiente}
    />
  );
}
