import { useState, useEffect } from "react";
import axios from "axios";
import { getIO } from "../../services/socket";
import FichasHtml from "./FichasVista";
import { Ficha } from '../../types/Ficha';

// ================= Tipos =================
export interface Especialidad {
  Especialidad: string;
}

export interface FichaActualizadaEvent {
  idFicha: number;
  estadoNombre: string;
}

// ================= Componente principal =================
export default function Fichas() {
  // ================= Estados =================
  const [fichas, setFichas] = useState<Ficha[]>([]);
  const [especialidades, setEspecialidades] = useState<Especialidad[]>([]);
  const [fechaSeleccionada, setFechaSeleccionada] = useState("");
  const [especialidadSeleccionada, setEspecialidadSeleccionada] = useState("");

  // ================= Socket.IO =================
  useEffect(() => {
    const socket = getIO(); // Inicializa la conexión a Socket.IO
    console.log("Conectado a Socket.IO");

    // Función que actualiza o agrega fichas al recibir evento desde el servidor
    /*const actualizarFicha = (f: any) => {
      console.log("Evento Socket: fichaActualizada", f);
      setFichas(prev => {
        const index = prev.findIndex(p => p.idFicha === f.IDFicha);
        if (index >= 0) {
          // Actualizar ficha existente
          const newFichas = [...prev];
          newFichas[index] = { ...prev[index], ...f, idFicha: f.IDFicha, EstadoFicha: f.EstadoFicha };
          return newFichas;
        } else {
          // Agregar ficha nueva
          return [...prev, { ...f, idFicha: f.IDFicha }];
        }
      });
    };*/

    const actualizarFicha = (f: any) => {
      setFichas(prev => {
        const index = prev.findIndex(p => p.idFicha === f.IDFicha);
        const newFichas = [...prev];

        if (index >= 0) {
          // Detectar cambio de estado a "Llamado"
          if (prev[index].EstadoFicha !== "Llamado" && f.EstadoFicha === "Llamado") {
            //hablar(`Ficha número ${f.Ficha}, paciente ${f.paciente}, por favor diríjase al consultorio`);
          }

          newFichas[index] = { ...prev[index], ...f, idFicha: f.IDFicha, EstadoFicha: f.EstadoFicha };
        } else {
          // Nueva ficha (si ya viene en Llamado, también se habla)
          if (f.EstadoFicha === "Llamado") {
            //hablar(`Ficha número ${f.Ficha}, paciente ${f.paciente}, por favor diríjase al consultorio`);
          }
          newFichas.push({ ...f, idFicha: f.IDFicha });
        }

        return newFichas;
      });
    };


    // Escucha el evento "fichaActualizada" desde el servidor
    socket.on("fichaActualizada", actualizarFicha);

    // Limpieza al desmontar el componente
    return () => {
      socket.off("fichaActualizada", actualizarFicha);
    };
  }, []);

  // ================= Conexión a la room pública =================
  useEffect(() => {
    const socket = getIO();

    // Unirse a la room "pantalla_publica" para recibir todas las actualizaciones
    socket.emit("joinRoom", { room: "pantalla_publica" });
    console.log("[SOCKET] Conectado a room pantalla_publica");
  }, []);

  // ================= Funciones de carga de datos =================
  // Cargar especialidades según la fecha seleccionada
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

  // Cargar fichas según fecha y especialidad seleccionadas
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

  // ================= Render =================
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

// ================= Función para hablar por voz =================
function hablar(texto: string) {
  if (!("speechSynthesis" in window)) {
    console.warn("SpeechSynthesis no soportado en este navegador");
    return;
  }

  const utterance = new SpeechSynthesisUtterance(texto);
  utterance.lang = "es-ES"; // español
  utterance.rate = 1;        // velocidad
  utterance.pitch = 1;       // tono
  utterance.volume = 1;      // volumen
  window.speechSynthesis.speak(utterance);
}
