const sequelize = require("../config/db");

// ======= SERVICIOS =======

/**
 * Buscar ficha por ID
 * @param {number|string} idFicha
 * @returns {Promise<object|null>} Ficha encontrada o null
 */
const findFichaById = async (idFicha) => {
  const [result] = await sequelize.query(
    `SELECT * FROM dbo.tblFICHAS WHERE IDFicha = :idFicha`,
    { replacements: { idFicha } }
  );
  return result.length > 0 ? result[0] : null;
};

// ======= CONTROLADORES =======

/**
 * Buscar ficha por ID (endpoint)
 */
const BuscarIdFicha = async (req, res) => {
  try {
    const { idFicha } = req.params;

    if (!idFicha) {
      return res.status(400).json({
        success: false,
        message: "Falta el parámetro: idFicha es obligatorio",
      });
    }

    const ficha = await findFichaById(idFicha);

    if (!ficha) {
      return res.status(404).json({
        success: false,
        message: `No se encontró ficha con ID ${idFicha}`,
      });
    }

    res.status(200).json({
      success: true,
      data: ficha,
    });
  } catch (error) {
    console.error("[ERROR BuscarIdFicha]", error);
    res.status(500).json({
      success: false,
      message: "Error al obtener ficha por ID",
      error: error.message,
    });
  }
};

/**
 * Actualizar estado de ficha
 */
const actualizarEstadoFicha = async (req, res) => {
  try {
    const { idFicha } = req.params;
    const { estado } = req.body; // Se pasa en el body para mayor flexibilidad

    if (!idFicha || !estado) {
      return res.status(400).json({
        success: false,
        message: "Parámetros requeridos: idFicha y estado",
      });
    }

    // Validar que el estado sea permitido
    const estadosPermitidos = {
      2: "llamado",
      3: "atendido",
      4: "cancelado",
    };

    if (!estadosPermitidos[estado]) {
      return res.status(400).json({
        success: false,
        message: `Estado inválido. Valores permitidos: ${Object.keys(estadosPermitidos).join(", ")}`,
      });
    }

    // Verificar existencia de ficha
    const ficha = await findFichaById(idFicha);
    if (!ficha) {
      return res.status(404).json({
        success: false,
        message: `No se encontró ficha con ID ${idFicha}`,
      });
    }

    // Actualizar estado
    await sequelize.query(
      `UPDATE dbo.tblFICHAS
       SET EstadoFicha = :estado
       WHERE IDFicha = :idFicha`,
      { replacements: { idFicha, estado } }
    );

    res.status(200).json({
      success: true,
      message: `Estado de ficha actualizado a '${estadosPermitidos[estado]}'`,
      data: { ...ficha, EstadoFicha: estado },
    });

  } catch (error) {
    console.error("[ERROR actualizarEstadoFicha]", error);
    res.status(500).json({
      success: false,
      message: "Error al actualizar estado de la ficha",
      error: error.message,
    });
  }
};

module.exports = {
  BuscarIdFicha,
  actualizarEstadoFicha
};
