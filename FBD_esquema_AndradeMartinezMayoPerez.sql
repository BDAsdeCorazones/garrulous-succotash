/* 
-inicializar contenedor
	docker run --name some-postgres -e POSTGRES_PASSWORD=1 -d postgres 
-linea de comandos del contedor
	docker run -it --link some-postgres:postgres --rm postgres sh -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres'
-ejecutar script en contenedor 
	cat FBD_esquema_AndradeMartinezMayoPerez.sql |  docker exec -i postgres psql -Upostgres
*/
ALTER TABLE public.vuelo OWNER TO postgres;

DROP DATABASE IF EXISTS tehuacan_airlines;
DROP USER IF EXISTS manuel;

CREATE USER manuel WITH PASSWORD 'jw8s0F4' CREATEDB;

CREATE DATABASE t_air
	WITH OWNER = manuel
	ENCODING = 'UTF8'
	TABLESPACE = pg_default
	CONNECTION LIMIT = -1;


/* comenzamos con la creacion de tablas */
CREATE TABLE IF NOT EXISTS vuelo (
    flight_number integer PRIMARY KEY
);


