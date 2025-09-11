interface Props {
  medicos: { Medico: string }[];
  turnos: { Turno: string }[];
  fichas: any[];
  fechaSeleccionada: string;
  medicoSeleccionado: string;
  turnoSeleccionado: string;
  setFechaSeleccionada: (val: string) => void;
  setMedicoSeleccionado: (val: string) => void;
  setTurnoSeleccionado: (val: string) => void;
  cargarMedicos: () => void;
  cargarTurnos: () => void;
  cargarFichas: () => void;
llamarSiguiente: () => void;
}

export default function UsuariosVista(props: Props) {
  const {
    medicos,
    turnos,
    fichas,
    fechaSeleccionada,
    medicoSeleccionado,
    turnoSeleccionado,
    setFechaSeleccionada,
    setMedicoSeleccionado,
    setTurnoSeleccionado,
    cargarMedicos,
    cargarTurnos,
    cargarFichas,
    llamarSiguiente
  } = props;

  return (
    <div style={{ padding: "20px" }}>
      <h1>Lista de Fichas por Médico</h1>

      {/* Filtros */}
      <div style={{ marginBottom: "20px" }}>
        <label>
          Fecha:
          <input
            type="date"
            value={fechaSeleccionada}
            onChange={(e) => setFechaSeleccionada(e.target.value)}
            onBlur={() => {
              cargarMedicos();
              cargarTurnos();
            }}
          />
        </label>

        <label style={{ marginLeft: "10px" }}>
          Médico:
          <select
            value={medicoSeleccionado}
            onChange={(e) => setMedicoSeleccionado(e.target.value)}
          >
            <option value="">Seleccione médico</option>
            {medicos.map((m) => (
              <option key={m.Medico} value={m.Medico}>
                {m.Medico}
              </option>
            ))}
          </select>
        </label>

        <label style={{ marginLeft: "10px" }}>
          Turno:
          <select
            value={turnoSeleccionado}
            onChange={(e) => setTurnoSeleccionado(e.target.value)}
          >
            <option value="">Seleccione turno</option>
            {turnos.map((t) => (
              <option key={t.Turno} value={t.Turno}>
                {t.Turno}
              </option>
            ))}
          </select>
        </label>

        <button onClick={cargarFichas} style={{ marginLeft: "10px" }}>
          Buscar todas las fichas
        </button>
      </div>

      {/* Tabla de fichas */}
      {fichas.length > 0 ? (
        <table border={1} cellPadding={5}>
          <thead>
            <tr>
              <th>N° Ficha</th>
              <th>Ticket</th>
              <th>Periodo</th>
              <th>Paciente</th>
              <th>Especialidad</th>
              <th>Estado</th>
            </tr>
          </thead>
          <tbody>
            {fichas.map((f) => (
              <tr key={f.idFicha}>
                <td>{f.Ficha}</td>
                <td>{f.Ticket}</td>
                <td>{f.Periodo}</td>
                <td>{f.paciente}</td>
                <td>{f.Especialidad}</td>
                <td>{f.EstadoFicha}</td>
              </tr>
            ))}
          </tbody>
        </table>
      ) : (
        <p>No hay fichas para la fecha, médico o turno seleccionados.</p>
      )}
      <button onClick={llamarSiguiente} style={{ marginTop: "10px" }}>
        Llamar siguiente
        </button>

    </div>
    
    
    
  );
  
}
