import { Component } from '@angular/core';

@Component({
  selector: 'app-fichas',
  imports: [],
  templateUrl: './fichas.html',
  styleUrl: './fichas.css'
})


export class Fichas {

}

document.addEventListener('DOMContentLoaded', function() {
  const specialtyCards = document.querySelectorAll('.specialty-card');

  specialtyCards.forEach(card => {
    card.addEventListener('click', () => {
      // Elimina la clase 'selected' de todas las tarjetas
      specialtyCards.forEach(c => c.classList.remove('selected'));

      // Agrega la clase 'selected' a la tarjeta clicada
      card.classList.add('selected');

      // Opcional: Obtener el valor de la especialidad seleccionada
      const selectedSpecialty = card.getAttribute('data-specialty');
      console.log('Especialidad seleccionada:', selectedSpecialty);
    });
  });
});
