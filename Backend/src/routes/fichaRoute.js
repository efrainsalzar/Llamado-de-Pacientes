const express = require('express');
const router = express.Router();
const fichaController = require('../controllers/fichaController');

router.get('/publicas/:fecha/:especialidad', fichaController.obtenerFichasPublicasPorFecha);
router.get('/especialidades', fichaController.getEspecialidad);


module.exports = router;
