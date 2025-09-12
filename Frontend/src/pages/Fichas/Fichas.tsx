import { useState, useEffect } from "react";
import axios from "axios";
import { getIO } from "../../services/socket";
import FichasHtml from "./FichasVista";
import { Ficha } from '../../types/Ficha';

// Interfaces para tipado seguro
/*export interface Ficha {
  idFicha: number;
  Ficha: number;
  Ticket: string;
  Periodo: string;
  FechaInicio: string;
  Horario: string;
  paciente: string;
  Especialidad: string;
  medico: string;
  EstadoFicha: string;
}*/

export interface Especialidad {
  Especialidad: string;
}

export interface FichaActualizadaEvent {
  idFicha: number;
  estadoNombre: string;
}

export default function Fichas() {
  const [fichas, setFichas] = useState<Ficha[]>([]);
  const [especialidades, setEspecialidades] = useState<Especialidad[]>([]);
  const [fechaSeleccionada, setFechaSeleccionada] = useState("");
  const [especialidadSeleccionada, setEspecialidadSeleccionada] = useState("");

  // Inicializar Socket.IO
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

  // Cargar especialidades
  const cargarEspecialidades = async () => {
    if (!fechaSeleccionada) return;
    try {
      const res = await axios.get<{ data: Especialidad[] }>(
        `http://localhost:3000/especialidades/${fechaSeleccionada}`
      );
      setEspecialidades(res.data.data);
    } catch (err) {
      console.error("Error al cargar especialidades:", err);
    }
  };

  // Cargar fichas
  const cargarFichas = async () => {
    if (!fechaSeleccionada || !especialidadSeleccionada) {
      alert("Seleccione fecha y especialidad");
      return;
    }
    try {
      const res = await axios.get<{ data: Ficha[] }>(
        `http://localhost:3000/publicas/${fechaSeleccionada}/${especialidadSeleccionada}`
      );
      setFichas(res.data.data);
    } catch (err) {
      console.error("Error al obtener fichas:", err);
    }
  };

  return (
    <FichasHtml
      fichas={fichas}
      especialidades={especialidades}
      fechaSeleccionada={fechaSeleccionada}
      especialidadSeleccionada={especialidadSeleccionada}
      setFechaSeleccionada={setFechaSeleccionada}
      setEspecialidadSeleccionada={setEspecialidadSeleccionada}
      cargarEspecialidades={cargarEspecialidades}
      cargarFichas={cargarFichas}
    />
  );
}
