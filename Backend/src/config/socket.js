// socket.js
let io = null;

function sanitizeRoomPart(value) {
  if (!value) return "";
  return encodeURIComponent(String(value).trim().replace(/\s+/g, "_"));
}

function makeRoomName(medico, fecha) {
  return `med_${sanitizeRoomPart(medico)}_${sanitizeRoomPart(fecha)}`;
}

function logSocket(action, socketId, extra = "") {
  const time = new Date().toISOString();
  console.log(`[SOCKET][${time}] ${action} - SocketID: ${socketId} ${extra}`);
}

function initSocket(server) {
  const { Server } = require("socket.io");
  io = new Server(server, { cors: { origin: "*" } });

  io.on("connection", (socket) => {
    logSocket("Cliente conectado", socket.id);

    socket.on("joinRoom", (payload) => {
      try {
        if (!payload || (!payload.medico && !payload.room)) {
          socket.emit("joinRoomError", "Falta medico/room en payload");
          logSocket("Error joinRoom", socket.id, "Falta medico/room");
          return;
        }

        const room = payload.room
          ? sanitizeRoomPart(payload.room)
          : makeRoomName(payload.medico, payload.fecha);

        if (socket.data.currentRoom && socket.data.currentRoom !== room) {
          socket.leave(socket.data.currentRoom);
          logSocket("Left room anterior", socket.id, `Room: ${socket.data.currentRoom}`);
        }

        socket.join(room);
        socket.data.currentRoom = room;
        socket.emit("joinedRoom", { room });
        logSocket("Joined room", socket.id, `Room: ${room}`);
      } catch (err) {
        console.error("[SOCKET joinRoom]", err);
        socket.emit("joinRoomError", "Error al unir a la room");
      }
    });

    socket.on("leaveRoom", (payload) => {
      const room = payload && payload.room
        ? sanitizeRoomPart(payload.room)
        : makeRoomName(payload.medico, payload.fecha);

      socket.leave(room);
      if (socket.data.currentRoom === room) delete socket.data.currentRoom;
      socket.emit("leftRoom", { room });
      logSocket("Leave room", socket.id, `Room: ${room}`);
    });

    socket.on("joinPublic", () => {
      socket.join("pantalla_publica");
      socket.emit("joinedPublic");
      logSocket("Joined public room", socket.id);
    });

    socket.on("disconnect", (reason) => {
      logSocket("Cliente desconectado", socket.id, `Motivo: ${reason}`);
    });

    // Evento genérico para seguimiento de emisión de eventos
    socket.onAny((event, ...args) => {
      logSocket("Evento recibido", socket.id, `Evento: ${event}, Args: ${JSON.stringify(args)}`);
    });
  });

  return io;
}

function getIO() {
  if (!io) throw new Error("Socket.IO no inicializado");
  return io;
}

module.exports = { initSocket, getIO, makeRoomName };
