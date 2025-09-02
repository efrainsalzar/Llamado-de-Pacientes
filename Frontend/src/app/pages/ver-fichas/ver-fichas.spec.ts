import { ComponentFixture, TestBed } from '@angular/core/testing';

import { VerFichas } from './ver-fichas';

describe('VerFichas', () => {
  let component: VerFichas;
  let fixture: ComponentFixture<VerFichas>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [VerFichas]
    })
    .compileComponents();

    fixture = TestBed.createComponent(VerFichas);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
