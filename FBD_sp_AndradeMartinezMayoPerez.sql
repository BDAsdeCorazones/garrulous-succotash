--nos da el beneficio obtenido por un vendedor
CREATE OR REPLACE FUNCTION venta_costo_vendedor(text) RETURNS real AS $$
    select sum(costo) c from asiento a right join (select * from venta where vendedor = $1) v on v.flight_number = a.flight_number;
$$ LANGUAGE SQL;
-- ejemplo recreativo 
select venta_costo_vendedor('128KfvXdrnzMvsFYqDcHdirk5Rex1444vg') as s;
--nos da los mejores vendores en un intervalo de tiempo
CREATE OR REPLACE FUNCTION mejores_vendedores(timestamp, timestamp) RETURNS TABLE(nombres text, total bigint) AS $$
SELECT nombres_completo, n_ventas FROM (select w.rfc, v.n_ventas , w.nombres_completo, w.password from (select vendedor, count(id_venta) n_ventas from venta where fecha BETWEEN $1 AND $2 group by vendedor) v left join vendedor w on v.vendedor = w.rfc  order by v.n_ventas desc) g WHERE g.n_ventas = (	select max(f.n_ventas) from (select v.n_ventas from (select vendedor, count(id_venta) n_ventas from venta where fecha BETWEEN $1 AND $2 group by vendedor) v left join vendedor w on v.vendedor = w.rfc  order by v.n_ventas desc) f);
$$ LANGUAGE SQL;
--otro ejemplo recreativo
select mejores_vendedores('2015-11-29','2016-11-02');

CREATE OR REPLACE FUNCTION nombre_del_mejor_vendedor_de_la_historia() RETURNS SETOF text AS $$
SELECT nombres_completo FROM (select w.rfc, v.n_ventas , w.nombres_completo, w.password from (select vendedor, count(id_venta) n_ventas from venta where true group by vendedor) v left join vendedor w on v.vendedor = w.rfc  order by v.n_ventas desc) g WHERE g.n_ventas = (select max(f.n_ventas) from (select v.n_ventas from (select vendedor, count(id_venta) n_ventas from venta where true group by vendedor) v left join vendedor w on v.vendedor = w.rfc  order by v.n_ventas desc) f);
$$ LANGUAGE SQL;

select nombre_del_mejor_vendedor_de_la_historia();

CREATE OR REPLACE FUNCTION destinos_mas_visitados_mes(timestamp)  RETURNS SETOF text AS $$
select iata_destino from (select vv.iata_destino, count(v.id_venta) c from venta v left join vuelo vv on v.flight_number = vv.flight_number where extract(month from fecha_salida) = extract(month from $1) group by vv.iata_destino order by c desc) z
$$ LANGUAGE SQL;

--ejemplo
select destinos_mas_visitados_mes('2015-11-22');