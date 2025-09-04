const express = require("express");
const app = express();
const cors = require('cors');
const fichaRoutes = require("./routes/fichaRoute");
const medicoRoutes = require("./routes/medicoRoute");


// Middleware
app.use(cors());
app.use(express.json());

// Rutas
app.use("/", fichaRoutes);
app.use("/", medicoRoutes);

module.exports = app;
