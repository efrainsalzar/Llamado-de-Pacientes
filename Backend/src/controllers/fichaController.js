//const Ficha = require("../models/fichaModel");
const sequelize = require("../config/db");
//const { getIO } = require("../config/socket");

// ======= CONSULTAS ESPECÍFICAS =======


const getEspecialidad = async (req, res) => {
  try {
    const { fecha } = req.params; 

    const [fichas] = await sequelize.query(`
      SELECT DISTINCT
          Descripcion AS Especialidad
      FROM dbo.vwFICHASPROGRAMADAS;
    `, {
      replacements: { fecha }
    });

    res.status(200).json({
      success: true,
      data: fichas
    });
  } catch (error) {
    console.error("[ERROR getEspecialidades]", error.message);
    res.status(500).json({
      success: false,
      message: "Error al obtener Espec",
      error: error.message
    });
  }
};

const getMedico = async (req, res) => {
  try {
    const { fecha } = req.params; 

    const [fichas] = await sequelize.query(`
      SELECT DISTINCT
        medico AS Medico
    FROM dbo.vwFICHASPROGRAMADAS
    WHERE CONVERT(date, Inicio) = :fecha
    `, {
      replacements: { fecha }
    });

    res.status(200).json({
      success: true,
      data: fichas
    });
  } catch (error) {
    console.error("[ERROR getEspecialidades]", error.message);
    res.status(500).json({
      success: false,
      message: "Error al obtener Espec",
      error: error.message
    });
  }
};

const getTurno = async (req, res) => {
  try {
    const { fecha } = req.params; 

    const [fichas] = await sequelize.query(`
      SELECT DISTINCT
        Periodo AS Turno
    FROM dbo.vwFICHASPROGRAMADAS
    WHERE CONVERT(date, Inicio) = :fecha
    `, {
      replacements: { fecha }
    });

    res.status(200).json({
      success: true,
      data: fichas
    });
  } catch (error) {
    console.error("[ERROR getTurnos]", error.message);
    res.status(500).json({
      success: false,
      message: "Error al obtener turnos",
      error: error.message
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

const obtenerFichasPorMedico = async (req, res) => {
  try {
    const { medico, fecha } = req.params;

    if (!medico || !fecha) {
      return res.status(400).json({
        success: false,
        message: "Faltan parámetros: medico o fecha"
      });
    }

    //console.log(`Buscando fichas para el médico: ${medico} en la fecha: ${fecha}`);

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
      WHERE Inicio >= :fecha
        AND Inicio < DATEADD(day, 1, :fecha)
        AND medico LIKE :medico
      ORDER BY Periodo, Ficha;
    `, {
      replacements: { fecha, medico: `%${medico}%` }
    });

    res.status(200).json({
      success: true,
      data: fichas
    });

  } catch (error) {
    console.error("[ERROR fichas por medicos]", error.message);
    res.status(500).json({
      success: false,
      message: "Error al obtener fichas del médico",
      error: error.message
    });
  }
};



module.exports = {
  getEspecialidad,
  obtenerFichasPublicasPorFecha,
  obtenerFichasPorMedico,
  getMedico
  ,getTurno
};
