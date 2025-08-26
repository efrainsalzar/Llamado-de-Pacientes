SELECT *
FROM fichas
WHERE fecha = CAST(GETDATE() AS DATE)
ORDER BY hora_registro ASC;

SELECT *
FROM fichas
WHERE fecha = '2025-07-24'
ORDER BY hora_registro ASC;

SELECT 
    id_ficha,
    id_paciente,
    CAST(fecha AS date) AS fecha,
    CAST(hora_registro AS time) AS hora_registro,
    consultorio,
    estado,
    CAST(hora_llamado AS time) AS hora_llamado,
    CAST(hora_finalizacion AS time) AS hora_finalizacion
FROM fichas
WHERE fecha = CAST(GETDATE() AS DATE)
ORDER BY hora_registro ASC;

        SELECT 
            id_ficha,
            id_paciente,
            fecha,
            estado,
            consultorio,
            hora_registro,
            hora_llamado,
            hora_finalizacion
        FROM fichas
        WHERE fecha = CAST(GETDATE() AS DATE)
        ORDER BY hora_registro ASC;
