import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { io, Socket } from 'socket.io-client';

@Component({
  selector: 'app-fichas',
  standalone: true,
  imports: [CommonModule, HttpClientModule, FormsModule],
  templateUrl: './fichas.html',
  styleUrls: ['./fichas.css']
})
export class Fichas implements OnInit {
  fichas: any[] = [];
  especialidades: any[] = [];
  especialidadSeleccionada: string = '';
  fechaSeleccionada: string = '';

  private http = inject(HttpClient);
  private socket!: Socket;

  ngOnInit(): void {
    this.cargarEspecialidades();
    this.conectarSocket();
  }

  // Traer lista de especialidades desde backend
  cargarEspecialidades(): void {
    this.http.get<any>('http://localhost:3000/especialidades')
      .subscribe({
        next: (res) => {
          this.especialidades = res.data;
          console.log('Especialidades:', this.especialidades);
        },
        error: (err) => console.error('Error al cargar especialidades:', err)
      });
  }

  onEspecialidadChange(valor: string) {
  console.log('Especialidad seleccionada:', valor);
}


  // Cargar fichas filtradas por fecha y especialidad
  cargarFichas(): void {
    console.log('Valor seleccionado:', this.especialidadSeleccionada);
    if (!this.fechaSeleccionada || !this.especialidadSeleccionada) {
      alert('Seleccione fecha y especialidad');
      return;
    }
    console.log(this.fechaSeleccionada);
    console.log(this.especialidadSeleccionada);

    this.http.get<any>(
      `http://localhost:3000/publicas/${this.fechaSeleccionada}/${this.especialidadSeleccionada}`
    ).subscribe({
      next: (res) => {
        this.fichas = res.data;
        console.log('Fichas cargadas:', this.fichas);
      },
      error: (err) => console.error('Error al obtener fichas:', err)
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
