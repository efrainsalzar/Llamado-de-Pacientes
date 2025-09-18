import {jwtDecode} from "jwt-decode";

export interface Payload {
  id: number;
  nombre: string;
  IdProfesional: number;
  //iat?: number; // issued at
  //exp?: number; // expiration
}

/**
 * Recupera y decodifica el JWT guardado en localStorage.
 * @returns Payload del JWT o null si no hay token.
 */
export function getUsuarioInfo(): Payload | null {
  const token = localStorage.getItem("token");
  if (!token) return null;

  try {
    const decoded = jwtDecode<Payload>(token);
    return {
      id: decoded.id,
      nombre: decoded.nombre,
      IdProfesional: decoded.IdProfesional
    };
  } catch (err) {
    console.error("Error decodificando el JWT:", err);
    return null;
  }
}
