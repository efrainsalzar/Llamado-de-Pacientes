import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { io, Socket } from 'socket.io-client';

@Component({
  selector: 'app-usuarios',
  standalone: true,
  imports: [CommonModule, HttpClientModule, FormsModule],
  templateUrl: './usuarios.html',
  styleUrls: ['./usuarios.css'],
})
export class Usuarios implements OnInit {
  fichas: any[] = [];
  medicos: any[] = [];
  turnos: any[] = [];
  medicoSeleccionado = '';
  fechaSeleccionada = '';
  turnoSeleccionado = '';

  private http = inject(HttpClient);
  private socket!: Socket;

  ngOnInit(): void {
    this.conectarSocket();
  }

  // ============ SOCKET.IO ============
  conectarSocket(): void {
    this.socket = io('http://localhost:3000');
    this.socket.on('fichasActualizadas', (data: any[]) => {
      this.fichas = data;
      console.log('Fichas actualizadas en tiempo real:', this.fichas);
    });
  }

  // ============ EVENTOS ============
  onFechaChange(valor: string) {
    this.fechaSeleccionada = valor;
    if (!this.fechaSeleccionada) return;
    this.cargarMedicos();
    this.cargarTurnos();
  }

  onMedicoChange(valor: string) {
    this.medicoSeleccionado = valor;
  }

  onTurnoChange(valor: string) {
    this.turnoSeleccionado = valor;
  }

  // ============ CARGAS DE DATOS ============
  cargarMedicos(): void {
    this.http.get<any>(`http://localhost:3000/medicos/${this.fechaSeleccionada}`).subscribe({
      next: (res) => (this.medicos = res.data),
      error: (err) => console.error('Error al cargar médicos:', err),
    });
  }

  cargarTurnos(): void {
    this.http.get<any>(`http://localhost:3000/turnos/${this.fechaSeleccionada}`).subscribe({
      next: (res) => (this.turnos = res.data),
      error: (err) => console.error('Error al cargar turnos:', err),
    });
  }

  cargarFichas(): void {
    if (!this.fechaSeleccionada || !this.medicoSeleccionado) {
      alert('Seleccione fecha y médico');
      return;
    }

    const url = this.turnoSeleccionado
      ? `http://localhost:3000/medicoPeriodo/${this.fechaSeleccionada}/${this.medicoSeleccionado}/${this.turnoSeleccionado}`
      : `http://localhost:3000/medico/${this.fechaSeleccionada}/${this.medicoSeleccionado}`;

    this.http.get<any>(url).subscribe({
      next: (res) => (this.fichas = res.data),
      error: (err) => console.error('Error al obtener fichas:', err),
    });
  }

  // ============ GESTIÓN DE ESTADOS ============
  private actualizarEstadoFicha(ficha: any, nuevoEstado: number, estadoTexto: string) {
    this.http
      .put(`http://localhost:3000/actualizarEstadoFicha/${ficha.idFicha}`, { estado: nuevoEstado })
      .subscribe({
        next: () => {
          console.log(`Ficha ${ficha.idFicha} → ${estadoTexto}`);
          ficha.EstadoFicha = estadoTexto;
        },
        error: (err) => console.error(`Error al actualizar ficha ${ficha.idFicha}`, err),
      });
  }

  private obtenerSiguiente(permitidos: string[]): any | null {
    const pendientes = this.fichas.filter((f) => permitidos.includes(f.EstadoFicha));
    if (pendientes.length === 0) return null;
    return pendientes.reduce((min, f) => (f.Ficha < min.Ficha ? f : min), pendientes[0]);
  }

  // Controladores de botones
  llamarSiguiente() {
    const ficha = this.obtenerSiguiente(['En espera']);
    if (!ficha) return console.log('No hay pacientes pendientes para llamar');
    this.actualizarEstadoFicha(ficha, 2, 'Llamado');
  }

  atenderPaciente() {
    const ficha = this.obtenerSiguiente(['Llamado']);
    if (!ficha) return console.log('No hay pacientes pendientes para atender');
    this.actualizarEstadoFicha(ficha, 3, 'Atendido');
  }

  cancelarPaciente() {
    const ficha = this.obtenerSiguiente(['En espera', 'Llamado']);
    if (!ficha) return console.log('No hay pacientes pendientes para cancelar');
    this.actualizarEstadoFicha(ficha, 4, 'Cancelado');
  }

  reiniciarEstado() {
    const pendientes = this.fichas.filter((f) =>
      ['Llamado', 'Atendido', 'Cancelado'].includes(f.EstadoFicha)
    );
    if (pendientes.length === 0) return console.log('No hay pacientes para reiniciar estado');

    pendientes.forEach((ficha) => this.actualizarEstadoFicha(ficha, 1, 'En espera'));
  }

  // ============ GETTERS PARA BOTONES ============
  get puedeLlamar(): boolean {
    return this.obtenerSiguiente(['En espera']) !== null;
  }

  get puedeAtender(): boolean {
    return this.obtenerSiguiente(['Llamado']) !== null;
  }

  get puedeCancelar(): boolean {
    return this.obtenerSiguiente(['En espera', 'Llamado']) !== null;
  }

  get puedeReiniciar(): boolean {
    return this.fichas.some((f) => ['Llamado', 'Atendido', 'Cancelado'].includes(f.EstadoFicha));
  }
}
