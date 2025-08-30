const express = require('express');
const router = express.Router();
const fichaController = require('../controllers/fichaController');

router.get('/publicas/:idProgramacion/:fecha', fichaController.obtenerFichasPublicasPorFecha);
/*router.get('/', fichaController.obtenerFichas);
// Rutas
router.get('/hoy', fichaController.getFichasHoy);
router.get('/:fecha', fichaController.getFichasporFecha);
router.get('/consultorio/:consultorio', fichaController.getFichasConsultorio);

router.post('/', fichaController.crearFicha);

router.patch('/iniciar', fichaController.iniciarAtencion);
router.patch('/finalizar/:id_ficha', fichaController.finalizarAtencion);
router.patch('/cancelar/:id_ficha', fichaController.cancelarAtencion);*/

module.exports = router;
