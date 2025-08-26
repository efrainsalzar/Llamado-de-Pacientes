import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HttpClient, HttpClientModule } from '@angular/common/http';

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

  ngOnInit(): void {
    this.cargarUsuarios();
  }

  cargarUsuarios(): void {
    this.http.get<any[]>('http://localhost:3000/consultorio/Pediatria AC')
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
}
