const app = require("./app");
const http = require("http");
const { initSocket } = require("./config/socket");
const { testConnection } = require("./config/db");

const PORT = process.env.PORT;

async function startServer() {
  const isConnected = await testConnection();

  if (!isConnected) {
    console.error(
      "No se pudo establecer conexión a la base de datos. Servidor detenido."
    );
    process.exit(1); // corta la ejecución
  }
  const server = http.createServer(app);

  // Inicializar Socket.IO
  initSocket(server);

  server.listen(PORT, () => {
    console.log(`Servidor escuchando en http://localhost:${PORT}`);
  });
}

startServer();
