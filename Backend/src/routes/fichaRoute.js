const express = require('express');
const router = express.Router();
const fichaController = require('../controllers/fichaController');

router.get('/especialidades', fichaController.getEspecialidad);

router.get('/publicas/:especialidad', fichaController.obtenerFichasPublicas);


module.exports = router;
