const express = require('express');
const router = express.Router();
const fichaController = require('../controllers/medicoController');

router.get('/buscarFicha/:idFicha', fichaController.BuscarIdFicha);
router.put('/actualizarEstadoFicha/:idFicha', fichaController.actualizarEstadoFicha);


module.exports = router;
