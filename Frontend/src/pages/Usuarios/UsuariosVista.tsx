import { Ficha } from "../../types/Ficha";

interface Props {
  fichas: Ficha[];
  cargarFichas: () => void;

  llamarSiguiente: () => void;
  atenderSiguiente: () => void;
  reiniciarSiguiente: () => void;
  cancelarSiguiente: () => void;
}

export default function UsuariosVista(props: Props) {
  const {
    fichas,
    cargarFichas,
    llamarSiguiente,
    atenderSiguiente,
    reiniciarSiguiente,
    cancelarSiguiente,
  } = props;

  return (
    <div style={{ padding: "20px" }}>
      <h1>Lista de Fichas Médico</h1>

      {/* Filtros */}
      <div style={{ marginBottom: "20px" }}>

        <label style={{ marginLeft: "10px" }}>
          Turno:
          <select>
            <option value="">Seleccione turno</option>
            <option>mañana</option>
            <option>tarde</option>
          </select>
        </label>

        <button
          onClick={() => {
            //console.log(`[UI] Cargando fichas para ${medicoSeleccionado} en ${fechaSeleccionada}`);
            cargarFichas();
          }}
          style={{ marginLeft: "10px" }}
        >
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
              <tr key={f.IDFicha}>
                <td>{f.Ficha}</td>
                <td>{f.Ticket}</td>
                <td>{f.Periodo}</td>
                <td>{f.paciente}</td>
                <td>{f.Servicio}</td>
                <td>{f.DesEstadoVista}</td>
              </tr>
            ))}
          </tbody>
        </table>
      ) : (
        <p>No hay fichas para la fecha, médico o turno seleccionados.</p>
      )}
      <button onClick={llamarSiguiente}>Llamar siguiente</button>
      <button onClick={atenderSiguiente}>Atender ficha</button>
      <button onClick={reiniciarSiguiente}>Reiniciar ficha</button>
      <button onClick={cancelarSiguiente}>Cancelar ficha</button>

    </div>
  );
}
