const { poolPromise, sql } = require('../config/db');

async function obtenerFichasPorFecha(fecha) {
  const pool = await poolPromise;

  // Si no se envía fecha, usar la fecha actual
  const fechaConsulta = fecha ? fecha : new Date();

  const result = await pool.request()
    .input('fecha', sql.Date, fechaConsulta)
    .query(`
        SELECT 
            id_ficha,
            id_paciente,
            fecha,
            estado,
            consultorio,
            hora_registro,
            hora_llamado,
            hora_finalizacion
        FROM fichas
        WHERE fecha = @fecha
        ORDER BY hora_registro ASC;
    `);
  return result.recordset;
}

module.exports = {
  obtenerFichasPorFecha
};
