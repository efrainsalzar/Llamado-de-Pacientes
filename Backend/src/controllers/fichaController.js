//const Ficha = require("../models/fichaModel");
const {sequelize} = require("../config/db");
//const { getIO } = require("../config/socket");

// ======= CONSULTAS ESPECÍFICAS =======


const getEspecialidad = async (req, res) => {
  try {
    const { fecha } = req.params; 

    const [fichas] = await sequelize.query(`
      SELECT DISTINCT
          Descripcion AS Especialidad
      FROM dbo.vwFICHASPROGRAMADAS
      WHERE CONVERT(date, Inicio) = :fecha;
    `, {
      replacements: { fecha }
    });

    res.status(200).json({
      success: true,
      data: fichas
    });
  } catch (error) {
    console.error("[ERROR getEspecialidades] Mensaje:", error.message);

    // Mostrar el objeto completo del error
    console.error("[ERROR completo]", error);

    // Si viene info adicional en original / parent (propio de mssql o tedious)
    if (error.original) {
      console.error("[ERROR original]", error.original);
    }
    if (error.parent) {
      console.error("[ERROR parent]", error.parent);
    }

    res.status(500).json({
      success: false,
      message: "Error al obtener Espec",
      error: error.message,
      detalle: error.original ? error.original.message : null
    });
  }
};


const obtenerFichasPublicasPorFecha = async (req, res) => {
  try {
    const { especialidad ,fecha } = req.params; 
    const [fichas] = await sequelize.query(`
      SELECT 
          idFicha,
          Ficha,
          Periodo,
          CONVERT(date, Inicio) AS FechaInicio,
          Horario,
          Ticket,
          paciente,
          Descripcion AS Especialidad,
          medico,
          EstadoFicha
      FROM dbo.vwFICHASPROGRAMADASV2
      WHERE CONVERT(date, Inicio) = :fecha 
      AND Descripcion = :especialidad
      ORDER BY Periodo, Ficha;
    `, {
      replacements: { fecha, especialidad }
    });

    res.status(200).json({
      success: true,
      data: fichas
    });
  } catch (error) {
    console.error("[ERROR obtenerFichasPublicasPorFecha]", error.message);
    res.status(500).json({
      success: false,
      message: "Error al obtener fichas públicas",
      error: error.message
    });
  }
};


module.exports = {
  getEspecialidad,
  obtenerFichasPublicasPorFecha,
};
