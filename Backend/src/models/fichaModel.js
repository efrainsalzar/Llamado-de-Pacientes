const { DataTypes } = require("sequelize");
const sequelize = require("../config/db");

const Ficha = sequelize.define("Ficha", {
    id_ficha: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    id_paciente: { type: DataTypes.INTEGER, allowNull: false },
    fecha: { type: DataTypes.STRING, allowNull: false, },
    estado: { type: DataTypes.STRING(20), allowNull: false, defaultValue: "espera" },
    consultorio: { type: DataTypes.STRING(50), allowNull: true },
    hora_registro: { type: DataTypes.STRING, allowNull: false },
    hora_llamado: { type: DataTypes.STRING, allowNull: true },
    hora_finalizacion: { type: DataTypes.STRING, allowNull: true }
}, {
    tableName: "fichas",
    timestamps: false
});

module.exports = Ficha;
