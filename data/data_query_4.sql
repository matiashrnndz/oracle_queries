ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';
DROP TABLE FACTURA;
DROP TABLE ALMACENA;
DROP TABLE ESTANTE;
DROP TABLE GALPON;
DROP TABLE PRODUCTO;
DROP TABLE CLIENTE;

CREATE TABLE CLIENTE( 
RUT NUMBER(5) NOT NULL CONSTRAINT CLIENTE_pk PRIMARY KEY, 
RAZONSOCIAL VARCHAR2(120) CONSTRAINT CLIENTE_Ak UNIQUE NOT NULL, 
TELEFONO NUMBER(30) NOT NULL, 
DIRECCION VARCHAR2(80) NOT NULL, 
FCHING DATE NOT NULL);

CREATE TABLE PRODUCTO( 
CODPROD NUMBER(5) NOT NULL CONSTRAINT PRODUCTO_pk PRIMARY KEY, 
DESCRIPCION VARCHAR2(100) NOT NULL, 
RUT NUMBER(5) NOT NULL CONSTRAINT PRODUCTO_TO_CLIENTE_FK REFERENCES CLIENTE, 
FDESDE DATE NOT NULL,
FHASTA DATE,
PRECIO NUMBER(5) NOT NULL,
TIPO VARCHAR2(100) NOT NULL);

CREATE TABLE GALPON( 
NOMBRE VARCHAR2(100) NOT NULL CONSTRAINT GALPON_pk PRIMARY KEY,
SUPERFICIE NUMBER(10) NOT NULL);

CREATE TABLE ESTANTE( 
NOMBRE VARCHAR2(100) NOT NULL CONSTRAINT ESTANTE_TO_GALPON_FK REFERENCES GALPON,
FILA NUMBER(5) NOT NULL,
NUMESTANTE NUMBER(5) NOT NULL,
CONSTRAINT ESTANTE_Pk PRIMARY KEY(NOMBRE, FILA, NUMESTANTE));

CREATE TABLE ALMACENA( 
NOMBRE VARCHAR2(100) NOT NULL,
FILA NUMBER(5) NOT NULL,
NUMESTANTE NUMBER(5) NOT NULL,
CODPROD NUMBER(5) NOT NULL CONSTRAINT ALMACENA_TO_PRODUCTO_FK REFERENCES PRODUCTO, 
CONSTRAINT ALMACENA_Pk PRIMARY KEY(NOMBRE, FILA, NUMESTANTE, CODPROD),
CONSTRAINT ALM_TO_EST_FK FOREIGN KEY(NOMBRE, FILA, NUMESTANTE) REFERENCES ESTANTE (NOMBRE, FILA, NUMESTANTE));

CREATE TABLE FACTURA( 
NUMFAC NUMBER(5) NOT NULL CONSTRAINT FACTURA_pk PRIMARY KEY, 
CODPROD NUMBER(5) NOT NULL CONSTRAINT FACTURA_TO_PRODUCTO_FK REFERENCES PRODUCTO,
FECHA DATE NOT NULL,
IMPORTE NUMBER(10) NOT NULL,
FCHVENCIMIENTO DATE NOT NULL);

INSERT INTO CLIENTE VALUES ('40001','GALLETITAS S.A','2324112','CUAREIM 7982',to_date('19/06/2016','DD/MM/YYYY'));
INSERT INTO CLIENTE VALUES ('40002','SERVICIOLIMPIEZA','2324141','MERCEDES 9827',to_date('24/04/2016','DD/MM/YYYY'));
INSERT INTO CLIENTE VALUES ('40003','MI MAGICO BAZAR','2324242','COLONIA 2019',to_date('19/06/2016','DD/MM/YYYY'));
INSERT INTO CLIENTE VALUES ('40004','LOS PERFUMES S.A','2313415','YAGUARON 2015',to_date('19/06/2016','DD/MM/YYYY'));

INSERT INTO PRODUCTO VALUES  ('1','BALDE','40001',to_date('10/07/2016','DD/MM/YYYY'),to_date('26/12/2016','DD/MM/YYYY'),'200','Limpieza');
INSERT INTO PRODUCTO VALUES  ('2','DETERGENTE','40001',to_date('18/07/2016','DD/MM/YYYY'),to_date('26/12/2016','DD/MM/YYYY'),'150','LIMPIEZA');
INSERT INTO PRODUCTO VALUES  ('3','ESCOBA','40002',to_date('20/08/2016','DD/MM/YYYY'),to_date('18/11/2016','DD/MM/YYYY'),'500','Limpieza');
INSERT INTO PRODUCTO VALUES ('4','PALA','40003',to_date('10/12/2016','DD/MM/YYYY'),to_date('18/11/2016','DD/MM/YYYY'),'200','LIMPIEZA');
INSERT INTO PRODUCTO VALUES  ('5','COCINA','40004',to_date('20/07/2016','DD/MM/YYYY'),to_date('18/12/2016','DD/MM/YYYY'),'12000','ELECTRODOMÉSTICO');


COMMIT; 