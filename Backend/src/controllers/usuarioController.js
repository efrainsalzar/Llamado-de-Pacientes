const { sequelize } = require("../config/db");
const { generarToken } = require("../utils/jwt");
const { encodeLegacyPassword } = require("../utils/legacyPasswords");

const loginUsuarios = async (req, res) => {
  try {
    const { usuario, password } = req.body;

    if (!usuario || !password) {
      return res.status(400).json({
        success: false,
        message: "Debe enviar usuario y contraseña"
      });
    }

    //Encriptar clave
    const encodedPassword = encodeLegacyPassword(String(password));

    const [Usuarios] = await sequelize.query(
      `
      SELECT 
          Usu_Codigo,
          Usu_NombreUsuario,
          Usu_Identificacion,
          Usu_ClaveUsuario,
          Usu_Vigente
      FROM Vw_Usuarios
      WHERE Usu_Identificacion = :usuario
      AND Usu_ClaveUsuario = :password
      `,
      { replacements: { usuario, password: encodedPassword } }
    );

    if (Usuarios.length === 0) {
      return res.status(401).json({ 
        success: false, 
        message: "Credenciales incorrectas" 
      });
    }

    const user = Usuarios[0];

    if (user.Usu_Vigente !== "S") {
      return res.status(403).json({
        success: false,
        message: "El usuario no está vigente"
      });
    }
    //EXEC dbo.sp_obtenerCuaderno @UsuCodigo = 383
    //EXEC dbo.sp_obtenerCuaderno @UsuCodigo = 321
    //EXEC dbo.sp_obtenerCuaderno @UsuCodigo = 379
    const [Cuaderno] = await sequelize.query(
      "EXEC dbo.sp_obtenerCuaderno @UsuCodigo = :id",
      { replacements: { id: user.Usu_Codigo } }
    );
    // guardar en un array
    const cuaderno = Cuaderno[0];
    console.log(cuaderno);

    // Generar token 
    const token = generarToken({
      id: user.Usu_Codigo,
      nombre: user.Usu_NombreUsuario,
      IdProfesional: cuaderno.IdProfesional
    });

    res.status(200).json({ 
      success: true, 
      token, 
      data: {
        nombre: user.Usu_NombreUsuario,
        identificacion: user.Usu_Identificacion
      } 
    });

  } catch (error) {
    console.error("[ERROR loginUsuarios]", error);
    res.status(500).json({ 
      success: false, 
      message: "Error al validar usuario", 
      error: error.message 
    });
  }
};

module.exports = { loginUsuarios };
