DROP USER IF EXISTS administrador;
CREATE USER administrador WITH SUPERUSER PASSWORD '1234' VALID UNTIL '2020-01-01';

ALTER DATABASE t_air OWNER TO administrador;

DROP USER IF EXISTS standard;
CREATE USER standard  PASSWORD '1234' VALID UNTIL '2020-01-01';

REVOKE ALL ON vuelo FROM standard;
REVOKE ALL ON vendedor FROM standard;
REVOKE ALL ON asiento FROM standard;

GRANT SELECT, UPDATE ON vendedor TO standard WITH GRANT OPTION;  
GRANT SELECT, UPDATE ON asiento,vuelo TO standard WITH GRANT OPTION;  
GRANT SELECT,INSERT, UPDATE ON venta,cliente TO standard WITH GRANT OPTION;  
--top secret
ALTER FUNCTION nombre_del_mejor_vendedor_de_la_historia() OWNER TO administrador;
ALTER FUNCTION mejores_vendedores(timestamp, timestamp) OWNER TO administrador;
ALTER FUNCTION venta_costo_vendedor(text) OWNER TO administrador;
ALTER FUNCTION destinos_mas_visitados_mes(timestamp) OWNER TO administrador;