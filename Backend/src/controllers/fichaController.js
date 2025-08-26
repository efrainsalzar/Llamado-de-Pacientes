const Ficha = require("../models/fichaModel");
const sequelize = require("../config/db");
const { getIO } = require("../config/socket");

// ======= FUNCIONES AUXILIARES =======

// Fecha en formato YYYY-MM-DD
const hoyString = () => new Date().toISOString().split("T")[0];

// Hora en formato HH:MM:SS
const horaString = () => new Date().toTimeString().split(" ")[0];

// Atributos con formateo SQL
const formatearAtributosFicha = () => [
  "id_ficha",
  "id_paciente",
  "consultorio",
  "estado",
  [sequelize.literal("CONVERT(varchar, fecha, 23)"), "fecha"],
  [sequelize.literal("CONVERT(varchar, hora_registro, 8)"), "hora_registro"],
  [sequelize.literal("CONVERT(varchar, hora_llamado, 8)"), "hora_llamado"],
  [sequelize.literal("CONVERT(varchar, hora_finalizacion, 8)"), "hora_finalizacion"]
];

// Wrapper para manejar errores y evitar repetición
const handleRequest = (fn) => async (req, res) => {
  try {
    await fn(req, res);
  } catch (error) {
    console.error(`[ERROR] ${fn.name}:`, error.message);
    res.status(500).json({
      success: false,
      message: `Error en ${fn.name}`,
      error: error.message
    });
  }
};

// ======= CONSULTAS =======

const obtenerFichas = handleRequest(async (req, res) => {
  const fichas = await Ficha.findAll({
    attributes: formatearAtributosFicha(),
    raw: true
  });
  res.status(200).json(fichas);
});

const getFichasHoy = handleRequest(async (req, res) => {
  const fichas = await Ficha.findAll({
    attributes: formatearAtributosFicha(),
    raw: true,
    where: { fecha: hoyString() }
  });
  res.json(fichas);
});

const getFichasporFecha = handleRequest(async (req, res) => {
  const { fecha } = req.params;
  const fichas = await Ficha.findAll({
    attributes: formatearAtributosFicha(),
    raw: true,
    where: { fecha }
  });
  res.json(fichas);
});

const getFichasConsultorio = handleRequest(async (req, res) => {
  const { consultorio } = req.params;
  if (!consultorio) {
    return res.status(400).json({ message: "Debe proporcionar el consultorio" });
  }

  const fichas = await Ficha.findAll({
    attributes: formatearAtributosFicha(),
    raw: true,
    where: { fecha: hoyString(), consultorio }
  });

  if (!fichas.length) {
    return res.status(404).json({ message: `No se encontraron fichas para el consultorio "${consultorio}"` });
  }

  res.status(200).json(fichas);
});

// ======= CREACIÓN Y ATENCIÓN =======

const crearFicha = handleRequest(async (req, res) => {
  const { id_paciente, consultorio } = req.body;
  if (!id_paciente) {
    return res.status(400).json({ success: false, message: "id_paciente es obligatorio" });
  }

  const ficha = await Ficha.create({
    id_paciente,
    consultorio,
    fecha: hoyString(),
    hora_registro: horaString()
  });

  // Emitir actualización en tiempo real
  getIO().emit("fichasActualizadas", await Ficha.findAll({ raw: true }));

  res.status(201).json({ success: true, message: "Ficha creada correctamente", data: ficha });
});

// ======= ATENCIÓN =======

// Función auxiliar
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


const iniciarAtencion = handleRequest(async (req, res) => {
  const ficha = await llamarSiguientePaciente();
  if (!ficha) return res.status(404).json({ message: "No hay pacientes en espera" });

  // Emitir actualización en tiempo real
  getIO().emit("fichasActualizadas", await Ficha.findAll({ raw: true }));

  res.json({ message: "Paciente llamado", ficha });
});

const finalizarAtencion = handleRequest(async (req, res) => {
  const { id_ficha } = req.params;
  const ficha = await Ficha.findByPk(id_ficha);
  if (!ficha) return res.status(404).json({ message: "Ficha no encontrada" });

  ficha.estado = "atendido";
  ficha.hora_finalizacion = horaString();
  await ficha.save();

  // Emitir actualización en tiempo real
  getIO().emit("fichasActualizadas", await Ficha.findAll({ raw: true }));

  res.json({ message: "Atención finalizada", ficha });
});

const cancelarAtencion = handleRequest(async (req, res) => {
  const { id_ficha } = req.params;
  const ficha = await Ficha.findByPk(id_ficha);
  if (!ficha) return res.status(404).json({ message: "Ficha no encontrada" });

  ficha.estado = "ausente";
  ficha.hora_llamado = horaString();
  ficha.hora_finalizacion = horaString();
  await ficha.save();

  // Emitir actualización en tiempo real
  getIO().emit("fichasActualizadas", await Ficha.findAll({ raw: true }));

  res.json({ message: "Atención cancelada", ficha });
});

// ======= EXPORTS =======

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
