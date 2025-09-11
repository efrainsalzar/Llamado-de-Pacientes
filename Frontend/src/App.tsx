import { BrowserRouter } from "react-router-dom";
import AppRoutes from "./routes/AppRoutes";

export default function App() {
  return (
    <BrowserRouter
      future={{
        v7_startTransition: true,    // Evita la advertencia sobre startTransition
        v7_relativeSplatPath: true   // Evita la advertencia sobre rutas splat relativas
      }}
    >
      <AppRoutes />
    </BrowserRouter>
  );
}
