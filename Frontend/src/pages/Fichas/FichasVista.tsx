import { Ficha, Especialidad } from "./Fichas";

interface Props {
  fichas: Ficha[];
  especialidades: Especialidad[];
  fechaSeleccionada: string;
  especialidadSeleccionada: string;
  setFechaSeleccionada: (fecha: string) => void;
  setEspecialidadSeleccionada: (esp: string) => void;
  cargarEspecialidades: () => void;
  cargarFichas: () => void;
}

export default function FichasHtml({
  fichas,
  especialidades,
  fechaSeleccionada,
  especialidadSeleccionada,
  setFechaSeleccionada,
  setEspecialidadSeleccionada,
  cargarEspecialidades,
  cargarFichas,
}: Props) {
  return (
    <div style={{ padding: "20px" }}>
      <h1>Lista de Fichas</h1>

      {/* Filtros */}
      <div style={{ marginBottom: "20px" }}>
        <label>
          Fecha:
          <input
            type="date"
            value={fechaSeleccionada}
            onChange={(e) => setFechaSeleccionada(e.target.value)}
            onBlur={cargarEspecialidades}
          />
        </label>

        <label style={{ marginLeft: "10px" }}>
          Especialidad:
          <select
            value={especialidadSeleccionada}
            onChange={(e) => setEspecialidadSeleccionada(e.target.value)}
          >
            <option value="">Seleccione especialidad</option>
            {especialidades.map((esp) => (
              <option key={esp.Especialidad} value={esp.Especialidad}>
                {esp.Especialidad}
              </option>
            ))}
          </select>
        </label>

        <button onClick={cargarFichas} style={{ marginLeft: "10px" }}>
          Buscar
        </button>
      </div>

      {/* Tabla */}
      {fichas.length > 0 ? (
        <table border={1} cellPadding={5}>
          <thead>
            <tr>
              <th>N° Ficha</th>
              <th>Ticket</th>
              <th>Periodo</th>
              <th>Fecha</th>
              <th>Horario</th>
              <th>Paciente</th>
              <th>Especialidad</th>
              <th>Médico</th>
              <th>Estado</th>
            </tr>
          </thead>
          <tbody>
            {fichas.map((f) => (
              <tr key={f.idFicha}>
                <td>{f.Ficha}</td>
                <td>{f.Ticket}</td>
                <td>{f.Periodo}</td>
                <td>{f.FechaInicio}</td>
                <td>{f.Horario}</td>
                <td>{f.paciente}</td>
                <td>{f.Especialidad}</td>
                <td>{f.medico}</td>
                <td>{f.EstadoFicha}</td>
              </tr>
            ))}
          </tbody>
        </table>
      ) : (
        <p>No hay fichas para la fecha y especialidad seleccionadas.</p>
      )}
    </div>
  );
}
