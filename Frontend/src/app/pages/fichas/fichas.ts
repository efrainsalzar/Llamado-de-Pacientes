import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FichasService } from '../../services/fichas.service';
import { Ficha } from '../../models/ficha.model';

@Component({
  selector: 'app-fichas',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './fichas.html',
  styleUrls: ['./fichas.css']
})
export class Fichas {
  fichas: Ficha[] = [];
  cargando = true;

  constructor(private fichasService: FichasService) {}

  ngOnInit(): void {
    this.fichasService.getFichas().subscribe({
      next: (data) => {
        this.fichas = data;
        this.cargando = false;
      },
      error: (err) => {
        console.error('Error al cargar fichas:', err);
        this.cargando = false;
      }
    });
  }
}
