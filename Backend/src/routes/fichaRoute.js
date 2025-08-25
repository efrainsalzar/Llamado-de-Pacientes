const express = require('express');
const router = express.Router();
const fichaController = require('../controllers/fichaController');

// Rutas
router.get('/hoy', fichaController.getFichasHoy);
router.get('/:fecha', fichaController.getFichasporFecha);
router.post('/', fichaController.crearFicha);

module.exports = router;
