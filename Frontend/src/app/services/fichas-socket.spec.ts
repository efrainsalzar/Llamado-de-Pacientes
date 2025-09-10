import { TestBed } from '@angular/core/testing';

import { FichasSocket } from './fichas-socket';

describe('FichasSocket', () => {
  let service: FichasSocket;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(FichasSocket);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
