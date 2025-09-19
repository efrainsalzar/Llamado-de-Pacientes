export interface Ficha {
  IDFicha: number;
  Ficha: number;
  Ticket: string;
  Periodo: string;
  FechaInicio: string;
  Horario: string;
  paciente: string;
  Servicio: string;
  Consultorio: string;
  medico: string;
  DesEstadoVista: string;
}

export interface Especialidad {
  CUA_CODIGO: number;
  Especialidad: string;
}