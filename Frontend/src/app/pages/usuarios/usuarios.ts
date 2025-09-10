import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { FichasSocket } from '../../services/fichas-socket';

@Component({
  selector: 'app-usuarios',
  standalone: true,
  imports: [CommonModule, HttpClientModule, FormsModule],
  templateUrl: './usuarios.html',
  styleUrls: ['./usuarios.css'],
})
export class Usuarios implements OnInit {
  medicos: any[] = [];
  turnos: any[] = [];
  medicoSeleccionado = '';
  fechaSeleccionada = '';
  turnoSeleccionado = '';

  private http = inject(HttpClient);
  private fichasSocket = inject(FichasSocket);

  fichas$ = this.fichasSocket.fichas$;

  ngOnInit(): void {
    console.log('Usuarios component inicializado');

    this.fichas$.subscribe(f => {
    console.log('Fichas actualizadas desde el socket:', f);
  });
  }

  onFechaChange(valor: string) {
    console.log('Fecha seleccionada:', valor);
    this.fechaSeleccionada = valor;
    if (!this.fechaSeleccionada) return;
    this.cargarMedicos();
    this.cargarTurnos();
  }

  onMedicoChange(valor: string) {
    console.log('Médico seleccionado:', valor);
    this.medicoSeleccionado = valor;
  }

  onTurnoChange(valor: string) {
    console.log('Turno seleccionado:', valor);
    this.turnoSeleccionado = valor;
  }

  cargarMedicos(): void {
    console.log(`Cargando médicos para fecha: ${this.fechaSeleccionada}`);
    this.http.get<any>(`http://localhost:3000/medicos/${this.fechaSeleccionada}`)
      .subscribe({
        next: (res) => {
          this.medicos = res.data;
          console.log('Médicos cargados:', this.medicos);
        },
        error: (err) => console.error('Error al cargar médicos:', err)
      });
  }

  cargarTurnos(): void {
    console.log(`Cargando turnos para fecha: ${this.fechaSeleccionada}`);
    this.http.get<any>(`http://localhost:3000/turnos/${this.fechaSeleccionada}`)
      .subscribe({
        next: (res) => {
          this.turnos = res.data;
          console.log('Turnos cargados:', this.turnos);
        },
        error: (err) => console.error('Error al cargar turnos:', err)
      });
  }

  cargarFichas(): void {
    if (!this.fechaSeleccionada || !this.medicoSeleccionado) {
      alert('Seleccione fecha y médico');
      console.warn('Intento de cargar fichas sin fecha o médico seleccionado');
      return;
    }

    const url = this.turnoSeleccionado
      ? `http://localhost:3000/medicoPeriodo/${this.fechaSeleccionada}/${this.medicoSeleccionado}/${this.turnoSeleccionado}`
      : `http://localhost:3000/medico/${this.fechaSeleccionada}/${this.medicoSeleccionado}`;

    console.log('Cargando fichas desde URL:', url);

    this.http.get<any>(url)
      .subscribe({
        next: res => {
          console.log('Fichas obtenidas del servidor:', res.data);
          this.fichasSocket.setFichasIniciales(res.data);
        },
        error: (err) => console.error('Error al obtener fichas:', err)
      });
  }

  // Actualización de estados
  private actualizarEstadoFicha(ficha: any, nuevoEstado: number) {
    console.log(`Actualizando ficha ${ficha.idFicha} de estado ${ficha.EstadoFicha} a ${nuevoEstado}`);

    this.http.put(`http://localhost:3000/actualizarEstadoFicha/${ficha.idFicha}`, { estado: nuevoEstado })
      .subscribe({
        next: (res) => {
          console.log(`Solicitud de actualización enviada para ficha ${ficha.idFicha}`);
          console.log('Respuesta del PUT:', res);
        },
        error: (err) => console.error(`Error al actualizar ficha ${ficha.idFicha}`, err)
      });
  }

  private obtenerSiguiente(permitidos: string[]): any | null {
    const fichasActuales = this.fichasSocket.fichasSubject.value;
    const pendientes = fichasActuales.filter(f => permitidos.includes(f.EstadoFicha));
    console.log('Fichas pendientes para', permitidos, ':', pendientes);
    if (!pendientes.length) return null;
    return pendientes.reduce((min, f) => f.Ficha < min.Ficha ? f : min, pendientes[0]);
  }

  // Acciones sobre pacientes
  llamarSiguiente() {
    console.log('Intentando llamar siguiente paciente');
    const ficha = this.obtenerSiguiente(['En espera']);
    if (ficha) this.actualizarEstadoFicha(ficha, 2);
  }

  atenderPaciente() {
    console.log('Intentando atender paciente');
    const ficha = this.obtenerSiguiente(['Llamado']);
    if (ficha) this.actualizarEstadoFicha(ficha, 3);
  }

  cancelarPaciente() {
    console.log('Intentando cancelar paciente');
    const ficha = this.obtenerSiguiente(['En espera', 'Llamado']);
    if (ficha) this.actualizarEstadoFicha(ficha, 4);
  }

  reiniciarEstado() {
    console.log('Reiniciando estados de fichas');
    const fichasActuales = this.fichasSocket.fichasSubject.value;
    fichasActuales.filter(f => ['Llamado','Atendido','Cancelado'].includes(f.EstadoFicha))
                   .forEach(f => this.actualizarEstadoFicha(f,1));
  }
}
