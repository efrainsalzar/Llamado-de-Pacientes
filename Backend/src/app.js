const express = require("express");
const app = express();

// Middleware
app.use(express.json());

// Rutas
const pacientesRoutes = require("./routes/pacientes");
app.use("/pacientes", pacientesRoutes);

module.exports = app;
