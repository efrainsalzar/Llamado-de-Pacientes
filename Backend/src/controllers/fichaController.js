//const Ficha = require("../models/fichaModel");
const {sequelize} = require("../config/db");
//const { getIO } = require("../config/socket");

// ======= CONSULTAS ESPECÍFICAS =======


const getEspecialidad = async (req, res) => {
  try {
    const { fecha } = req.params; 

    const [fichas] = await sequelize.query(`
      SELECT DISTINCT
        CUA_CODIGO,
	      Servicio AS Especialidad
      FROM dbo.vwFICHASPROGRAMADASV3
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


const obtenerFichasPublicas = async (req, res) => {
  try {
    const { especialidad } = req.params; 
    const [fichas] = await sequelize.query(
      `
        SELECT 
          IDFicha,
          Ficha,
          Periodo,
          DesEstadoVista,
          CONVERT(date, Inicio) AS FechaInicio,
          Horario,
          Ticket,
          paciente,
          Servicio,
          medico,
          Consultorio
        FROM dbo.vwFICHASPROGRAMADASV4
        WHERE 
        Servicio = :especialidad
        ORDER BY Periodo, Ficha;
      `, {
      replacements: { especialidad }
    });

    res.status(200).json({
      success: true,
      data: fichas
    });
  } catch (error) {
    console.error("[ERROR obtener Fichas Publicas]", error.message);
    res.status(500).json({
      success: false,
      message: "Error al obtener fichas públicas",
      error: error.message
    });
  }
};


module.exports = {
  getEspecialidad,
  obtenerFichasPublicas,
};
