import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { HttpClient, HttpClientModule } from '@angular/common/http';

@Component({
  selector: 'app-fichas',
  standalone: true,
  imports: [CommonModule, HttpClientModule],
  templateUrl: './fichas.html',
  styleUrls: ['./fichas.css']
})
export class Fichas implements OnInit {
  fichas: any[] = [];   // aquí guardamos los datos que vienen del backend
  private http = inject(HttpClient);

  ngOnInit(): void {
    this.cargarFichas();
  }

  cargarFichas(): void {
    this.http.get<any[]>('http://localhost:3000/')
      .subscribe({
        next: (data) => {
          this.fichas = data;
          console.log('Fichas cargadas:', this.fichas);
        },
        error: (err) => {
          console.error('Error al obtener fichas:', err);
        }
      });
  }
}
