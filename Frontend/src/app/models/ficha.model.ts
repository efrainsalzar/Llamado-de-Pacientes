export interface Ficha {
  id_ficha: number;
  id_paciente: number;
  fecha: string;           // 'YYYY-MM-DD'
  estado: 'espera' | 'atendiendo' | 'atendido' | 'ausente';
  consultorio?: string;
  hora_registro: string;    // 'HH:MM:SS'
  hora_llamado?: string;
  hora_finalizacion?: string;
}
