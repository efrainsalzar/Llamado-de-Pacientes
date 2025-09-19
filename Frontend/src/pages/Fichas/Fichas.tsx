import { useState, useEffect } from "react";
import axios from "axios";
import { getIO, initSocket } from "../../services/socket";
import { Ficha, Especialidad } from '../../types/Ficha';
import FichasVista from "./FichasVista";

// ================= Componente principal =================
export default function Fichas() {
  // ================= Estados =================
  const [fichas, setFichas] = useState<Ficha[]>([]);
  const [especialidades, setEspecialidades] = useState<Especialidad[]>([]);
  //const [fechaSeleccionada, setFechaSeleccionada] = useState("");
  const [especialidadSeleccionada, setEspecialidadSeleccionada] = useState("");

  // ================= Socket.IO =================
  useEffect(() => {
    const socket = initSocket(); // Inicializa la conexión a Socket.IO
    console.log("Conectado a Socket.IO");

    const actualizarFicha = (f: Ficha) => {
      setFichas(prev => {
        const index = prev.findIndex(p => p.IDFicha === f.IDFicha);
        const newFichas = [...prev];

        if (index >= 0) {
          // Detectar cambio de estado a "Llamado"
          if (prev[index].DesEstadoVista !== "Llamado" && f.DesEstadoVista === "Llamado") {
            hablar(`Ficha número ${f.Ficha}, paciente ${f.paciente}, por favor diríjase al ${f.Consultorio}`);
            //hablar_dos(`Ficha número ${f.Ficha}, paciente ${f.paciente}, por favor diríjase al consultorio`, "es-ES-Standard-B");
          }

          newFichas[index] = { ...prev[index], ...f, IDFicha: f.IDFicha, DesEstadoVista: f.DesEstadoVista };
        } else {
          // Nueva ficha (si ya viene en Llamado, también se habla)
          if (f.DesEstadoVista === "Llamado") {
            hablar(`Ficha número ${f.Ficha}, paciente ${f.paciente}, por favor diríjase al consultorio`);
          }
          newFichas.push({ ...f, IDFicha: f.IDFicha });
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

    // Unirse a la room pública
    socket.emit("joinPublic");

    socket.on("joinedPublic", () => {
      console.log("[SOCKET] Conectado a pantalla_publica");
    });
  }, []);


  // ================= Funciones de carga de datos =================
  // Cargar especialidades según la fecha seleccionada
  const cargarEspecialidades = async () => {
    try {
      const res = await axios.get<{ data: Especialidad[] }>(
        `http://localhost:3000/especialidades`
      );
      setEspecialidades(res.data.data);
    } catch (err) {
      console.error("Error al cargar especialidades:", err);
    }
  };

  // Cargar fichas según fecha y especialidad seleccionadas
  const cargarFichas = async () => {
    if (!especialidadSeleccionada) {
      alert("Seleccione especialidad");
      return;
    }

    try {
      const res = await axios.get<{ data: Ficha[] }>(
        `http://localhost:3000/publicas/${especialidadSeleccionada}`
      );
    const fichasCargadas = res.data.data;
    setFichas(fichasCargadas);
    //console.log("datos",res);

    // Revisar si alguna ya está en "Llamado"
    fichasCargadas.forEach(f => {
      if (f.DesEstadoVista === "Llamado") {
        hablar(`Ficha número ${f.Ficha}, paciente ${f.paciente}, por favor diríjase al consultorio`);
      }
    });
    } catch (err) {
      console.error("Error al obtener fichas:", err);
    }
  };

  // ================= Render =================
  return (
    <FichasVista
      fichas={fichas}
      especialidades={especialidades}
      especialidadSeleccionada={especialidadSeleccionada}
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

// ================= Función para hablar usando internet =================

