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