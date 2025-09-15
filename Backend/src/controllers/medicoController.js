const { sequelize } = require("../config/db");
const { getIO } = require("../config/socket");

// ======= UTILIDADES =======

function makeRoomName(medico, fecha) {
  return `room_${medico}_${fecha}`;
}

/**
 * Buscar ficha por ID
 */
const findFichaById = async (idFicha) => {
  const [result] = await sequelize.query(
    `SELECT * FROM dbo.tblFICHAS WHERE IDFicha = :idFicha`,
    { replacements: { idFicha } }
  );
  return result[0] || null;
};

/**
 * Validar estado permitido
 */
const validarEstado = (estado) => {
  const estadosPermitidos = {
    1: "en espera",
    2: "llamado",
    3: "atendido",
    4: "cancelado",
  };
  return estadosPermitidos[estado] ? estadosPermitidos[estado] : null;
};

/**
 * Ejecutar consulta genérica para fichas por médico, fecha y opcional periodo
 */
const getFichas = async ({ medico, fecha, periodo }) => {
  let query = `
    SELECT 
        idFicha,
        Ficha,
        Periodo,
        CONVERT(varchar(10), Inicio, 23) AS FechaInicio,
        Horario,
        Ticket,
        paciente,
        Descripcion AS Especialidad,
        medico,
        EstadoFicha
    FROM dbo.vwFICHASPROGRAMADASV2
    WHERE CONVERT(date, Inicio) = :fecha
      AND medico LIKE :medico
  `;
  const replacements = { fecha, medico: `%${medico}%` };

  if (periodo) {
    query += ` AND Periodo = :periodo`;
    replacements.periodo = periodo;
  }

  query += ` ORDER BY ${periodo ? "idFicha" : "Periodo, idFicha"}`;

  const [fichas] = await sequelize.query(query, { replacements });
  return fichas;
};

// ======= CONTROLADORES =======

const BuscarIdFicha = async (req, res) => {
  try {
    const { idFicha } = req.params;
    if (!idFicha)
      return res
        .status(400)
        .json({ success: false, message: "Falta el parámetro: idFicha" });

    const ficha = await findFichaById(idFicha);
    if (!ficha)
      return res.status(404).json({
        success: false,
        message: `No se encontró ficha con ID ${idFicha}`,
      });

    res.json({ success: true, data: ficha });
  } catch (error) {
    console.error("[ERROR BuscarIdFicha]", error);
    res.status(500).json({
      success: false,
      message: "Error al obtener ficha por ID",
      error: error.message,
    });
  }
};

const actualizarEstadoFicha = async (req, res) => {
  try {
    const { idFicha } = req.params;
    const { estado } = req.body;

    console.log(
      `[LOG] Solicitud de actualización recibida: idFicha=${idFicha}, estado=${estado}`
    );

    if (!idFicha || !estado)
      return res.status(400).json({
        success: false,
        message: "Parámetros requeridos: idFicha y estado",
      });

    const estadoNombre = validarEstado(estado);
    if (!estadoNombre)
      return res.status(400).json({
        success: false,
        message: `Estado inválido. Valores permitidos: 1,2,3,4`,
      });

    const ficha = await findFichaById(idFicha);
    if (!ficha)
      return res.status(404).json({
        success: false,
        message: `No se encontró ficha con ID ${idFicha}`,
      });

    console.log(`[LOG] Ficha actual antes de UPDATE:`, ficha);

    // Actualizar estado
    await sequelize.query(
      `UPDATE dbo.tblFICHAS SET EstadoFicha = :estado WHERE IDFicha = :idFicha`,
      { replacements: { idFicha, estado } }
    );

    // Recuperar ficha actualizada
    const [result] = await sequelize.query(
      `SELECT * FROM dbo.vwFICHASPROGRAMADASV2 WHERE IDFicha = :idFicha`,
      { replacements: { idFicha } }
    );
    const fichaActualizada = result[0];
    console.log(`[LOG] Ficha después de UPDATE:`, fichaActualizada);
    // Emitir evento por socket
    const io = getIO();
    const roomMedico = makeRoomName(
      fichaActualizada.medico,
      fichaActualizada.FechaInicio
    );
    // Emitir solo a la room del médico y además a la pantalla pública
    io.to(roomMedico).emit("fichaActualizada", fichaActualizada);
    io.to("pantalla_publica").emit("fichaActualizada", fichaActualizada);
    console.log(
      `[LOG] Emitido a room ${roomMedico} y pantalla_publica para idFicha=${idFicha}`
    );
    res.json({
      success: true,
      message: `Estado actualizado a '${estadoNombre}'`,
      data: fichaActualizada,
    });
  } catch (error) {
    console.error("[ERROR actualizarEstadoFicha]", error);
    res.status(500).json({
      success: false,
      message: "Error al actualizar estado de la ficha",
      error: error.message,
    });
  }
};

// Consultas simples de valores únicos (medico, turno)
const getValoresUnicos = async (req, res, campo, mensajeError) => {
  try {
    const { fecha } = req.params;
    const [result] = await sequelize.query(
      `
      SELECT DISTINCT ${campo} 
      FROM dbo.vwFICHASPROGRAMADAS
      WHERE CONVERT(date, Inicio) = :fecha
    `,
      { replacements: { fecha } }
    );

    res.json({ success: true, data: result });
  } catch (error) {
    console.error(`[ERROR ${mensajeError}]`, error.message);
    res.status(500).json({
      success: false,
      message: `Error al obtener ${mensajeError}`,
      error: error.message,
    });
  }
};

const getMedico = (req, res) =>
  getValoresUnicos(req, res, "medico AS Medico", "medicos");
const getTurno = (req, res) =>
  getValoresUnicos(req, res, "Periodo AS Turno", "turnos");

const obtenerFichasPorMedico = async (req, res) => {
  try {
    const { medico, fecha } = req.params;
    if (!medico || !fecha)
      return res
        .status(400)
        .json({ success: false, message: "Faltan parámetros: medico o fecha" });

    const fichas = await getFichas({ medico, fecha });
    res.json({ success: true, data: fichas });
  } catch (error) {
    console.error("[ERROR fichas por medicos]", error.message);
    res.status(500).json({
      success: false,
      message: "Error al obtener fichas del médico",
      error: error.message,
    });
  }
};

const obtenerFichasPorMedicoPeriodo = async (req, res) => {
  try {
    const { medico, fecha, periodo } = req.params;
    if (!medico || !fecha)
      return res
        .status(400)
        .json({ success: false, message: "Faltan parámetros: medico o fecha" });

    const fichas = await getFichas({ medico, fecha, periodo });
    res.json({ success: true, data: fichas });
  } catch (error) {
    console.error("[ERROR fichas por medicos periodo]", error.message);
    res.status(500).json({
      success: false,
      message: "Error al obtener fichas del médico",
      error: error.message,
    });
  }
};

module.exports = {
  BuscarIdFicha,
  actualizarEstadoFicha,
  getMedico,
  getTurno,
  obtenerFichasPorMedico,
  obtenerFichasPorMedicoPeriodo,
};
