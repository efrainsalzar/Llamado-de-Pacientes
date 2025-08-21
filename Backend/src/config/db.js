const sql = require("mssql");
require('dotenv').config({ path: '../.env' });


const config = {
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    server: process.env.DB_SERVER,
    database: process.env.DB_DATABASE,
    options: {
        encrypt: false,
        trustServerCertificate: true
    }
};

const poolPromise = new sql.ConnectionPool(config)
    .connect()
    .then(pool => {
        console.log("Conexión exitosa a SQL Server");
        return pool;
    })
    .catch(err => {
        console.error("Error al conectar a SQL Server:", err);
    });

module.exports = { sql, poolPromise };