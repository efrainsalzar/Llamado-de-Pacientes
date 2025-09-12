import { useState, useEffect, useCallback } from "react";
import axios from "axios";
import { getIO } from "../../services/socket";
import UsuariosVista from "./UsuariosVista";
import { Ficha } from '../../types/Ficha';

// ================= Estados del componente =================
interface Medico { Medico: string }
interface Turno { Turno: string }

export default function Usuarios() {
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

    const actualizarFicha = (f: any) => {
      console.log("Evento Socket: fichaActualizada", f);
      setFichas(prev => {
        const index = prev.findIndex(p => p.idFicha === f.IDFicha);
        if (index >= 0) {
          const oldEstado = prev[index].EstadoFicha;
          if (oldEstado !== f.EstadoFicha) {
            console.log(`[SOCKET] Ficha ${f.IDFicha} actualizada: ${oldEstado} → ${f.EstadoFicha}`);
          }
          const newFichas = [...prev];
          newFichas[index] = { ...prev[index], ...f, idFicha: f.IDFicha, EstadoFicha: f.EstadoFicha };
          return newFichas;
        } else {
          console.log(`[SOCKET] Ficha nueva agregada: ${f.IDFicha}`);
          return [...prev, { ...f, idFicha: f.IDFicha }];
        }
      });
    };

    socket.on("fichaActualizada", actualizarFicha);
    return () => {
      console.log("Desconectando Socket.IO");
      socket.off("fichaActualizada", actualizarFicha);
    };
  }, []);

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
    if (fichas.some(f => f.EstadoFicha === "Llamado")) return;
    procesarFichas(f => f.EstadoFicha === "En espera", "Llamado", 2, "llamar siguiente", { maxUno: true });
  }, [fichas, procesarFichas]);

  const atenderSiguiente = useCallback(() => {
    procesarFichas(f => f.EstadoFicha === "Llamado", "Atendido", 3, "atender siguiente", { maxUno: true });
  }, [procesarFichas]);

  const reiniciarSiguiente = useCallback(() => {
    procesarFichas(f => f.EstadoFicha !== "En espera", "En espera", 1, "reiniciar siguiente");
  }, [procesarFichas]);

  const cancelarSiguiente = useCallback(() => {
    procesarFichas(f => f.EstadoFicha !== "Cancelado" && f.EstadoFicha !== "Atendido", "Cancelado", 4, "cancelar siguiente", { maxUno: true });
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
