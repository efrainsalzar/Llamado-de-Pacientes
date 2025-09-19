import { useState, useEffect, useCallback } from "react";
import axios from "axios";
import { getIO, initSocket } from "../../services/socket";
import UsuariosVista from "./UsuariosVista";
import { Ficha } from '../../types/Ficha';
import { getUsuarioInfo } from "../../services/jwt";

// interface Medico { Medico: string }

export default function Usuarios() {

  const [fichas, setFichas] = useState<Ficha[]>([]);
  const [usuario, setUsuario] = useState<{ id: number; nombre: string; IdProfesional: number } | null>(null);

  // ================= Recuperar JWT =================
  useEffect(() => {
    const savedToken = localStorage.getItem("token");
    if (savedToken) {
      console.log("Token recuperado:", savedToken);
      axios.defaults.headers.common['Authorization'] = `Bearer ${savedToken}`;
      const user = getUsuarioInfo();
      setUsuario(user);
      //console.log("Usuario desde JWT:", user);
    } else {
      console.log("No hay token en localStorage");
      window.location.href = "/login";
    }
  }, []);

  // ================= Socket.IO =================
  useEffect(() => {
    const socket = initSocket(); // inicializar una sola vez
    console.log("Socket inicializado y conectado");

    // Escuchar confirmación de room
    socket.on("joinedRoom", (payload: { room: string }) => {
      console.log("[SOCKET] Conectado a la room:", payload.room);
    });

    // Escuchar actualización de fichas
    const actualizarFicha = (f: Ficha) => {
      console.log("Evento Socket: fichaActualizada", f);
      setFichas(prev => {
        const index = prev.findIndex(p => p.IDFicha === f.IDFicha);
        if (index >= 0) {
          const oldEstado = prev[index].DesEstadoVista;
          if (oldEstado !== f.DesEstadoVista) {
            console.log(`[SOCKET] Ficha ${f.IDFicha} actualizada: ${oldEstado} → ${f.DesEstadoVista}`);
          }
          const newFichas = [...prev];
          newFichas[index] = { ...prev[index], ...f, IDFicha: f.IDFicha, DesEstadoVista: f.DesEstadoVista };
          return newFichas;
        } else {
          console.log(`[SOCKET] Ficha nueva agregada: ${f.IDFicha}`);
          return [...prev, { ...f, IDFicha: f.IDFicha }];
        }
      });
    };
    socket.on("fichaActualizada", actualizarFicha);

    return () => {
      console.log("Desconectando Socket.IO");
      socket.off("fichaActualizada", actualizarFicha);
      socket.disconnect();
    };
  }, []); // solo al montar

  // ================= Unirse a room cuando usuario esté disponible =================
  useEffect(() => {
    if (!usuario?.IdProfesional) return;
    const socket = getIO();
    socket.emit("joinRoom", { idProfesional: usuario.IdProfesional });
    console.log(`[SOCKET] Solicitando unirse a room idProfesional=${usuario.IdProfesional}`);
  }, [usuario]);


  // ================= Funciones de carga =================
  const fetchData = useCallback(
    async <T,>(url: string, setter: (data: T) => void, label: string) => {
      try {
        console.log(`[CARGA] ${label} desde: ${url}`);
        const res = await axios.get(url);
        setter(res.data.data as T);
        console.log(`[CARGA] ${label} cargados: ${res.data.data.length}`);
        console.log(res.data);

      } catch (err) {
        console.error(`[ERROR] al cargar ${label}:`, err);
      }
    },
    []
  );

  const cargarFichas = useCallback(async () => {
    if (!usuario?.IdProfesional) {
      alert("No se pudo obtener el IdProfesional del usuario");
      return;
    }

    const url = `http://localhost:3000/obtenerFichas/${usuario.IdProfesional}`;

    await fetchData<Ficha[]>(url, setFichas, "Fichas");
  }, [usuario, fetchData]);

  // ================= Procesar fichas (igual que antes) =================
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
        return prevFichas.map(f => fichasAFiltrar.some(ff => ff.IDFicha === f.IDFicha) ? { ...f, EstadoFicha: nuevoEstado } : f);
      });

      try {
        await Promise.all(
          fichas.filter(filtro).slice(0, opciones?.maxUno ? 1 : undefined)
            .map(async f => {
              await axios.patch(`http://localhost:3000/actualizarEstadoFicha/${f.IDFicha}`, { estado: codigoBackend });
            })
        );
      } catch (err) {
        console.error(`Error al ${label}:`, err);
      }
    },
    [fichas]
  );

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

  return (
    <UsuariosVista
      fichas={fichas}
      cargarFichas={cargarFichas}
      llamarSiguiente={llamarSiguiente}
      atenderSiguiente={atenderSiguiente}
      reiniciarSiguiente={reiniciarSiguiente}
      cancelarSiguiente={cancelarSiguiente}
    />
  );
}
