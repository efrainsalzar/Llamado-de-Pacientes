import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App.tsx'
import './index.css'
import { initSocket } from "./services/socket";

// Inicializa la conexión del socket al cargar la aplicación
initSocket();

ReactDOM.createRoot(document.getElementById('root') as HTMLElement).render(
  //<React.StrictMode>
    <App />
 // </React.StrictMode>,
)
