import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { FichasSocket } from '../../services/fichas-socket';

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
  especialidadSeleccionada = '';
  fechaSeleccionada = '';

  private http = inject(HttpClient);
  private fichasSocket = inject(FichasSocket);

  ngOnInit(): void {
    //this.suscribirseSocket();
  }

  /*private suscribirseSocket(): void {
  this.fichasSocket.onFichaActualizada().subscribe((data) => {
    console.log('Evento recibido en Fichas:', data); // 🔥 Log de depuración

    const index = this.fichas.findIndex(f => f.idFicha === data.idFicha);
    if (index !== -1) {
      this.fichas[index] = { ...this.fichas[index], EstadoFicha: data.estadoNombre };
      this.fichas = [...this.fichas]; // refresco de la vista
    }
  });*/

  /*this.fichasSocket.onFichasActualizadas().subscribe((data) => {
    console.log('Recarga completa de fichas en Fichas:', data); // 🔥 Log
    this.fichas = data;
  });*/
//}


  onFechaChange(valor: string) {
    this.fechaSeleccionada = valor;
    if (!this.fechaSeleccionada) return;
    this.cargarEspecialidades();
  }

  onEspecialidadChange(valor: string) {
    this.especialidadSeleccionada = valor;
  }

  cargarEspecialidades(): void {
    this.http.get<any>(`http://localhost:3000/especialidades/${this.fechaSeleccionada}`)
      .subscribe({
        next: (res) => this.especialidades = res.data,
        error: (err) => console.error('Error al cargar especialidades:', err)
      });
  }

  cargarFichas(): void {
    if (!this.fechaSeleccionada || !this.especialidadSeleccionada) {
      alert('Seleccione fecha y especialidad');
      return;
    }

    this.http.get<any>(`http://localhost:3000/publicas/${this.fechaSeleccionada}/${this.especialidadSeleccionada}`)
      .subscribe({
        next: (res) => this.fichas = res.data,
        error: (err) => console.error('Error al obtener fichas:', err)
      });
  }
}
