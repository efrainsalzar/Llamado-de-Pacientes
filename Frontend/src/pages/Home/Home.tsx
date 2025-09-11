import { Link } from "react-router-dom";
import { useEffect } from "react";

export default function Home() {
  useEffect(() => {
    console.log("Home montado");
  }, []);

  const handleClick = (destino: string) => {
    console.log(`Navegando a: ${destino}`);
  };

  return (
    <div
      style={{
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        justifyContent: "center",
        height: "100vh",
        fontFamily: "sans-serif"
      }}
    >
      <h1 style={{ fontSize: "2rem", marginBottom: "20px" }}>Sistema de Llamadas</h1>

      <div style={{ display: "flex", gap: "10px" }}>
        <Link
          to="/fichas"
          onClick={() => handleClick("Fichas")}
          style={{
            padding: "10px 20px",
            backgroundColor: "#3b82f6",
            color: "white",
            borderRadius: "5px",
            textDecoration: "none",
            textAlign: "center"
          }}
        >
          Fichas
        </Link>

        <Link
          to="/usuarios"
          onClick={() => handleClick("Usuarios")}
          style={{
            padding: "10px 20px",
            backgroundColor: "#10b981",
            color: "white",
            borderRadius: "5px",
            textDecoration: "none",
            textAlign: "center"
          }}
        >
          Usuarios
        </Link>
      </div>
    </div>
  );
}
