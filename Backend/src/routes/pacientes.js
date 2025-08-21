const express = require("express");
const router = express.Router();
const { getPacientes } = require("../services/pacientes");

// GET /pacientes
router.get("/", async (req, res) => {
    try {
        const pacientes = await getPacientes();
        res.json(pacientes);
    } catch (err) {
        console.error("Error al obtener pacientes:", err);
        res.status(500).send("Error al consultar la base de datos");
    }
});

module.exports = router;
