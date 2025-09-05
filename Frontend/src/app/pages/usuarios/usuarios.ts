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
  medicoSeleccionado: string = ''; // Médico elegido
  fechaSeleccionada: string = ''; // Fecha elegida
  turnoSeleccionado: string = '';

  private http = inject(HttpClient);
  private socket!: Socket;

  ngOnInit(): void {
    this.conectarSocket();
  }
  // Nuevo método que se llama al cambiar la fecha
  onFechaChange(valor: string) {
    this.fechaSeleccionada = valor;
    console.log('Fecha seleccionada:', valor);

    if (!this.fechaSeleccionada) return;

    this.cargarMedicos();
    this.cargarturnos();
  }
  // Conexión a Socket.IO
  conectarSocket(): void {
    this.socket = io('http://localhost:3000');
    this.socket.on('fichasActualizadas', (data: any[]) => {
      this.fichas = data;
      console.log('Fichas actualizadas en tiempo real:', this.fichas);
    });
  }

  // Traer lista de médicos desde backend
  cargarMedicos(): void {
    this.http.get<any>(`http://localhost:3000/medicos/${this.fechaSeleccionada}`).subscribe({
      next: (res) => {
        this.medicos = res.data;
        console.log('Médicos:', this.medicos);
      },
      error: (err) => console.error('Error al cargar médicos:', err),
    });
  }
  cargarturnos(): void {
    this.http.get<any>(`http://localhost:3000/turnos/${this.fechaSeleccionada}`).subscribe({
      next: (res) => {
        this.turnos = res.data;
        console.log('Turnos:', this.turnos);
      },
      error: (err) => console.error('Error al cargar turnos:', err),
    });
  }

  // Capturar cambio de médico seleccionado
  onMedicoChange(valor: string) {
    this.medicoSeleccionado = valor;
    console.log('Médico seleccionado:', valor);
  }

  onTurnoChange(valor: string) {
    this.turnoSeleccionado = valor;
    console.log('Turno seleccionado:', valor);
  }

  // Cargar usuarios filtrados por médico y fecha
  cargarFichas(): void {
    if (!this.fechaSeleccionada || !this.medicoSeleccionado) {
      alert('Seleccione fecha y médico');
      return;
    }

    console.log('Fecha:', this.fechaSeleccionada);
    console.log('Médico:', this.medicoSeleccionado);
    console.log('Turno:', this.turnoSeleccionado);

    this.http
      .get<any>(`http://localhost:3000/medico/${this.fechaSeleccionada}/${this.medicoSeleccionado}`)
      .subscribe({
        next: (res) => {
          this.fichas = res.data;
          console.log('fichas:', this.fichas);
        },
        error: (err) => console.error('Error al obtener fichas:', err),
      });
  }

  llamarSiguiente() {
    // Filtrar solo las fichas que estén "En espera"
    const pendientes = this.fichas.filter((f) => f.EstadoFicha === 'En espera');

    if (pendientes.length === 0) {
      console.log('No hay pacientes pendientes para llamar');
      return;
    }
    // Buscar la ficha con el número más bajo
    const siguiente = pendientes.reduce((min, f) => {
      return f.Ficha < min.Ficha ? f : min;
    }, pendientes[0]);

    console.log('Paciente a llamar:', siguiente);

    // Llamar API para actualizar estado
    this.http
      .put(`http://localhost:3000/actualizarEstadoFicha/${siguiente.idFicha}`, {
        estado: 2,
      })
      .subscribe({
        next: (res) => {
          console.log('Estado actualizado:', res);
          // Opcional: refrescar lista o actualizar el estado local
          siguiente.EstadoFicha = 'Llamado';
        },
        error: (err) => {
          console.error('Error al actualizar estado', err);
        },
      });
  }

  cancelarPaciente() {
    const pendientes = this.fichas.filter((f) => f.EstadoFicha === 'En espera');
    if (pendientes.length === 0) {
      console.log('No hay pacientes pendientes para cancelar');
      return;
    }
  }
  Atendido() {
    // Filtrar solo las fichas que estén "En espera"
    const pendientes = this.fichas.filter((f) => f.EstadoFicha === 'Llamado');

    if (pendientes.length === 0) {
      console.log('No hay pacientes pendientes para llamados');
      return;
    }
    // Buscar la ficha con el número más bajo
    const siguiente = pendientes.reduce((min, f) => {
      return f.Ficha < min.Ficha ? f : min;
    }, pendientes[0]);

    console.log('Paciente a llamar:', siguiente);

    // Llamar API para actualizar estado
    this.http
      .put(`http://localhost:3000/actualizarEstadoFicha/${siguiente.idFicha}`, {
        estado: 3,
      })
      .subscribe({
        next: (res) => {
          console.log('Estado actualizado:', res);
          // Opcional: refrescar lista o actualizar el estado local
          siguiente.EstadoFicha = 'Atendido';
        },
        error: (err) => {
          console.error('Error al actualizar estado', err);
        },
      });
  }

  ReinicarEstado() {
    // Filtrar solo las fichas que estén "En espera"
    const pendientes = this.fichas.filter((f) => f.EstadoFicha === 'Llamado');

    if (pendientes.length === 0) {
      console.log('No hay pacientes pendientes para llamados');
      return;
    }
    // Buscar la ficha con el número más bajo
    const siguiente = pendientes.reduce((min, f) => {
      return f.Ficha < min.Ficha ? f : min;
    }, pendientes[0]);

    console.log('Paciente a llamar:', siguiente);

    // Llamar API para actualizar estado
    this.http
      .put(`http://localhost:3000/actualizarEstadoFicha/${siguiente.idFicha}`, {
        estado: 1,
      })
      .subscribe({
        next: (res) => {
          console.log('Estado actualizado:', res);
          // Opcional: refrescar lista o actualizar el estado local
          siguiente.EstadoFicha = 'Atendido';
        },
        error: (err) => {
          console.error('Error al actualizar estado', err);
        },
      });
  }
}
