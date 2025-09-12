require("dotenv").config();
const { Sequelize } = require("sequelize");

const sequelize = new Sequelize(
  process.env.DB_DATABASE,
  process.env.DB_USER,
  process.env.DB_PASSWORD,
  {
    host: process.env.DB_SERVER,
    dialect: "mssql",
    dialectOptions: {
      options: { encrypt: false, trustServerCertificate: true },
    },
    logging: false,
    timezone: "-04:00" // UTC-4
  }
);

async function testConnection() {
  try {
    await sequelize.authenticate();
    console.log("Conectado a la base de datos a las:", new Date().toLocaleString());
    return true;
  } catch (error) {
    console.error("No se pudo conectar:", error);
    return false;
  }
}


module.exports = {sequelize, testConnection};
