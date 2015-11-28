CREATE USER manuel WITH PASSWORD 'jw8s0F4' CREATEDB;

CREATE DATABASE tehuacan_airlines
	WITH OWNER = manuel
	ENCODING = 'UTF8'
	TABLESPACE = pg_default
	LC_COLLATE = 'en_US.UTF-8'
	LC_CTYPE = 'en_US.UTF-8'
	CONNECTION LIMIT = -1;


/* comenzamos con la creacion de tablas */
CREATE TABLE vuelo (
    flight_number integer PRIMARY KEY
);


ALTER TABLE public.vuelo OWNER TO manuel;