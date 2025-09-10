const app = require("./app");
const http = require("http");
const { initSocket } = require("./config/socket");

const PORT = process.env.PORT;
const server = http.createServer(app);

// Inicializar Socket.IO
const io = initSocket(server);

server.listen(PORT, () => {
  console.log(`Servidor escuchando en http://localhost:${PORT}`);
});
