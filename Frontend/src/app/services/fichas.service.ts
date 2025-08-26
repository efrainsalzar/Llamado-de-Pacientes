/*import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Ficha } from '../models/ficha.model'; // 🔹 solo este

@Injectable({
  providedIn: 'root'
})
export class FichasService {
  private apiUrl = 'http://localhost:3000/hoy'; // ajusta a tu backend

  constructor(private http: HttpClient) {}

  getFichas(): Observable<Ficha[]> {
    return this.http.get<Ficha[]>(this.apiUrl);
  }
}
*/
