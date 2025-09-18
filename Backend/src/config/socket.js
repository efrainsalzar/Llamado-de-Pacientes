// socket.js
let io = null;

// ============= Utilidades de nombre de room ============
// Sanitiza un valor para que sea seguro como nombre de room
function sanitizeRoomPart(value) {
  if (!value) return "";
  return encodeURIComponent(String(value).trim().replace(/\s+/g, "_"));
}

// Construye el nombre de la room a partir del idProfesional
function makeRoomName(idProfesional) {
  return `med_${sanitizeRoomPart(idProfesional)}`;
}

// ============= Logger para depuración ============
function logSocket(action, socketId, extra = "") {
  const time = new Date().toISOString();
  console.log(`[SOCKET][${time}] ${action} - SocketID: ${socketId} ${extra}`);
}

// ============= Inicialización de Socket.IO ============
function initSocket(server) {
  const { Server } = require("socket.io");
  io = new Server(server, { cors: { origin: "*" } });

  // ============= Evento: conexión ============
  io.on("connection", (socket) => {
    logSocket("Cliente conectado", socket.id);

    // ============= Evento: joinRoom ============
    socket.on("joinRoom", (payload) => {
      try {
        if (!payload || !payload.idProfesional) {
          socket.emit("joinRoomError", "Falta idProfesional en payload");
          logSocket("Error joinRoom", socket.id, "Falta idProfesional");
          return;
        }

        // Nombre de la room basado en el idProfesional
        const room = makeRoomName(payload.idProfesional);

        // Salir de room previa si existe
        if (socket.data.currentRoom && socket.data.currentRoom !== room) {
          socket.leave(socket.data.currentRoom);
          logSocket("Left room anterior", socket.id, `Room: ${socket.data.currentRoom}`);
        }

        // Unirse a la nueva room
        socket.join(room);
        socket.data.currentRoom = room;
        socket.emit("joinedRoom", { room });
        logSocket("Joined room", socket.id, `Room: ${room}`);
      } catch (err) {
        console.error("[SOCKET joinRoom]", err);
        socket.emit("joinRoomError", "Error al unir a la room");
      }
    });

    // ============= Evento: leaveRoom ============
    socket.on("leaveRoom", (payload) => {
      const room = payload?.idProfesional
        ? makeRoomName(payload.idProfesional)
        : socket.data.currentRoom;

      if (room) {
        socket.leave(room);
        if (socket.data.currentRoom === room) delete socket.data.currentRoom;
        socket.emit("leftRoom", { room });
        logSocket("Leave room", socket.id, `Room: ${room}`);
      }
    });

    // ============= Evento: joinPublic ============
    socket.on("joinPublic", () => {
      socket.join("pantalla_publica");
      socket.emit("joinedPublic");
      logSocket("Joined public room", socket.id);
    });

    // ============= Evento: desconexión ============
    socket.on("disconnect", (reason) => {
      logSocket("Cliente desconectado", socket.id, `Motivo: ${reason}`);
    });

    // ============= Log de cualquier evento entrante ============
    socket.onAny((event, ...args) => {
      logSocket("Evento recibido", socket.id, `Evento: ${event}, Args: ${JSON.stringify(args)}`);
    });
  });

  return io;
}

// ============= Exportaciones ============
function getIO() {
  if (!io) throw new Error("Socket.IO no inicializado");
  return io;
}

module.exports = { initSocket, getIO, makeRoomName };
