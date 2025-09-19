//import { Servicio } from "./Fichas";
import { Ficha, Especialidad } from "../../types/Ficha";



interface Props {
  fichas: Ficha[];
  especialidades: Especialidad[];
  //fechaSeleccionada: string;
  especialidadSeleccionada: string;
  //setFechaSeleccionada: (fecha: string) => void;
  setEspecialidadSeleccionada: (esp: string) => void;
  cargarEspecialidades: () => void;
  cargarFichas: () => void;
}

export default function FichasVista({
  fichas,
  especialidades,
  especialidadSeleccionada,

  setEspecialidadSeleccionada,
  cargarEspecialidades,
  cargarFichas,
}: Props) {
  return (
    <div style={{ padding: "20px" }}>
      <h1>Lista de Fichas</h1>

      {/* Filtros */}
      <div style={{ marginBottom: "20px" }}>
        <label style={{ marginLeft: "10px" }}>
          Especialidad:
          <select
            value={especialidadSeleccionada}
            onChange={(e) => setEspecialidadSeleccionada(e.target.value)}
            onFocus={() => {
              // Solo cargar si no hay especialidades
              if (especialidades.length === 0) {
                cargarEspecialidades();
              }
            }}
          >
            <option value="">--Seleccione especialidad--</option>
            {especialidades.map((esp) => (
              <option key={esp.CUA_CODIGO} value={esp.Especialidad}>
                {esp.Especialidad}
              </option>
            ))}
          </select>
        </label>

        <button onClick={cargarFichas} style={{ marginLeft: "10px" }}>
          Buscar
        </button>
      </div>

      {/* Fichas llamadas actualmente */}
      <div style={{ marginBottom: "20px" }}>
        <h2>Fichas en Llamado</h2>
        {fichas.filter(f => f.DesEstadoVista === "Llamado").length > 0 ? (
          <div style={{ display: "flex", flexWrap: "wrap", gap: "15px" }}>
            {fichas
              .filter(f => f.DesEstadoVista === "Llamado")
              .map((f) => (
                <div
                  key={f.IDFicha}
                  style={{
                    flex: "1 0 250px",
                    padding: "15px",
                    borderRadius: "8px",
                    border: "2px solid #ffffffff",
                  }}
                >
                  <p><strong>Ficha:</strong> {f.Ficha}</p>
                  <p><strong>Ticket:</strong> {f.Ticket}</p>
                  <p><strong>Paciente:</strong> {f.paciente}</p>
                  <p><strong>Médico:</strong> {f.medico}</p>
                  <p><strong>Especialidad:</strong> {f.Servicio}</p>
                  <p><strong>Horario:</strong> {f.Horario}</p>
                </div>
              ))}
          </div>
        ) : (
          <p style={{ color: "#666" }}>No hay fichas siendo llamadas actualmente.</p>
        )}
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
            {fichas.map((f/*, index*/) => {
              /*console.log("Renderizando fila:", {
                index,
                IDFicha: f.IDFicha,
                keyUsada: f.IDFicha ?? `fallback-${index}`,
              });*/

              return (
                <tr key={f.IDFicha /*?? `fallback-${index}`*/}>
                  <td>{f.Ficha}</td>
                  <td>{f.Ticket}</td>
                  <td>{f.Periodo}</td>
                  <td>{f.FechaInicio}</td>
                  <td>{f.Horario}</td>
                  <td>{f.paciente}</td>
                  <td>{f.Servicio}</td>
                  <td>{f.medico}</td>
                  <td>{f.DesEstadoVista}</td>
                </tr>
              );
            })}
          </tbody>

        </table>
      ) : (
        <p>No hay fichas para la fecha y especialidad seleccionadas.</p>
      )}
    </div>
  );
}
