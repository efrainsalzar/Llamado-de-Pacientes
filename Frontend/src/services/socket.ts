import { io, Socket } from "socket.io-client";

let socket: Socket | null = null;

export function initSocket() {
  socket = io("http://localhost:3000"); // URL del backend
  console.log("socket inicializado")
  return socket;
}

export function getIO(): Socket {
  if (!socket) throw new Error("Socket no inicializado. Llama a initSocket primero.");
  return socket;
}
