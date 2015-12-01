-- 1 
Select id_venta, nombres_completo FROM (SELECT * FROM venta v LEFT JOIN cliente w ON v.cliente=w.id_cliente) c WHERE extract(year from fecha) = 2015 and date_part('year', age(fecha_nacimiento)) >= 18;

-- 2
select nombres_completo from cliente where id_cliente not in (select id_cliente from cliente c right join venta v on c.id_cliente = v.cliente where extract(month from v.fecha) = 7)

-- 3
SELECT nombres_completo, id_venta FROM (SELECT * FROM venta v LEFT JOIN cliente c ON v.cliente=c.id_cliente )c WHERE c.nombres_completo LIKE 'G%' ;

-- 4
select costo,
case when costo > 500 then 'Autorizado'
     when costo <> 1300 then 'Verificado'
     when nombres_completo LIKe '%Carlos%' then 'Activo'
     when genero =  true then 'Checar'
     else 'En Proceso'
end
from  (
	Select * from (select * from venta v left join cliente u on v.cliente = u.id_cliente) z left join asiento aa on
	z.flight_number = aa.flight_number where extract(year from z.fecha) = 2015 
) c