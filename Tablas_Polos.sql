#DROP DATABASE polos_shop;
#CREATE DATABASE polos_shop;
#USE polos_shop;

CREATE TABLE carrito(
	id INT PRIMARY KEY AUTO_INCREMENT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE usuarios (
  id int(11) NOT NULL primary KEY auto_increment,
  usuario varchar(20) NOT NULL,
  nombre varchar(100) NOT NULL,
  clave varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `usuarios` (`id`, `usuario`, `nombre`, `clave`) VALUES
(1, 'admin', 'ALEJANDRO VILLA', '21232f297a57a5a743894a0e4a801fc3');

CREATE TABLE usuario (
	id INT(11) PRIMARY KEY NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(255) NOT NULL DEFAULT 'nombre',
	apellido VARCHAR(255) NOT NULL DEFAULT 'apellido',
	email VARCHAR(255) NOT NULL DEFAULT 'email',
	password VARCHAR(255) NOT NULL DEFAULT 'password',
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_carrito INT NOT NULL ,
    FOREIGN KEY (id_carrito) REFERENCES carrito(id)
);

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL primary key auto_increment,
  `categoria` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `productos` (
  `id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text NOT NULL,
  `precio_normal` decimal(10,2) NOT NULL,
  `precio_rebajado` decimal(10,2) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `imagen` varchar(50) NOT NULL,
  `id_categoria` int(11) NOT NULL,
   FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE product_review(
	id INT PRIMARY KEY AUTO_INCREMENT,
	id_prod INT NOT NULL,
	titulo VARCHAR(45),
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(id_prod) REFERENCES productos(id) ON DELETE CASCADE ON UPDATE CASCADE 
);

CREATE TABLE orden(
	id INT PRIMARY KEY AUTO_INCREMENT,
    fecha_act TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_user INT NOT NULL,
    impuesto FLOAT8,
	   pais VARCHAR(45),
	   estado ENUM("EN PROCESO","FINALIZADA"),
    sub_total FLOAT8,
    total FLOAT8,
    FOREIGN KEY(id_user) REFERENCES usuario(id) ON DELETE CASCADE ON UPDATE CASCADE 
);

CREATE TABLE carrito_item(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_Prod INT NOT NULL,
    id_Carrito INT NOT NULL,
    precio FLOAT8,
    cantidad INT DEFAULT 1,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(id_Prod) REFERENCES productos(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(id_Carrito) REFERENCES carrito(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Producto_orden(
	id INT PRIMARY KEY AUTO_INCREMENT,
    id_Prod INT NOT NULL,
	id_Orden INT NOT NULL,
    precio FLOAT8,
	cantidad INT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(id_Prod) REFERENCES productos(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(id_Orden) REFERENCES orden(id) ON DELETE CASCADE ON UPDATE CASCADE
);
