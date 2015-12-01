-- revisa el numero de asientos de cada categoria que estan disponibles 
SELECT categoria, COUNT(*) FROM asiento where disponible = true AND flight_number IN (select flight_number from vuelo) group by  categoria;
-- vuelos disponibles de cierta ciudad a partir de cierta fecha
select * from asiento where disponible = true AND flight_number IN (SELECT flight_number from vuelo where iata_origen = 'DYM' and fecha_salida >= '2015-12-25');
-- insertar un nuevo usuario
insert into cliente (nombres_completo,genero, fecha_nacimiento, correo, telefono ) values ('Alendro Martinez Torrez','true','1994-09-14','aljandro@unam.mx','62-(290)635-6294');
-- nos da el top de vendedores que han vendido boletos por adelanado
select w.nombres_completo, w.telefono, v.n_ventas from (select vendedor, count(id_venta) n_ventas from venta where fecha >= current_timestamp group by vendedor) v left join vendedor w on v.vendedor = w.rfc  order by v.n_ventas desc;

--
SELECT w.iata_destino,COUNT(*) c FROM (SELECT flight_number FROM venta WHERE cliente = 110) v LEFT JOIN vuelo w ON v.flight_number=w.flight_number group by w.iata_destino ORDER BY c desc;

--destinos mas visitados
select vv.iata_destino, count(v.id_venta)c from venta v left join vuelo vv on v.flight_number = vv.flight_number group by vv.iata_destino order by c desc
