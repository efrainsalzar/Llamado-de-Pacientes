import { Routes } from '@angular/router';
import { Home } from './pages/home/home';
import { Fichas } from './pages/fichas/fichas';
import { Usuarios } from './pages/usuarios/usuarios';

export const routes: Routes = [
  { path: '', component: Home },
  { path: 'fichas', component: Fichas },
  { path: 'usuarios', component: Usuarios }
];
