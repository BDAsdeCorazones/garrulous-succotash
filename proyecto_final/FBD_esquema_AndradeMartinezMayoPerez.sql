-- 
-- -inicializar contenedor
-- 	docker run --name some-postgres -p 5432:5432 -e POSTGRES_PASSWORD=1 -d postgres 
-- -linea de comandos del contedor
-- 	docker run -p 5433:5432 -it --link some-postgres:postgres --rm postgres sh -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres && $POSTGRES_PORT_5432_TCP_ADDR'
-- -ejecutar script en contenedor 
-- 	cat FBD_esquema_AndradeMartinezMayoPerez.sql |  docker exec -i postgres psql -Upostgres
DROP DATABASE IF EXISTS t_air;
DROP USER IF EXISTS admin;

CREATE USER admin WITH PASSWORD 'jw8s0F4' CREATEDB;

CREATE OR REPLACE FUNCTION sha1(bytea) RETURN TEXT AS $$
SELECT encode(digest($1, 'sha1'), 'hex')
$$ LANGUAGE SQL strict inmutable;

CREATE DATABASE t_air
	WITH OWNER = admin
	ENCODING = 'UTF8'
	TABLESPACE = pg_default
	CONNECTION LIMIT = -1;

-- conectamos con la base de datos
\c t_air


CREATE TABLE vuelo (
    flight_number text PRIMARY KEY,
    iata_origen text NOT NULL,
    iata_destino text NOT NULL,
    fecha_salida timestamp NOT NULL,
    fecha_llegada timestamp NOT NULL,
    aerolinea text NOT NULL,
    modelo_avion text NOT NULL,
    UNIQUE(flight_number),
    CONSTRAINT not_local CHECK ((iata_origen <> iata_destino))
);

CREATE TABLE asiento (
    flight_number text REFERENCES vuelo(flight_number),
    posicion text NOT NULL ,
    categoria text NOT NULL,
    costo real NOT NULL,
    disponible boolean NOT NULL,
    UNIQUE(flight_number, posicion),
    CONSTRAINT categoria_valida CHECK ((char_length(categoria) >= 3)),
    CONSTRAINT costo_negativo CHECK (costo > 0),
    CONSTRAINT posicion_valida CHECK ((char_length(posicion) >= 2) AND (char_length(posicion) < 5))
);

CREATE TABLE cliente (
    id_cliente serial PRIMARY KEY,
    nombres_completo text NOT NULL,
    genero boolean NOT NULL,
    fecha_nacimiento date NOT NULL,
    correo text NOT NULL,
    telefono text,
    UNIQUE(correo)
    --CONSTRAINT children_detector CHECK (date_part('years', interval age(fecha_nacimiento))) > 2),
);

CREATE TABLE vendedor (
    rfc text PRIMARY KEY,
    nombres_completo text NOT NULL,
    telefono text NOT NULL,
    password text NOT NULL
);

CREATE TABLE venta (
    id_venta serial PRIMARY KEY,
    flight_number text NOT NULL,
    asiento text NOT NULL,
    fecha timestamp NOT NULL,
    cliente integer REFERENCES cliente(id_cliente),
    vendedor text REFERENCES vendedor(rfc),
    FOREIGN KEY (flight_number, asiento) REFERENCES asiento (flight_number, posicion)
);
