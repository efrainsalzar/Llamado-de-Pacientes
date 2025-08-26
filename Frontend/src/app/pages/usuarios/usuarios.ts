import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { io, Socket } from 'socket.io-client';

@Component({
  selector: 'app-usuarios',
  standalone: true,
  imports: [CommonModule, HttpClientModule],
  templateUrl: './usuarios.html',
  styleUrls: ['./usuarios.css']
})
export class Usuarios implements OnInit {
  usuarios: any[] = [];
  private http = inject(HttpClient);
  private socket!: Socket;

  ngOnInit(): void {
    this.cargarUsuarios();
    this.conectarSocket();
  }

  cargarUsuarios(): void {
    this.http.get<any[]>('http://localhost:3000/consultorio/medic_7B')
      .subscribe({
        next: (data) => {
          this.usuarios = data;
          console.log('Usuarios cargados:', this.usuarios);
        },
        error: (err) => {
          console.error('Error al obtener usuarios:', err);
        }
      });
  }

  conectarSocket(): void {
    this.socket = io('http://localhost:3000'); // URL de tu backend
    this.socket.on('fichasActualizadas', (data: any[]) => {
      this.usuarios = data.filter(f => f.consultorio === 'medic_7B');
      console.log('Fichas actualizadas en tiempo real:', this.usuarios);
    });
  }
}

