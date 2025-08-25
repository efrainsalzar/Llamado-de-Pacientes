const { obtenerFichasPorFecha } = require('../models/fichaModel');

// Funciones de formateo
function formatDate(date) {
  return date ? date.toISOString().split('T')[0] : null; // YYYY-MM-DD
}

function formatTime(time) {
  return time ? time.toTimeString().split(' ')[0] : null; // HH:MM:SS
}

async function getFichas(req, res) {
  try {
    const fecha = req.query.fecha || new Date(); 
    const fichas = await obtenerFichasPorFecha(fecha);

    const fichasFormateadas = fichas.map(ficha => ({
      id_ficha: ficha.id_ficha,
      id_paciente: ficha.id_paciente,
      fecha: formatDate(ficha.fecha),
      estado: ficha.estado,
      consultorio: ficha.consultorio,
      hora_registro: formatTime(ficha.hora_registro),
      hora_llamado: formatTime(ficha.hora_llamado),
      hora_finalizacion: formatTime(ficha.hora_finalizacion)
    }));

    res.status(200).json({
      success: true,
      data: fichasFormateadas
    });
  } catch (error) {
    console.error("Error al obtener fichas:", error);
    res.status(500).json({
      success: false,
      message: "Error interno del servidor"
    });
  }
}

module.exports = { getFichas };
