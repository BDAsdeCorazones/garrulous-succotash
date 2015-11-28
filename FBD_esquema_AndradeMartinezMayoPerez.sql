-- 
-- -inicializar contenedor
-- 	docker run --name some-postgres -p 5432:5432 -e POSTGRES_PASSWORD=1 -d postgres 
-- -linea de comandos del contedor
-- 	docker run -p 5433:5432 -it --link some-postgres:postgres --rm postgres sh -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres && $POSTGRES_PORT_5432_TCP_ADDR'
-- -ejecutar script en contenedor 
-- 	cat FBD_esquema_AndradeMartinezMayoPerez.sql |  docker exec -i postgres psql -Upostgres
 
DROP DATABASE IF EXISTS t_air;
DROP USER IF EXISTS manuel;

CREATE USER manuel WITH PASSWORD 'jw8s0F4' CREATEDB;

CREATE DATABASE t_air
	WITH OWNER = manuel
	ENCODING = 'UTF8'
	TABLESPACE = pg_default
	CONNECTION LIMIT = -1;

\c t_air


-- comenzamos con la creacion de tablas */
CREATE TABLE vuelo (
    flight_number integer PRIMARY KEY,
    iata_origen text NOT NULL,
    iata_destino text NOT NULL,
    fecha_salida timestamp with timezone NOT NULL,
    fecha_llegada timestamp with timezone NOT NULL,
    aerolinea text NOT NULL,
    modelo_avion integer
);


