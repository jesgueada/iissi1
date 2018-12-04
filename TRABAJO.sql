--Borramos las tablas
DROP TABLE FOTOVEHICULOS;
DROP TABLE DESCUENTOS;
DROP TABLE PROPIEDADESVEHICULOS;
DROP TABLE PROPIEDADES;
DROP TABLE TIPOPROPIEDADES;
DROP TABLE VEHICULOS;
DROP TABLE FINANCIACIONES;
DROP TABLE TIPOVEHICULOS;




--Borramos las secuencias
drop sequence seq_fotosVehiculos;
drop sequence seq_propiedades;
drop sequence seq_tipopropiedades;
drop sequence seq_vehiculo;
drop sequence seq_financiacion;
drop sequence seq_descuento;
drop sequence seq_tipovehiculos;

--Creamos las secuencias
create sequence seq_fotosVehiculos;
create sequence seq_tipovehiculos;
create sequence seq_financiacion;
create sequence seq_vehiculo;
create sequence seq_tipopropiedades;
create sequence seq_propiedades;
create sequence seq_descuento;



--Creaci�n de tabla Financiacion
CREATE TABLE TIPOVEHICULOS(
    id_tveh number(10) primary key,
    nombre varchar2(40) not null,
    unique (nombre)
);


--Creaci�n de tabla Financiacion
CREATE TABLE FINANCIACIONES(
    id_fin number(10) primary key,
    nombre varchar2(40) not null,
    unique (nombre)
);

--Creaci�n de tabla Tipo Propiedades
CREATE TABLE TIPOPROPIEDADES(
    id_tpro number(10) primary key,
    nombre varchar2(40) not null,
    unique (nombre)
);

--Creaci�n de tabla Veh�culo
CREATE TABLE VEHICULOS(
    id_veh number(10) primary key,
    matricula varchar2(7) not null,
    fechaAlta date not null,
    nombre varchar(80) not null,
    descripcion varchar(400) not null,
    precio number(10,2) not null,
    disponible number(1) not null,
    UNIQUE (matricula)
);

--Creaci�n de tabla Propiedades
CREATE TABLE PROPIEDADES(
    id_pro number(10) primary key,
    id_tpro number(10),
    nombre varchar2(40) not null ,
    unique(nombre),
    foreign key (id_tpro) REFERENCES TIPOPROPIEDADES
);

--Creaci�n de tabla relaci�n propiedades y veh�culo
CREATE TABLE PROPIEDADESVEHICULOS(
    id_tpro number(10),
    id_pro number(10),
    id_veh number(10),
    PRIMARY KEY (id_tpro,id_pro,id_veh),
    foreign key (id_veh) REFERENCES TIPOPROPIEDADES,
    foreign key (id_pro) REFERENCES PROPIEDADES,
    foreign key (id_veh) REFERENCES VEHICULOS
);

--Creaci�n de tabla Descuento
CREATE TABLE DESCUENTOS(
    id_des number(10) primary key,
    id_fin number(10),
    nombre varchar2(40) not null ,
    unique(nombre),
    foreign key (id_fin) REFERENCES FINANCIACIONES
);

--Creaci�n de tabla Foto Veh�culo
CREATE TABLE FOTOVEHICULOS(
    id_ft number(12) primary key,
    id_veh number(10),
    posicion number(12),
    unique(id_veh,posicion),
    foreign key(id_veh) references vehiculos
);



    
    --Creaci�n de Trigger Financiaci�n (secuencia)
    create or replace trigger Sec_FI_
    before insert on FINANCIACIONES
    for each row
    begin
        :new.id_fin := seq_financiacion.nextval;    
    end;
    /
    
    --Creaci�n de Trigger Tipo Propiedades (secuencia)
    create or replace trigger Sec_TP_
    before insert on TIPOPROPIEDADES
    for each row
    begin
        :new.id_tpro := seq_tipopropiedades.nextval;    
    end;
    /
    
    --Creaci�n de Trigger Propiedades (secuencia)
    create or replace trigger Sec_P_
    before insert on PROPIEDADES
    for each row
    begin
        :new.id_pro := seq_propiedades.nextval;
    end;
    / 
    
    --Creaci�n de Trigger Veh�culo (secuencia)
    create or replace trigger Sec_V_
    before insert on VEHICULOS
    for each row
    begin
        :new.id_veh := seq_vehiculo.nextval;   
    end;
    / 
    
    
        --Creaci�n de Trigger Veh�culo (secuencia)
    create or replace trigger Sec_FV_
    before insert on FOTOVEHICULOS
    for each row
    begin
        :new.id_ft := seq_fotosVehiculos.nextval;   
    end;
    / 
    
    
    --Creaci�n de Trigger Descuento(secuencia)
    create or replace trigger Sec_DE_
    before insert on DESCUENTOS
    for each row
    begin
        :new.id_des := seq_descuento.nextval;    
    end;
    /
    

--PROCEDURES

--PROCEDURES INSERTAR, ACTUALIZAR Y BORRAR 
create or replace procedure insertar_tipo_propiedades (t_pro in tipopropiedades.nombre%type)is
begin insert into tipopropiedades(nombre) values (t_pro);
commit work;
end insertar_tipo_propiedades;
/

