import { Routes, Route } from "react-router-dom";
import Home from "../pages/Home/Home";
import Fichas from "../pages/Fichas/Fichas";
import Usuarios from "../pages/Usuarios/Usuarios";
import Login from "../pages/Login/Login";

export default function AppRoutes() {
  return (
    <Routes>
      <Route path="/" element={<Home />} />
      <Route path="/fichas" element={<Fichas />} />
      <Route path="/login" element={<Login />} />
      <Route path="/usuarios" element={<Usuarios />} />
    </Routes>
  );
}
