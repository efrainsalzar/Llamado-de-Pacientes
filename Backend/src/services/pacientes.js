const { poolPromise, sql } = require("../config/db");

async function getPacientes() {
    try {
        const pool = await poolPromise;
        const result = await pool.request().query("SELECT * FROM Pacientes");
        return result.recordset;
    } catch (err) {
        throw err;
    }
}

module.exports = { getPacientes };
