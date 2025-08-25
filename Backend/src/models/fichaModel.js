const { DataTypes } = require('sequelize');
const sequelize = require('../config/db'); // tu instancia de Sequelize

const Ficha = sequelize.define('Ficha', {
  id_ficha: {
    type: DataTypes.INTEGER,
    primaryKey: true,
    autoIncrement: true
  },
  id_paciente: {
    type: DataTypes.INTEGER,
    allowNull: false
  },
  fecha: {
    type: DataTypes.DATEONLY,  // DATE en SQL
    allowNull: false
    // no defaultValue, lo asignamos desde el controlador
  },
  estado: {
    type: DataTypes.STRING(20),
    allowNull: false,
    defaultValue: 'espera',
    validate: {
      isIn: [['espera', 'atendiendo', 'atendido', 'ausente']]
    }
  },
  consultorio: {
    type: DataTypes.STRING(50),
    allowNull: true
  },
  hora_registro: {
    type: DataTypes.TIME, // TIME en SQL
    allowNull: false
    // lo asignamos desde el controlador
  },
  hora_llamado: {
    type: DataTypes.TIME,
    allowNull: true
  },
  hora_finalizacion: {
    type: DataTypes.TIME,
    allowNull: true
  }
}, {
  tableName: 'fichas',
  timestamps: false
});

module.exports = Ficha;
