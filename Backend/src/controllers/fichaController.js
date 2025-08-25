const Ficha = require("../models/fichaModel");

// Obtener fichas del día actual
const getFichasHoy = async (req, res) => {
  try {
    const hoy = new Date().toISOString().split("T")[0]; // YYYY-MM-DD
    const fichas = await Ficha.findAll({
      where: { fecha: hoy },
    });
    res.json(fichas);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error al obtener fichas del día" });
  }
};

// Obtener fichas por fecha
const getFichasporFecha = async (req, res) => {
  try {
    const { fecha } = req.params;
    const fichas = await Ficha.findAll({
      where: { fecha },
    });
    res.json(fichas);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error al obtener fichas por fecha" });
  }
};

// Crear ficha
async function crearFicha(req, res) {
  try {
    const { id_paciente, consultorio } = req.body;

    if (!id_paciente) {
      return res
        .status(400)
        .json({ success: false, message: "id_paciente es obligatorio" });
    }

    const now = new Date();
    const fecha = now.toISOString().split("T")[0]; // YYYY-MM-DD
    const hora_registro = now.toTimeString().split(" ")[0]; // HH:MM:SS

    const ficha = await Ficha.create({
      id_paciente,
      consultorio,
      fecha,
      hora_registro,
    });

    res.status(201).json({
      success: true,
      message: "Ficha creada correctamente",
      data: ficha,
    });
  } catch (error) {
    console.error("Error al crear ficha:", error);

    if (error.name === "SequelizeValidationError") {
      return res.status(400).json({
        success: false,
        message: error.errors.map((e) => e.message).join(", "),
      });
    }

    res
      .status(500)
      .json({ success: false, message: "Error interno del servidor" });
  }
}

// Función para llamar al siguiente paciente
const llamarSiguientePaciente = async () => {
  const hoy = new Date().toISOString().split("T")[0];

  // Buscar la primera ficha en espera del día actual
  const ficha = await Ficha.findOne({
    where: { fecha: hoy, estado: "espera" },
    order: [["hora_registro", "ASC"]],
  });

  if (!ficha) return null; // No hay pacientes en espera

  const now = new Date();
  ficha.estado = "atendiendo";
  ficha.hora_llamado = now.toTimeString().split(" ")[0];
  await ficha.save();

  return ficha;
};

// POST para iniciar atención (llama al primer paciente)
const iniciarAtencion = async (req, res) => {
  try {
    const ficha = await llamarSiguientePaciente();
    if (!ficha)
      return res.status(404).json({ message: "No hay pacientes en espera" });
    res.json({ message: "Paciente llamado", ficha });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error al iniciar atención" });
  }
};

// POST para finalizar atención de un paciente
const finalizarAtencion = async (req, res) => {
  try {
    const { id_ficha } = req.params;
    const fichaActual = await Ficha.findByPk(id_ficha);
    if (!fichaActual)
      return res.status(404).json({ message: "Ficha no encontrada" });

    fichaActual.estado = "atendido";
    fichaActual.hora_finalizacion = new Date().toTimeString().split(" ")[0];
    await fichaActual.save();

    res.json({
      message: "Atención finalizada",
      fichaActual
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error al finalizar atención" });
  }
};

// cantidad de fichas en espera
const cancelarAtencion = async (req, res) => {
  try {
    const { id_ficha } = req.params;
    const fichaActual = await Ficha.findByPk(id_ficha);
    if (!fichaActual)
      return res.status(404).json({ message: "Ficha no encontrada" });

    fichaActual.estado = "ausente";
    fichaActual.hora_llamado = new Date().toTimeString().split(" ")[0];
    fichaActual.hora_finalizacion = new Date().toTimeString().split(" ")[0];
    await fichaActual.save();

    res.json({
      message: "Atención Cancelada",
      fichaActual
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Error al cancelar atención" });
  }
};
module.exports = {
  getFichasHoy,
  getFichasporFecha,
  crearFicha,
  iniciarAtencion,
  finalizarAtencion,
  cancelarAtencion
};
