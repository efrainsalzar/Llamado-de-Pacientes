const Ficha = require('../models/fichaModel');

// Obtener fichas del día actual
const getFichasHoy = async (req, res) => {
  try {
    const hoy = new Date().toISOString().split('T')[0]; // YYYY-MM-DD
    const fichas = await Ficha.findAll({
      where: { fecha: hoy }
    });
    res.json(fichas);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error al obtener fichas del día' });
  }
};

// Obtener fichas por fecha
const getFichasporFecha = async (req, res) => {
  try {
    const { fecha } = req.params;
    const fichas = await Ficha.findAll({        
        where: { fecha }
        });
    res.json(fichas);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error al obtener fichas por fecha' });
  }
}; 

// Crear ficha
async function crearFicha(req, res) {
  try {
    const { id_paciente, consultorio } = req.body;

    if (!id_paciente) {
      return res.status(400).json({ success: false, message: "id_paciente es obligatorio" });
    }

    const now = new Date();
    const fecha = now.toISOString().split('T')[0]; // YYYY-MM-DD
    const hora_registro = now.toTimeString().split(' ')[0]; // HH:MM:SS

    const ficha = await Ficha.create({
      id_paciente,
      consultorio,
      fecha,
      hora_registro
    });

    res.status(201).json({
      success: true,
      message: "Ficha creada correctamente",
      data: ficha
    });

  } catch (error) {
    console.error("Error al crear ficha:", error);

    if (error.name === 'SequelizeValidationError') {
      return res.status(400).json({
        success: false,
        message: error.errors.map(e => e.message).join(', ')
      });
    }

    res.status(500).json({ success: false, message: "Error interno del servidor" });
  }
}



module.exports = { getFichasHoy, getFichasporFecha, crearFicha };

