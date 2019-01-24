create table USUARIOS(
  id_u number(20) CONSTRAINT USUARIOS_PK PRIMARY KEY,
  usuario varchar2(30) CONSTRAINT USUARIOS_UK1 UNIQUE
                        CONSTRAINT USUARIOS_NN1 NOT NULL ,
  e_mail varchar2(60)  CONSTRAINT USUARIOS_UK2 UNIQUE
                        CONSTRAINT USUARIOS_NN2 NOT NULL ,
  nombre varchar2(30)  CONSTRAINT USUARIOS_NN3 NOT NULL ,
  apellido1 varchar2(30) CONSTRAINT USUARIOS_NN4 NOT NULL ,
  apellido2 varchar2(30),
  passw varchar2(100) CONSTRAINT USUARIOS_NN5 NOT NULL
);
create table CONTACTOS(
  id_u number(20) CONSTRAINT CONTACTOS_FK1 REFERENCES USUARIOS,
  contacto number(20) CONSTRAINT CONTACTOS_FK2 REFERENCES USUARIOS(id_u),
   CONSTRAINT CONTACTOS_PK PRIMARY KEY(id_u,contacto)
  );

create table SER_VISIBLE (
  id_u number(20),
  contacto number(20),
  pid number(20),
  CONSTRAINT SER_VISIBLE_PK PRIMARY KEY(id_u,contacto,pid),
  CONSTRAINT SER_VISIBLE_FK1 FOREIGN KEY (id_u,contacto) REFERENCES CONTACTOS(id_u, contacto)
);
create table POST(
  id_u number(20) CONSTRAINT POST_FK1 REFERENCES USUARIOS
                 CONSTRAINT POST_NN2 NOT NULL ,
  pid number(20) CONSTRAINT POST_PK PRIMARY KEY ,
  texto varchar2(1000) CONSTRAINT POST_NN1 NOT NULL ,
  pid_rel number(20) CONSTRAINT POST_FK2 REFERENCES POST(pid),
  publicacion date CONSTRAINT POST_NN3 NOT NULL
                 CONSTRAINT POST_CK1 CHECK ( publicacion>TO_DATE('08/02/2017','dd/mm/yyyy')),
  duracion INTERVAL DAY TO SECOND CONSTRAINT POST_NN4 NOT NULL

);

ALTER TABLE SER_VISIBLE
  ADD CONSTRAINT SER_VISIBLE_FK2 FOREIGN KEY(pid) REFERENCES POST

ALTER TABLE CONTACTOS
  ADD CONSTRAINT CONTACTOS_CK1 CHECK (id_u!=contacto);

ALTER TABLE POST
  ADD CONSTRAINT POST_CK2 CHECK ( duracion<INTERVAL '30'MINUTE);

ALTER TABLE SER_VISIBLE
  RENAME TO COMPARTIR;

ALTER TABLE USUARIOS
  RENAME CONSTRAINT USUARIOS_PK TO SUPERCLAVE;

ALTER TABLE POST
  MODIFY (PUBLICACION DEFAULT SYSDATE);
ALTER TABLE USUARIOS
  MODIFY (PASSW DEFAULT 12345);

INSERT INTO USUARIOS(id_u,nombre,apellido1,apellido2,usuario,e_mail)
  VALUES (1,'Ramón','García','Ortigal','ramongar','ramon@hotmail.com');

INSERT INTO USUARIOS(id_u,nombre,apellido1,usuario,e_mail)
  VALUES (2,'Lourde','Atienza','lurdita','lurdita@bbc.co.uk');

  INSERT INTO USUARIOS(id_u,nombre,apellido1,apellido2,usuario,e_mail)
  VALUES (3,'Marisol','Jiménez','del Oso','marioso','marioso19@yahoo.com');

  INSERT INTO USUARIOS(id_u,nombre,apellido1,apellido2,usuario,e_mail)
  VALUES (4,'Francisco','Serrano','Calvo','sercal','sercal1980@gmail.com');
 commit;




