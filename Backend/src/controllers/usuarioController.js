const { sequelize } = require("../config/db");
const { generarToken } = require("../utils/jwt");

const loginUsuarios = async (req, res) => {
  try {
    const { usuario, password } = req.body;

    const [Usuarios] = await sequelize.query(
      `
      SELECT 
          Usu_Codigo,
          Usu_NombreUsuario,
          Usu_Identificacion,
          Usu_Vigente
      FROM Vw_Usuarios
      WHERE Usu_Identificacion = :usuario
      AND Usu_Codigo = :password
      `,
      { replacements: { usuario, password } }
    );

    if (Usuarios.length === 0) {
      return res.status(401).json({ success: false, message: "Credenciales incorrectas" });
    }

    const user = Usuarios[0];

    // Generar token 
    const token = generarToken({
      id: user.Usu_Codigo,
      nombre: user.Usu_NombreUsuario
    });

    res.status(200).json({ success: true, token, data: {nombre: user.Usu_NombreUsuario} });
  } catch (error) {
    console.error("[ERROR loginUsuarios]", error);
    res.status(500).json({ success: false, message: "Error al validar usuario", error: error.message });
  }
};

module.exports = { loginUsuarios };