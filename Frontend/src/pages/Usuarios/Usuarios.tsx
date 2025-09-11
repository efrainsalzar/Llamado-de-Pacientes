import { useState, useEffect, useCallback } from "react";
import axios from "axios";
import { getIO } from "../../services/socket";
import UsuariosVista from "./UsuariosVista";

interface Ficha {
  idFicha: number;
  Ficha: number;
  Ticket: string;
  Periodo: string;
  paciente: string;
  Especialidad: string;
  EstadoFicha: string;
}

interface Medico {
  Medico: string;
}

interface Turno {
  Turno: string;
}

export default function Usuarios() {
  const [medicos, setMedicos] = useState<Medico[]>([]);
  const [turnos, setTurnos] = useState<Turno[]>([]);
  const [fechaSeleccionada, setFechaSeleccionada] = useState("");
  const [medicoSeleccionado, setMedicoSeleccionado] = useState("");
  const [turnoSeleccionado, setTurnoSeleccionado] = useState("");
  const [fichas, setFichas] = useState<Ficha[]>([]);

  // ---------------- Socket.IO ----------------
  useEffect(() => {
    const socket = getIO();
    console.log("Conectado a Socket.IO");

    socket.on("fichaActualizada", (fichaActualizada: Ficha) => {
      console.log("Evento recibido: fichaActualizada", fichaActualizada);
      setFichas((prev) =>
        prev.map((f) => (f.idFicha === fichaActualizada.idFicha ? fichaActualizada : f))
      );
    });

    return () => {
      console.log("Desconectando Socket.IO");
      socket.off("fichaActualizada");
    };
  }, []);

  // ---------------- Helper ----------------
  const fetchData = useCallback(async (url: string, setter: (data: any) => void, label: string) => {
    try {
      console.log(`Cargando ${label} desde:`, url);
      const res = await axios.get(url);
      setter(res.data.data);
      console.log(`${label} cargados:`, res.data.data);
    } catch (err) {
      console.error(`Error al cargar ${label}:`, err);
    }
  }, []);

  // ---------------- Cargas ----------------
  const cargarMedicos = useCallback(() => {
    if (!fechaSeleccionada) return;
    fetchData(`http://localhost:3000/medicos/${fechaSeleccionada}`, setMedicos, "Médicos");
  }, [fechaSeleccionada, fetchData]);

  const cargarTurnos = useCallback(() => {
    if (!fechaSeleccionada) return;
    fetchData(`http://localhost:3000/turnos/${fechaSeleccionada}`, setTurnos, "Turnos");
  }, [fechaSeleccionada, fetchData]);

  const cargarFichas = useCallback(async () => {
    if (!fechaSeleccionada || !medicoSeleccionado) {
      console.warn("Intento de cargar fichas sin fecha o médico seleccionado");
      alert("Seleccione fecha y médico");
      return;
    }

    const url = turnoSeleccionado
      ? `http://localhost:3000/medicoPeriodo/${fechaSeleccionada}/${medicoSeleccionado}/${turnoSeleccionado}`
      : `http://localhost:3000/medico/${fechaSeleccionada}/${medicoSeleccionado}`;

    await fetchData(url, setFichas, "Fichas");
  }, [fechaSeleccionada, medicoSeleccionado, turnoSeleccionado, fetchData]);

  // ---------------- Llamar siguiente ----------------
  const llamarSiguiente = useCallback(async () => {
    console.log("=== LLAMAR SIGUIENTE ===");
    console.log("Array actual de fichas (antes):", JSON.parse(JSON.stringify(fichas)));

    // Buscar la ficha con menor idFicha en estado "En espera"
    const fichaEnEspera = fichas
      .filter((f) => f.EstadoFicha === "En espera")
      .sort((a, b) => a.idFicha - b.idFicha)[0];

    if (!fichaEnEspera) {
      console.log("No hay fichas en espera.");
      return;
    }

    console.log("Ficha seleccionada para llamar:", fichaEnEspera);

    try {
      // Actualización local inmediata
      setFichas((prev) => {
        const nuevoArray = prev.map((f) =>
          f.idFicha === fichaEnEspera.idFicha ? { ...f, EstadoFicha: "Llamado" } : f
        );
        console.log("Array actualizado (después):", JSON.parse(JSON.stringify(nuevoArray)));
        console.log(
          "¿Es el mismo array? ->",
          prev === nuevoArray ? "Sí (mismo array)" : "No (es un nuevo array)"
        );
        return nuevoArray;
      });

      // Actualizar en backend
      await axios.put(
        `http://localhost:3000/actualizarEstadoFicha/${fichaEnEspera.idFicha}`,
        { estado: 2 } // 2 = Llamado
      );
      console.log(`Estado de ficha ${fichaEnEspera.idFicha} actualizado en backend.`);
    } catch (err) {
      console.error("Error al llamar siguiente:", err);
    }
  }, [fichas]);


  // ---------------- Render ----------------
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
    />
  );
}
