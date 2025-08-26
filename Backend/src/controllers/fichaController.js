const Ficha = require("../models/fichaModel");
const sequelize = require("../config/db");

// Función auxiliar: obtener fecha en formato 'YYYY-MM-DD'
const hoyString = () => new Date().toISOString().split("T")[0];
// Función auxiliar: obtener hora en 'HH:MM:SS'
const horaString = () => new Date().toTimeString().split(" ")[0];

// ======= CONSULTAS =======

// Obtener todas las fichas
const obtenerFichas = async (req, res) => {
  try {
    const fichas = await Ficha.findAll({
      attributes: [
        "id_ficha",
        "id_paciente",
        "consultorio",
        "estado",
        [sequelize.literal("CONVERT(varchar, fecha, 23)"), "fecha"],
        [sequelize.literal("CONVERT(varchar, hora_registro, 8)"), "hora_registro"],
        [sequelize.literal("CONVERT(varchar, hora_llamado, 8)"), "hora_llamado"],
        [sequelize.literal("CONVERT(varchar, hora_finalizacion, 8)"), "hora_finalizacion"]
      ],
      raw: true
    });

    res.status(200).json(/*{ success: true, data: {*/ fichas /*} }*/);
  } catch (error) {
    console.error("[ERROR] obtenerFichas:", error.message);
    res.status(500).json({ success: false, message: "Error al obtener las fichas", error: error.message });
  }
};

// Obtener fichas del día actual
const getFichasHoy = async (req, res) => {
  try {
    const fichas = await Ficha.findAll({ where: { fecha: hoyString() } });
    res.json(fichas);
  } catch (error) {
    console.error("[ERROR] getFichasHoy:", error.message);
    res.status(500).json({ message: "Error al obtener fichas del día" });
  }
};

// Obtener fichas por fecha
const getFichasporFecha = async (req, res) => {
  try {
    const { fecha } = req.params;
    const fichas = await Ficha.findAll({ where: { fecha } });
    res.json(fichas);
  } catch (error) {
    console.error("[ERROR] getFichasporFecha:", error.message);
    res.status(500).json({ message: "Error al obtener fichas por fecha" });
  }
};

// Obtener fichas de un consultorio específico hoy
const getFichasConsultorio = async (req, res) => {
  try {
    const { consultorio } = req.params;
    if (!consultorio) return res.status(400).json({ message: "Debe proporcionar el consultorio" });

    const fichas = await Ficha.findAll({ where: { fecha: hoyString(), consultorio } });

    if (!fichas.length) {
      return res.status(404).json({ message: `No se encontraron fichas para el consultorio "${consultorio}"` });
    }

    res.status(200).json(fichas);
  } catch (error) {
    console.error("[ERROR] getFichasConsultorio:", error.message);
    res.status(500).json({ message: "Error al obtener fichas por consultorio", error: error.message });
  }
};

// ======= CREACIÓN Y ATENCIÓN =======

// Crear ficha
const crearFicha = async (req, res) => {
  try {
    const { id_paciente, consultorio } = req.body;
    if (!id_paciente) return res.status(400).json({ success: false, message: "id_paciente es obligatorio" });

    const ficha = await Ficha.create({ id_paciente, consultorio, estado: "espera" });

    res.status(201).json({ success: true, message: "Ficha creada correctamente", data: ficha });
  } catch (error) {
    console.error("[ERROR] crearFicha:", error.message);
    if (error.name === "SequelizeValidationError") {
      return res.status(400).json({ success: false, message: error.errors.map(e => e.message).join(", ") });
    }
    res.status(500).json({ success: false, message: "Error interno del servidor" });
  }
};

// Función auxiliar: llamar siguiente paciente en espera
const llamarSiguientePaciente = async () => {
  const ficha = await Ficha.findOne({
    where: { fecha: hoyString(), estado: "espera" },
    order: [["hora_registro", "ASC"]]
  });

  if (!ficha) return null;

  ficha.estado = "atendiendo";
  ficha.hora_llamado = horaString();
  await ficha.save();

  return ficha;
};

// Iniciar atención (llama al primer paciente)
const iniciarAtencion = async (req, res) => {
  try {
    const ficha = await llamarSiguientePaciente();
    if (!ficha) return res.status(404).json({ message: "No hay pacientes en espera" });
    res.json({ message: "Paciente llamado", ficha });
  } catch (error) {
    console.error("[ERROR] iniciarAtencion:", error.message);
    res.status(500).json({ message: "Error al iniciar atención" });
  }
};

// Finalizar atención
const finalizarAtencion = async (req, res) => {
  try {
    const { id_ficha } = req.params;
    const ficha = await Ficha.findByPk(id_ficha);
    if (!ficha) return res.status(404).json({ message: "Ficha no encontrada" });

    ficha.estado = "atendido";
    ficha.hora_finalizacion = horaString();
    await ficha.save();

    res.json({ message: "Atención finalizada", ficha });
  } catch (error) {
    console.error("[ERROR] finalizarAtencion:", error.message);
    res.status(500).json({ message: "Error al finalizar atención" });
  }
};

// Cancelar atención
const cancelarAtencion = async (req, res) => {
  try {
    const { id_ficha } = req.params;
    const ficha = await Ficha.findByPk(id_ficha);
    if (!ficha) return res.status(404).json({ message: "Ficha no encontrada" });

    ficha.estado = "ausente";
    ficha.hora_llamado = horaString();
    ficha.hora_finalizacion = horaString();
    await ficha.save();

    res.json({ message: "Atención cancelada", ficha });
  } catch (error) {
    console.error("[ERROR] cancelarAtencion:", error.message);
    res.status(500).json({ message: "Error al cancelar atención" });
  }
};

module.exports = {
  obtenerFichas,
  getFichasHoy,
  getFichasporFecha,
  getFichasConsultorio,
  crearFicha,
  iniciarAtencion,
  finalizarAtencion,
  cancelarAtencion
};
