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
  styleUrls: ['./usuarios.css']
})
export class Usuarios implements OnInit {
  fichas: any[] = [];
  medicos: any[] = [];                  // Lista de médicos
  medicoSeleccionado: string = '';      // Médico elegido
  fechaSeleccionada: string = '';       // Fecha elegida

  private http = inject(HttpClient);
  private socket!: Socket;

  ngOnInit(): void {
    this.cargarMedicos();  // Traer lista de médicos
    this.conectarSocket();
  }

  // Traer lista de médicos desde backend
  cargarMedicos(): void {
    this.http.get<any>('http://localhost:3000/medicos')
      .subscribe({
        next: (res) => {
          this.medicos = res.data;
          console.log('Médicos:', this.medicos);
        },
        error: (err) => console.error('Error al cargar médicos:', err)
      });
  }

  // Capturar cambio de médico seleccionado
  onMedicoChange(valor: string) {
    this.medicoSeleccionado = valor;
    console.log('Médico seleccionado:', valor);
  }

  // Cargar usuarios filtrados por médico y fecha
  cargarFichas(): void {
    if (!this.fechaSeleccionada || !this.medicoSeleccionado) {
      alert('Seleccione fecha y médico');
      return;
    }

    console.log('Fecha:', this.fechaSeleccionada);
    console.log('Médico:', this.medicoSeleccionado);

    this.http.get<any>(
      `http://localhost:3000/medico/${this.fechaSeleccionada}/${this.medicoSeleccionado}`
    ).subscribe({
      next: (res) => {
        this.fichas = res.data;
        console.log('Usuarios cargados:', this.fichas);
      },
      error: (err) => console.error('Error al obtener usuarios:', err)
    });
  }

  // Conexión a Socket.IO
  conectarSocket(): void {
    this.socket = io('http://localhost:3000');
    this.socket.on('fichasActualizadas', (data: any[]) => {
      this.fichas = data;
      console.log('Fichas actualizadas en tiempo real:', this.fichas);
    });
  }
}
