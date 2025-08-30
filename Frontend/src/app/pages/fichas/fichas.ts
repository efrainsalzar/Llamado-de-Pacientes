import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { io, Socket } from 'socket.io-client';

@Component({
  selector: 'app-fichas',
  standalone: true,
  imports: [CommonModule, HttpClientModule],
  templateUrl: './fichas.html',
  styleUrls: ['./fichas.css']
})
export class Fichas implements OnInit {
  fichas: any[] = [];   // aquí guardamos los datos del backend
  private http = inject(HttpClient);
  private socket!: Socket;

  ngOnInit(): void {
    this.cargarFichas();
    this.conectarSocket();
  }

  // Carga inicial de fichas
  cargarFichas(): void {
    this.http.get<any>('http://localhost:3000/publicas/390/2014-10-15')
      .subscribe({
        next: (res) => {
          this.fichas = res.data;
          console.log('Fichas cargadas:', this.fichas);
        },
        error: (err) => {
          console.error('Error al obtener fichas:', err);
        }
      });
  }

  // Conexión a Socket.IO para recibir actualizaciones en tiempo real
  conectarSocket(): void {
    this.socket = io('http://localhost:3000'); // URL de tu backend
    this.socket.on('fichasActualizadas', (data: any[]) => {
      this.fichas = data;
      console.log('Fichas actualizadas en tiempo real:', this.fichas);
    });
  }
}
