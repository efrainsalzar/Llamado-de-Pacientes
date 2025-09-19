import { useState } from "react";
import { useNavigate } from "react-router-dom";

export default function Login() {
  const navigate = useNavigate();
  const [usuario, setUsuario] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");
    setLoading(true);

    try {
      const response = await fetch("http://localhost:3000/login", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ usuario, password }),
      });

      const data = await response.json();
      setLoading(false);

      if (!data.success) {
        setError(data.message || "Error en login");
        return;
      }

      // Guardar token en localStorage
      localStorage.setItem("token", data.token);

      // Guardar datos del usuario si quieres
      localStorage.setItem("usuario", JSON.stringify(data.data));

        console.log("Login exitoso:"/*, data*/);
      //  redirigir a la página USUARIOS
        navigate("/usuarios");
        

    } catch (err) {
      console.error(err);
      setLoading(false);
      setError("Error de conexión al servidor");
    }
  };

  return (
    <div
      style={{
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        justifyContent: "center",
        height: "100vh",
        fontFamily: "sans-serif",
      }}
    >
      <h1 style={{ fontSize: "2rem", marginBottom: "20px" }}>Login</h1>

      <form
        onSubmit={handleSubmit}
        style={{
          display: "flex",
          flexDirection: "column",
          gap: "10px",
          width: "300px",
        }}
      >
        <input
          type="text"
          placeholder="Usuario"
          value={usuario}
          onChange={(e) => setUsuario(e.target.value)}
          required
          style={{ padding: "10px", borderRadius: "5px", border: "1px solid #ccc" }}
        />

        <input
          type="password"
          placeholder="Contraseña"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          required
          style={{ padding: "10px", borderRadius: "5px", border: "1px solid #ccc" }}
        />

        <button
          type="submit"
          disabled={loading}
          style={{
            padding: "10px",
            borderRadius: "5px",
            border: "none",
            backgroundColor: "#3b82f6",
            color: "white",
            cursor: "pointer",
          }}
        >
          {loading ? "Ingresando..." : "Ingresar"}
        </button>

        {error && <span style={{ color: "red", marginTop: "10px" }}>{error}</span>}
      </form>
    </div>
  );
}
