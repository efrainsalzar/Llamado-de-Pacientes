CREATE TABLE fichas (
    id_ficha INT IDENTITY(1,1) PRIMARY KEY,
    id_paciente INT NOT NULL, -- FK hacia la base de datos de pacientes
    fecha DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),
    estado VARCHAR(20) NOT NULL DEFAULT 'espera' 
        CONSTRAINT chk_estado CHECK (estado IN ('espera', 'atendiendo', 'atendido', 'ausente')),
    consultorio VARCHAR(50) NULL,
    hora_registro TIME NOT NULL DEFAULT CAST(GETDATE() AS TIME), -- solo hora
    hora_llamado TIME NULL,
    hora_finalizacion TIME NULL
);



-- Ejemplo 1
INSERT INTO fichas (id_paciente, estado, consultorio)
VALUES (101, 'espera', 'Consultorio A');

-- Ejemplo 2
INSERT INTO fichas (id_paciente, estado, consultorio)
VALUES (102, 'espera', 'Consultorio B');

-- Ejemplo 3
INSERT INTO fichas (id_paciente, estado, consultorio)
VALUES (103, 'espera', 'Consultorio A');


-- con fecha
-- Ejemplo 1
INSERT INTO fichas (id_paciente, fecha, estado, consultorio)
VALUES (10,  '2025-08-24', 'espera','Consultorio A');

-- Ejemplo 2
INSERT INTO fichas (id_paciente, fecha, estado, consultorio)
VALUES (11,  '2025-07-24','espera', 'Consultorio b');

-- Ejemplo 3
INSERT INTO fichas (id_paciente, fecha, consultorio)
VALUES (12, '2025-07-24', 'Consultorio c');


select * from fichas

drop table fichas