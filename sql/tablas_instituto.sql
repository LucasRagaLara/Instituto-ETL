drop database instituto;

create database instituto;

ALTER DATABASE instituto CHARACTER SET =utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE cursos_temporal (codigo VARCHAR(255), nombre_cas VARCHAR(255), padre VARCHAR(255) );

-------------
CREATE TABLE alumnos_temporal (
    anyo INT NOT NULL,
    nia VARCHAR(255) NOT NULL,
    anyo_nia_grupo VARCHAR(150) NOT NULL,
    anyo_grupo_al varchar(100), -- nuevo (relacion con grupos para powerbi)
    anyo_nia_cursos_alumnos VARCHAR(255),
    fecha_exportacion DATE NOT NULL,
    nacionalidad VARCHAR(100),
    sexo varchar(2),
    provincia VARCHAR(100),
    municipio VARCHAR(100),
    cursos_alumnos VARCHAR(255),
    grupo_al VARCHAR(100),
    turno VARCHAR(50),
    PRIMARY KEY(anyo_nia_grupo)
);

--------------------

CREATE TABLE grupo (
    anyo INT, 
    codigo varchar(50),
    codigo_anyo varchar(100), -- nuevo (relacion con grupos para powerbi)
    fecha_exportacion DATE,
    nombre varchar(50),
    curso varchar(2), 
    grado varchar(100),
    turno varchar(2),
    PRIMARY KEY(codigo_anyo)
);

CREATE TABLE alumnos (
    anyo INT NOT NULL,
    nia VARCHAR(255) NOT NULL,
    anyo_nia_grupo VARCHAR(150) NOT NULL,
    anyo_grupo_al varchar(100), -- nuevo (relacion con grupos para powerbi)
    anyo_nia_cursos_alumnos VARCHAR(255), -- nuevo (relacion con calificaciones para powerbi)
    fecha_exportacion DATE NOT NULL,
    nacionalidad VARCHAR(100),
    sexo varchar(2),
    provincia VARCHAR(100),
    municipio VARCHAR(100),
    cursos_alumnos VARCHAR(255),
    grupo_al VARCHAR(100),
    turno VARCHAR(50),
    curso_alumno VARCHAR(100),
    grupo_alumno VARCHAR(200),
    grado_alumno VARCHAR(100),
    familia_alumno VARCHAR(200),
    PRIMARY KEY(anyo_nia_grupo) -- CLAVE COMPUESTA UNICA
);

CREATE TABLE Calificaciones (
    anyo INT,
    nia VARCHAR(255),
    anyo_evaluacion_nia_contenido VARCHAR(190),
    anyo_nia_curso varchar(255), -- nuevo (relacion con alumnos para powerbi)
    anyo_curso_contenido varchar(255), -- nuevo (relaciona con modulos (anyo_curso_codigo) para powerbi)
    evaluacion VARCHAR(10),
    curso VARCHAR(100),
    contenido VARCHAR(100),
    nota INT,
    PRIMARY KEY (anyo_evaluacion_nia_contenido)
);

CREATE TABLE modulos_temporal (
    anyo INT NOT NULL,
    codigo_curso VARCHAR(100) NOT NULL,
    anyo_codigo_curso VARCHAR(190),
    anyo_curso_codigo VARCHAR(190), -- nuevo (relaciona con calificaciones para powerbi)
    curso VARCHAR(100),
    codigo VARCHAR(50) NOT NULL,
    nombre_cas VARCHAR(255),
    PRIMARY KEY(anyo_codigo_curso)
);

-- modulo se relaciona con horas a través del codigo 

CREATE TABLE horas (
    anyo INT NOT NULL,
    codigo VARCHAR(50) NOT NULL,
    codigo_ciclo VARCHAR(100) NOT NULL,
    anyo_codigo_ciclo VARCHAR(100) NOT NULL,
    nombre_cas VARCHAR(255),
    ciclo varchar(200),
    horas INT,
    PRIMARY KEY(anyo_codigo_ciclo)
);

-- CREATE TABLE modulos (
--     anyo INT NOT NULL,
--     codigo_curso VARCHAR(100) NOT NULL,
--     anyo_curso_codigo VARCHAR(190), -- nuevo (relaciona con calificaciones para
--     anyo_codigo_ciclo VARCHAR(190),
--     curso VARCHAR(100),
--     codigo VARCHAR(50) NOT NULL,
--     nombre_cas VARCHAR(255),
--     ciclo varchar(200),
--     horas INT,
--     PRIMARY KEY(anyo_codigo_ciclo)
-- );

CREATE TABLE modulos (
    anyo INT NOT NULL,
    codigo_curso VARCHAR(100) NOT NULL,
    anyo_curso_codigo VARCHAR(190),
    anyo_codigo_ciclo VARCHAR(190),
    curso VARCHAR(100),
    codigo VARCHAR(50) NOT NULL,
    nombre_cas VARCHAR(255),
    PRIMARY KEY(anyo_codigo_ciclo)
);


/* TABLAS DE LA PARTE DE LOS INDICADORES */ 

CREATE TABLE objetivos_temporal (
    objetivo_paa VARCHAR(10),
    linea INT,
    descripcion TEXT
);

CREATE TABLE lineas_temporal (
    linea INT,
    descripcion TEXT
);

CREATE TABLE procesos_temporal (
    proceso VARCHAR(10) PRIMARY KEY,
    descripcion TEXT
);

CREATE TABLE indicadores_temporales (
    anyo INT,
    identificador VARCHAR(50),
    indicador TEXT,
    periodicidad VARCHAR(20),
    escala FLOAT,
    objetivo_valor FLOAT,
    codigo_indicador VARCHAR(50),
    tipo_escala VARCHAR(20),
    periodo VARCHAR(10),
    valor FLOAT,
    curso_iden VARCHAR(50)
);

CREATE TABLE objetivos_lineas (
    objetivo_paa VARCHAR(10) PRIMARY KEY,
    linea INT,
    descripcion_objetivo TEXT,
    descripcion_linea TEXT
);