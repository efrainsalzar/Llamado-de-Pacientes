require("dotenv").config();
const { Sequelize } = require("sequelize");

// Detectar instancia si existe
let host = process.env.DB_SERVER;
let instanceName;
if (host.includes("\\")) {
  const [server, instance] = host.split("\\");
  host = server;
  instanceName = instance;
}

// Crear instancia de Sequelize
const sequelize = new Sequelize(process.env.DB_DATABASE, process.env.DB_USER, process.env.DB_PASSWORD, {
  host,
  //port: process.env.DB_PORT || 1433,
  dialect: "mssql",
  dialectOptions: {
    options: {
      encrypt: false,
      trustServerCertificate: true,
      instanceName: instanceName,
    },
  },
  logging: false,
});

// probar conexión
async function testConnection() {
  try {
    await sequelize.authenticate();
    console.log("Conexión exitosa a la base de datos");
    return true;
  } catch (error) {
    console.error("Falló la conexión a la base de datos");
    console.error("Detalle del error:", error.message);
    return false;
  }
}

module.exports = { sequelize, testConnection };
