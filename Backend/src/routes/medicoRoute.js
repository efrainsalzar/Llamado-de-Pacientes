const express = require('express');
const router = express.Router();
const fichaController = require('../controllers/medicoController');

//router.get('/buscarFicha/:idFicha', fichaController.BuscarIdFicha);
router.get('/obtenerFichas/:idProfesional', fichaController.obtenerFichasMedico);
router.get('/obtenerFichasPeriodo/:idProfesional/:periodo', fichaController.obtenerFichasMedicoPeriodo);
router.patch('/actualizarEstadoFicha/:idFicha', fichaController.actualizarEstadoFicha);
//router.get('/medicos/:fecha', fichaController.getMedico);
//router.get('/turnos/:fecha', fichaController.getTurno);


module.exports = router;
