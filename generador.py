import random, string

    # flight_number text REFERENCES vuelo(flight_number),
    # posicion text NOT NULL ,
    # categoria text NOT NULL,
    # costo real NOT NULL,
    # disponible boolean NOT NULL,

vuelos = ['FQO-507','FFF-233','ZKQ-976','SCU-059','MHR-706','RGW-342','JMF-771','JGR-024','DTX-397','VIF-656','RNH-652','GVA-315','VQP-530','YTB-764','BFJ-416','ADU-866','CPQ-289','QEF-127','WNA-896','ITK-366','OWV-638','IGO-971','CPX-132','XSR-828','FVJ-295','AZD-471','JLV-384','YFJ-976','KOP-625','IVE-843','KEU-508','LIS-198','OIE-801','WXH-449','KXA-783','FXU-469','JWG-742','FPM-472','UKI-612','WED-420','MAH-796','DHA-896','CJU-599','IFT-960','XNC-646','NCE-928','ZIU-945','GTV-418','SRK-811','PIC-090','NGQ-989','ISJ-355','XDV-379','XVA-074','HKR-662','OBH-980','WGA-877','GJU-159','VEU-041','ZYB-379','VFO-238','TJP-651','TKJ-332','ALH-461','ARC-791','BSC-668','QJE-573','UDB-165','DAV-822','QMN-939','EZU-406','DXK-089','NZX-229','BYU-498','JBC-044','HQF-824','ULP-061','CRH-716','RVF-778','MSN-852','UER-914','XFL-853','OMK-676','VCN-495','OYC-650','ILN-117','CIL-626','AZN-284','XLT-680','VHN-177','ZWD-130','VFD-452','MAT-303','LEP-108','XAJ-998','TWS-518','HJV-199','OFG-848','CHT-282','XVU-486']
nuestra = 'A B C D E F G H I J'.split(' ')
posiciones = [i + str(j) for i in random.sample(nuestra, 5) for j in range(1,9)]
categorias = ['ECO','PRE','BUS','FCL']

tabla = [[vuelos[j], random.choice(posiciones), random.choice(categorias), random.randrange(500,10000, 357), random.choice('10')] for i in range (0,2) for j in range(0,100)]

print "insert into asiento values "
for renglon in tabla:
	print "('" + str(renglon[0]) + "','" + str(renglon[1]) + "','" + str(renglon[2]) + "','" + str(renglon[3]) + "','" + str(renglon[4]) + "'),"
