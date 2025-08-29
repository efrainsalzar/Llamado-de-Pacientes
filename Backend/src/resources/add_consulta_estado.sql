-- 1. Crear tabla de estados
CREATE TABLE tbESTADOFICHA (
    idEstadoFicha INT PRIMARY KEY IDENTITY(1,1),
    descripcion NVARCHAR(100) NOT NULL
);

-- 2. Insertar estados iniciales
INSERT INTO tbESTADOFICHA (descripcion) VALUES 
('En espera'),
('Llamado'),
('Atendido'),
('Cancelado');

-- 3. Agregar columna estadoFicha en fichas (NULL por ahora)
ALTER TABLE tblFICHAS
ADD estadoFicha INT NULL;

-- 4. Actualizar registros existentes
UPDATE tblFICHAS
SET estadoFicha = 1
WHERE estadoFicha IS NULL;

-- 5. Hacer columna NOT NULL y agregar valor por defecto
ALTER TABLE tblFICHAS
ALTER COLUMN estadoFicha INT NOT NULL;

ALTER TABLE tblFICHAS
ADD CONSTRAINT DF_Ficha_EstadoFicha
DEFAULT 1 FOR estadoFicha;

-- 6. Crear la foreign key correcta
ALTER TABLE tblFICHAS
ADD CONSTRAINT FK_Ficha_Estado
FOREIGN KEY (estadoFicha) REFERENCES tbESTADOFICHA(idEstadoFicha)
ON DELETE NO ACTION
ON UPDATE CASCADE;
