// socket.js
let io = null;

function initSocket(server) {
  const { Server } = require("socket.io");
  io = new Server(server, { cors: { origin: "*" } });

  io.on("connection", (socket) => {
    console.log("Cliente conectado:", socket.id);

    // Evento de desconexión
    socket.on("disconnect", (reason) => {
      console.log(`Cliente desconectado: ${socket.id} (motivo: ${reason})`);
    });
  });

  return io;
}

function getIO() {
  if (!io) throw new Error("Socket.IO no inicializado");
  return io;
}

module.exports = { initSocket, getIO };
