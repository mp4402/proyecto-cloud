BEGIN;
CREATE TABLE IF NOT EXISTS user_data (
    id SERIAL NOT NULL PRIMARY KEY,
    correo VARCHAR(45),
    nombre_usuario VARCHAR(45),
    pais VARCHAR(45),
    path_foto VARCHAR(200)
);
CREATE TABLE IF NOT EXISTS evento_data (
    id SERIAL NOT NULL PRIMARY KEY,
    nombre VARCHAR(100),
    description VARCHAR(250),
    fecha VARCHAR(30),
    hora VARCHAR(10),
    precio SERIAL,
    path_foto_p VARCHAR(200)
);
CREATE TABLE IF NOT EXISTS categoria (
    id SERIAL NOT NULL PRIMARY KEY,
    nombre VARCHAR(100)
);
CREATE TABLE IF NOT EXISTS usuario_evento_creado (
    id SERIAL NOT NULL PRIMARY KEY,
    id_user INT NOT NULL,
    id_evento INT NOT NULL,
    CONSTRAINT fk_user FOREIGN KEY(id_user) REFERENCES user_data(id),
    CONSTRAINT fk_evento FOREIGN KEY(id_evento) REFERENCES evento_data(id) 
);
CREATE TABLE IF NOT EXISTS evento_categoria (
    id SERIAL NOT NULL PRIMARY KEY,
    id_evento INT NOT NULL,
    id_categoria INT NOT NULL,
    CONSTRAINT fk_user FOREIGN KEY(id_categoria) REFERENCES categoria(id),
    CONSTRAINT fk_evento FOREIGN KEY(id_evento) REFERENCES evento_data(id) 
);
CREATE TABLE IF NOT EXISTS evento_comentario (
    id SERIAL NOT NULL PRIMARY KEY,
    id_user INT NOT NULL,
    id_evento INT NOT NULL,
    comentario TEXT NOT NULL,
    CONSTRAINT fk_user FOREIGN KEY(id_user) REFERENCES user_data(id),
    CONSTRAINT fk_evento FOREIGN KEY(id_evento) REFERENCES evento_data(id) 
);
CREATE TABLE IF NOT EXISTS evento_fotos (
    id SERIAL NOT NULL PRIMARY KEY,
    id_evento INT NOT NULL,
    path_foto TEXT NOT NULL,
    CONSTRAINT fk_evento FOREIGN KEY(id_evento) REFERENCES evento_data(id) 
);
CREATE TABLE IF NOT EXISTS usuario_evento_registrado (
    id SERIAL NOT NULL PRIMARY KEY,
    id_user INT NOT NULL,
    id_evento INT NOT NULL,
    CONSTRAINT fk_user FOREIGN KEY(id_user) REFERENCES user_data(id),
    CONSTRAINT fk_evento FOREIGN KEY(id_evento) REFERENCES evento_data(id) 
);