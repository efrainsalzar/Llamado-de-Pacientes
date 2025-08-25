const express = require("express");
const app = express();
const cors = require('cors');
const fichaRoutes = require("./routes/fichaRoute");


// Middleware
app.use(cors());
app.use(express.json());

// Rutas
app.use("/", fichaRoutes);

module.exports = app;
