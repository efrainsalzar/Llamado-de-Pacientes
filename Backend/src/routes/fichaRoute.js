const express = require('express');
const router = express.Router();
const fichaController = require('../controllers/fichaController');

// Rutas
router.get('/hoy', fichaController.getFichasHoy);
router.get('/:fecha', fichaController.getFichasporFecha);
router.post('/', fichaController.crearFicha);

router.post('/iniciar', fichaController.iniciarAtencion);
router.post('/finalizar/:id_ficha', fichaController.finalizarAtencion);
router.post('/cancelar/:id_ficha', fichaController.cancelarAtencion);

module.exports = router;
