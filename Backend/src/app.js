const express = require("express");
const app = express();

const fichaRoutes = require("./routes/fichaRoute");


// Middleware
app.use(express.json());

// Rutas
app.use("/", fichaRoutes);

module.exports = app;
