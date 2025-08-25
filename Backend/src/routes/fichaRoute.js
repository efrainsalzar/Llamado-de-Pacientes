const express = require('express');
const router = express.Router();
const { getFichas } = require('../controllers/fichaController');

// Ruta flexible:
//  - /fichas/hoy → fichas de hoy
//  - /fichas/:fecha → fichas de fecha específica
router.get('/hoy', getFichas);
router.get('/:fecha', getFichas);

module.exports = router;