create or replace procedure actualizar_tipo_propiedades 
(idt_pro in tipopropiedades.id_tpro%type,t_pro_act in tipopropiedades.nombre%type )is
begin update TIPOPROPIEDADES set nombre = t_pro_act where id_tpro = idt_pro;
commit work;
end actualizar_tipo_propiedades;
/




    execute insertar_tipo_propiedades('Puertas');
    execute insertar_tipo_propiedades('Color');
    execute insertar_tipo_propiedades('Combustible');
    execute insertar_tipo_propiedades('Etiqueta Eficiencia');
    execute actualizar_tipo_propiedades(1,'N� Puertas');
    insert into vehiculoS(matricula,fechaAlta,nombre,descripcion,precio,disponible) values ('0178ZQJ',TO_DATE(SYSDATE),'COCHE C3 BLANCO SEGUNDA MANO','ESTO ES UNA PRUEBA',8500,1);
    insert into vehiculoS(matricula,fechaAlta,nombre,descripcion,precio,disponible) values ('0179ZQJ',TO_DATE(SYSDATE),'COCHE C3 NEGRO SEGUNDA MANO','ESTO ES UNA PRUEBA',8000,1);
    insert into vehiculoS(matricula,fechaAlta,nombre,descripcion,precio,disponible) values ('0171ZQJ',TO_DATE(SYSDATE),'COCHE C4 NEGRO SEGUNDA MANO','ESTO ES UNA PRUEBA',7400,1);
    insert into vehiculoS(matricula,fechaAlta,nombre,descripcion,precio,disponible) values ('0172ZQJ',TO_DATE(SYSDATE),'COCHE C4 BLANCO SEGUNDA MANO','ESTO ES UNA PRUEBA',9400,1);
    insert into vehiculoS(matricula,fechaAlta,nombre,descripcion,precio,disponible) values ('0173ZQJ',TO_DATE(SYSDATE),'COCHE C5 NEGRO SEGUNDA MANO','ESTO ES UNA PRUEBA',9800,1);
    insert into vehiculoS(matricula,fechaAlta,nombre,descripcion,precio,disponible) values ('0174ZQJ',TO_DATE(SYSDATE),'COCHE C5 BLANCO SEGUNDA MANO','ESTO ES UNA PRUEBA',12000,1);
    insert into propiedades(id_tpro,nombre) values (2,'Negro');
    insert into propiedades(id_tpro,nombre) values (2,'Blanco');
    insert into propiedades(id_tpro,nombre) values (1,'3 Puertas');
    insert into propiedades(id_tpro,nombre) values (1,'4 Puertas');
    insert into propiedades(id_tpro,nombre) values (1,'5 Puertas');
    insert into propiedades(id_tpro,nombre) values (3,'Gasolina');
    insert into propiedades(id_tpro,nombre) values (3,'Diesel');
    insert into propiedades(id_tpro,nombre) values (3,'H�brido');
    insert into propiedades(id_tpro,nombre) values (3,'El�ctrico');
    insert into propiedades(id_tpro,nombre) values (4,'0 Emisiones');
    insert into propiedades(id_tpro,nombre) values (4,'Eco');
    insert into propiedades(id_tpro,nombre) values (4,'C');
    insert into propiedades(id_tpro,nombre) values (4,'B');
    insert into propiedadesvehiculos(id_tpro,id_pro,id_veh) values (2,2,1);
    insert into propiedadesvehiculos(id_tpro,id_pro,id_veh) values (1,3,1);
    insert into propiedadesvehiculos(id_tpro,id_pro,id_veh) values (3,6,1);
    insert into propiedadesvehiculos(id_tpro,id_pro,id_veh) values (4,12,1);
    insert into propiedadesvehiculos(id_tpro,id_pro,id_veh) values (2,1,2);
    insert into propiedadesvehiculos(id_tpro,id_pro,id_veh) values (1,3,2);
    insert into propiedadesvehiculos(id_tpro,id_pro,id_veh) values (3,9,2);
    insert into propiedadesvehiculos(id_tpro,id_pro,id_veh) values (4,10,2);
    insert into propiedadesvehiculos(id_tpro,id_pro,id_veh) values (2,1,3);
    insert into propiedadesvehiculos(id_tpro,id_pro,id_veh) values (1,4,3);
    insert into propiedadesvehiculos(id_tpro,id_pro,id_veh) values (3,6,3);
    insert into propiedadesvehiculos(id_tpro,id_pro,id_veh) values (2,2,4);
    insert into propiedadesvehiculos(id_tpro,id_pro,id_veh) values (1,4,4);
    insert into propiedadesvehiculos(id_tpro,id_pro,id_veh) values (3,6,4);
    
    
    
    
    SELECT tp.nombre, p.nombre 
FROM propiedadesvehiculos PT, tipopropiedades TP, propiedades P 
WHERE pt.id_pro=p.id_pro AND pt.id_tpro=tp.id_tpro and pt.id_veh=1;

SELECT tp.nombre, p.nombre 
FROM propiedadesvehiculos PT, tipopropiedades TP, propiedades P 
WHERE pt.id_pro=p.id_pro AND pt.id_tpro=tp.id_tpro and pt.id_veh=2;

SELECT tp.nombre, p.nombre 
FROM propiedadesvehiculos PT, tipopropiedades TP, propiedades P 
WHERE pt.id_pro=p.id_pro AND pt.id_tpro=tp.id_tpro and pt.id_veh=3;

SELECT tp.nombre, p.nombre 
FROM propiedadesvehiculos PT, tipopropiedades TP, propiedades P 
WHERE pt.id_pro=p.id_pro AND pt.id_tpro=tp.id_tpro and pt.id_veh=4;

