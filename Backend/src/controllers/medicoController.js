const { sequelize } = require("../config/db");
const { getIO, makeRoomName } = require("../config/socket");

// ======= UTILIDADES =======

/**
 * Buscar ficha por ID
 */
const findFichaById = async (idFicha) => {
  const [result] = await sequelize.query(
    `SELECT * FROM dbo.tblEstadoVista WHERE idFichas = :idFicha`,
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
 * Ejecutar consulta genérica y opcional periodo
 */
const getFichas = async ({ idProfesional, periodo }) => {
  let query = `
    SELECT 
        IDFicha,
        Ficha,
        Periodo,
        CONVERT(varchar(10), Inicio, 23) AS FechaInicio,
        Horario,
        Ticket,
        paciente,
        Servicio,
        IDProfesional,
        medico,
        DesEstadoVista
    FROM dbo.vwFICHASPROGRAMADASV3
    WHERE IDProfesional = :idProfesional
  `;
  const replacements = { idProfesional };

  if (periodo) {
    query += ` AND Periodo = :periodo`;
    replacements.periodo = periodo;
  }

  query += ` ORDER BY ${periodo ? "idFicha" : "Periodo, idFicha"}`;

  const [fichas] = await sequelize.query(query, { replacements });
  return fichas;
};

// ======= CONTROLADORES =======

const obtenerFichasMedico = async (req, res) => {
  try {
    const { idProfesional } = req.params;
    if (!idProfesional)
      return res.status(400).json({
        success: false,
        message: "Faltan parámetros: idProfesional del medico",
      });

    const fichas = await getFichas({ idProfesional });
    res.json({ success: true, data: fichas });
  } catch (error) {
    console.error("[ERROR fichas profesional]", error.message);
    res.status(500).json({
      success: false,
      message: "Error al obtener fichas del médico",
      error: error.message,
    });
  }
};
const obtenerFichasMedicoPeriodo = async (req, res) => {
  try {
    const { idProfesional, periodo } = req.params;
    if (!idProfesional)
      return res.status(400).json({
        success: false,
        message: "Faltan parámetros: idProfesional o periodo",
      });

    const fichas = await getFichas({ idProfesional, periodo });
    res.json({ success: true, data: fichas });
  } catch (error) {
    console.error("[ERROR idProfesional o periodo]", error.message);
    res.status(500).json({
      success: false,
      message: "Error al obtener fichas del médico y periodo",
      error: error.message,
    });
  }
};

const actualizarEstadoFicha = async (req, res) => {
  try {
    const { idFicha } = req.params;
    const { estado } = req.body;

    /*console.log(
      `[LOG] Solicitud de actualización recibida: idFicha=${idFicha}, estado=${estado}`
    );*/

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
      `UPDATE tblEstadoVista SET idEstado = :estado WHERE idFichas = :idFicha`,
      { replacements: { idFicha, estado } }
    );

    // Recuperar ficha actualizada
    const [result] = await sequelize.query(
      `SELECT * FROM dbo.vwFICHASPROGRAMADASV3 WHERE IDFicha = :idFicha`,
      { replacements: { idFicha } }
    );
    const fichaActualizada = result[0];
    console.log(
      `[LOG] Ficha después de UPDATE: IDFicha=${fichaActualizada.IDFicha}, IDEstado=${fichaActualizada.idEstadoVista}`
    );
    // Emitir evento por socket
    const io = getIO();
    const roomMedico = makeRoomName(fichaActualizada.IDProfesional);
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

module.exports = {
  obtenerFichasMedico,
  obtenerFichasMedicoPeriodo,
  actualizarEstadoFicha,
};
