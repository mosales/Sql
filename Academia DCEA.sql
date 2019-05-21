SET SCHEMA 'public';
DROP TABLE IF EXISTS tesis;
DROP TABLE IF EXISTS articulo;
DROP TABLE IF EXISTS genera;
DROP TABLE IF EXISTS produce;
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS participa;
DROP TABLE IF EXISTS proyecto;
DROP TABLE IF EXISTS estancia;
DROP TABLE IF EXISTS pertenece;
DROP TABLE IF EXISTS lgac;
DROP TABLE IF EXISTS cuerpo_academico;
DROP TABLE IF EXISTS obtiene;
DROP TABLE IF EXISTS grado;
DROP TABLE IF EXISTS linea_investigacion;
ALTER TABLE departamento DROP CONSTRAINT IF EXISTS fk_dirige;
DROP TABLE IF EXISTS profesor;
DROP TABLE IF EXISTS departamento;
DROP TABLE IF EXISTS division;
DROP TABLE IF EXISTS campus;
CREATE TABLE campus (
        campus_id SMALLSERIAL,
        nombre VARCHAR(20) NOT NULL,
        PRIMARY KEY (campus_id)
);
CREATE TABLE division (
        division_id SMALLSERIAL,
        nombre VARCHAR (50) NOT NULL,
        campus_id SMALLINT NOT NULL,
        PRIMARY KEY (division_id),
        FOREIGN KEY (campus_id) REFERENCES campus
);
CREATE TABLE departamento (
        departamento_id SMALLSERIAL,
        nombre VARCHAR (50) NOT NULL,
        division_id SMALLINT NOT NULL,
        PRIMARY KEY (departamento_id),
        FOREIGN KEY (division_id) REFERENCES division
);
CREATE TABLE profesor (
        nue CHAR(5),
        nombre VARCHAR (30) NOT NULL,
        paterno VARCHAR (30) NOT NULL,
        materno VARCHAR (30),
        fecha_contrato DATE,
        departamento_id SMALLINT,
        PRIMARY KEY (nue),
        FOREIGN KEY (departamento_id) REFERENCES departamento
);
ALTER TABLE departamento ADD nue CHAR (5);
ALTER TABLE departamento ADD CONSTRAINT fk_dirige FOREIGN KEY (nue) REFERENCES profesor;
CREATE TABLE linea_investigacion (
        nue VARCHAR(5),
        linea VARCHAR (50),
        PRIMARY KEY (nue, linea),
        FOREIGN KEY (nue) REFERENCES profesor
);
CREATE TABLE grado (
        grado_id SMALLSERIAL,
        nombre VARCHAR(25) NOT NULL,
        PRIMARY KEY (grado_id)
);
CREATE TABLE obtiene (
        grado_id SMALLINT,
        nue VARCHAR (5),
        descripcion VARCHAR (100) NOT NULL,
        institucion VARCHAR (50),
        fecha_obtencion DATE,
        PRIMARY KEY (grado_id, nue),
        FOREIGN KEY (grado_id) REFERENCES grado,
        FOREIGN KEY (nue) REFERENCES profesor      
);
CREATE TABLE cuerpo_academico (
        cuerpo_id SMALLSERIAL,
        nombre VARCHAR (50),                
        fecha_ingreso DATE,
        division_id SMALLINT,
        nue CHAR (5),
        PRIMARY KEY (cuerpo_id),
        FOREIGN KEY (division_id) REFERENCES division,
        FOREIGN KEY (nue) REFERENCES profesor
);
CREATE TABLE lgac (
        cuerpo_id SMALLINT,
        linea VARCHAR (50),
        PRIMARY KEY (cuerpo_id, linea),
        FOREIGN KEY (cuerpo_id) REFERENCES cuerpo_academico
);
CREATE TABLE pertenece (
        cuerpo_id SMALLINT,
        nue CHAR(5) UNIQUE,
        PRIMARY KEY (cuerpo_id, nue),
        FOREIGN KEY (cuerpo_id) REFERENCES cuerpo_academico,
        FOREIGN KEY (nue) REFERENCES profesor
);
CREATE TABLE estancia (
        estancia_id SMALLSERIAL,
        lugar VARCHAR (125) NOT NULL,
        fecha_ini DATE NOT NULL,
        fecha_fin DATE,
        nue CHAR(5),
        PRIMARY KEY (estancia_id),
        FOREIGN KEY (nue) REFERENCES profesor
);
CREATE TABLE proyecto (
        proyecto_id SMALLSERIAL,
        nombre VARCHAR(100) NOT NULL,
        patrocinador VARCHAR(50) NOT NULL,
        fecha_ini DATE NOT NULL,
        fecha_fin DATE,
        monto MONEY NOT NULL,
        nue CHAR(5),
        PRIMARY KEY (proyecto_id),
        FOREIGN KEY (nue) REFERENCES profesor
);
CREATE TABLE participa(
        proyecto_id SMALLINT,
        nue CHAR(5),
        PRIMARY KEY (proyecto_id, nue),
        FOREIGN KEY (proyecto_id) REFERENCES proyecto,
        FOREIGN KEY (nue) REFERENCES profesor
);
CREATE TABLE producto (
        producto_id SERIAL,
        nombre VARCHAR (100) NOT NULL,
        anio DATE NOT NULL,
        no_paginas SMALLINT,
        PRIMARY KEY (producto_id)
);
CREATE TABLE produce (
        producto_id INT,
        nue CHAR(5),
        PRIMARY KEY (producto_id, nue),
        FOREIGN KEY (producto_id) REFERENCES producto,
        FOREIGN KEY (nue) REFERENCES profesor
);
CREATE TABLE genera (
        producto_id INT,
        proyecto_id SMALLINT,        
        PRIMARY KEY (producto_id),
        FOREIGN KEY (producto_id) REFERENCES producto,
        FOREIGN KEY (proyecto_id) REFERENCES proyecto        
);
CREATE TABLE articulo (
        producto_id INT,
        indizado BOOLEAN,
        issn VARCHAR (25),
        doi VARCHAR (20),
        revista VARCHAR (30),
        editorial VARCHAR (30),
        PRIMARY KEY (producto_id),
        FOREIGN KEY (producto_id) REFERENCES producto
);
CREATE TABLE tesis (
        producto_id INT,
        grado_id SMALLINT,
        almuno VARCHAR (70),
        programa VARCHAR (50),
        PRIMARY KEY (producto_id),
        FOREIGN KEY (producto_id) REFERENCES producto,
        FOREIGN KEY (grado_id) REFERENCES grado
);