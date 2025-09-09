const express = require('express');
const router = express.Router();
const fichaController = require('../controllers/medicoController');

router.get('/buscarFicha/:idFicha', fichaController.BuscarIdFicha);
router.put('/actualizarEstadoFicha/:idFicha', fichaController.actualizarEstadoFicha);
router.get('/medico/:fecha/:medico', fichaController.obtenerFichasPorMedico);
router.get('/medicoPeriodo/:fecha/:medico/:periodo', fichaController.obtenerFichasPorMedicoPeriodo);
router.get('/medicos/:fecha', fichaController.getMedico);
router.get('/turnos/:fecha', fichaController.getTurno);


module.exports = router;
