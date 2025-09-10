import { Injectable, NgZone } from '@angular/core';
import { BehaviorSubject } from 'rxjs';
import { io, Socket } from 'socket.io-client';

@Injectable({
  providedIn: 'root'
})
export class FichasSocket {
  private socket: Socket;
  public fichasSubject = new BehaviorSubject<any[]>([]);
  fichas$ = this.fichasSubject.asObservable();

  constructor(private ngZone: NgZone) {
    this.socket = io('http://localhost:3000');

    // Escuchar ficha actualizada
    this.socket.on('fichaActualizada', (ficha: any) => {
      console.log('[SOCKET] fichaActualizada recibida:', ficha);

      this.ngZone.run(() => {
        const fichasActualizadas = this.fichasSubject.value.map(f =>
          f.idFicha === ficha.idFicha ? ficha : f
        );
        this.fichasSubject.next(fichasActualizadas);

        console.log('[SOCKET] Fichas actualizadas desde el BehaviorSubject:', fichasActualizadas);
      });
    });
  }

  setFichasIniciales(fichas: any[]) {
    console.log('[SOCKET] Fichas iniciales seteadas:', fichas);
    this.fichasSubject.next(fichas);
  }
}
