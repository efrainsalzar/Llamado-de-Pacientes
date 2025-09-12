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

    socket.on("fichaActualizada", (data: FichaActualizadaEvent) => {
      console.log("Evento recibido en Fichas:", data);
      setFichas((prev) =>
        prev.map((f) =>
          f.idFicha === data.idFicha
            ? { ...f, EstadoFicha: data.estadoNombre }
            : f
        )
      );
    });

    socket.on("fichasActualizadas", (data: Ficha[]) => {
      console.log("Recarga completa de fichas:", data);
      setFichas(data);
    });

    return () => {
      socket.off("fichaActualizada");
      socket.off("fichasActualizadas");
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
