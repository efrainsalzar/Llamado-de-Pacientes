const jwt = require("jsonwebtoken");

/**
 * Genera un JWT con los datos del usuario
 * @param {Object} payload - datos a incluir en el token
 * @returns {string} token
 */
function generarToken(payload) {
  const key = process.env.JWT_KEY;
    const expiresIn = process.env.JWT_EXPIRES;
    
  if (!key) throw new Error("JWT_KEY no definida en el archivo .env");

  return jwt.sign(payload, key, { expiresIn });
}

module.exports = { generarToken };
