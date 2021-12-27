use polos_shop;
/*Nuevo Producto*/
DELIMITER //
DROP PROCEDURE IF EXISTS nuevoProd//
CREATE PROCEDURE nuevoProd(IN nombre VARCHAR(255), IN descr TEXT, IN precio_normal decimal(10,2),IN precio_rebajado decimal(10,2), IN cantidad INT, IN imagen VARCHAR(50), IN id_Cat INT)
BEGIN
    IF (SELECT count(*) from productos WHERE productos.nombre = nombre ) < 1 then 
			INSERT INTO productos
			(nombre, descripcion, precio_normal, precio_rebajado, cantidad, imagen, id_categoria) 
			VALUES 
            (nombre, descr, precio_normal, precio_rebajado, cantidad, imagen, id_Cat);
	END IF;
END
//
DELIMITER ; 

/*Nueva Categoria*/
DELIMITER //
DROP PROCEDURE IF EXISTS nuevaCateg//
CREATE PROCEDURE nuevaCateg(IN categoria VARCHAR(50))
BEGIN
    IF (SELECT count(*) from categorias WHERE categorias.categoria = categoria ) < 1 then 
			INSERT INTO 
            categorias(categoria)
			VALUES 
            (categoria);
	END IF;
END
//
DELIMITER ; 

/*Alteracion de Stock*/
DELIMITER //
DROP PROCEDURE IF EXISTS altStock//
CREATE PROCEDURE altStock(IN titulo TEXT,IN adi BOOLEAN, IN cant INT)
BEGIN
    IF (SELECT count(*) from polo WHERE polo.titulo = titulo ) >= 1 AND adi = TRUE then 
			UPDATE polo
            SET
            polo.stock = polo.stock + cant
			WHERE
            polo.titulo = titulo;
	END IF;
    IF (SELECT count(*) from polo WHERE polo.titulo = titulo ) >= 1 AND adi = FALSE then 
			UPDATE polo
            SET
            polo.stock = polo.stock - cant
			WHERE
            polo.titulo = titulo;
	END IF;
END
//
DELIMITER ; 

/*Creacion de Usuario*/
DELIMITER //
DROP PROCEDURE IF EXISTS nUser//
CREATE PROCEDURE nUser(IN nombre VARCHAR(45), IN apellido VARCHAR(45), IN email VARCHAR(100), IN password VARCHAR(100), IN created_at DATETIME, IN updated_at DATETIME , IN id_Carrito INT)
BEGIN
    IF (SELECT count(*) from usuario WHERE usuario.nombre = nombre ) < 1 AND (SELECT count(*) from carrito WHERE carrito.id = id_Carrito ) >= 1 then 
        INSERT INTO usuario
        (nombre, apellido, email, password, created_at, updated_at, id_carrito)
        VALUES
        (nombre, apellido, email, password, created_at, updated_at, id_carrito);
	END IF;
END
//
DELIMITER ; 

INSERT INTO carrito () values();
INSERT INTO carrito () values();

/*Actualizacion de Usuario*/
DELIMITER //
DROP PROCEDURE IF EXISTS actUser//
CREATE PROCEDURE actUser(IN id INT, IN nombreN VARCHAR(45), IN p_apellido VARCHAR(45), IN email VARCHAR(100), IN password VARCHAR(100), IN id_Carrito INT)
BEGIN
	IF (SELECT count(*) from usuario WHERE usuario.id = id ) >= 1 AND (SELECT count(*) from carrito WHERE carrito.id = id_Carrito ) >= 1 THEN 
        UPDATE usuario
        SET
        usuario.nombre = nombreN,
        usuario.p_apellido = p_apellido,
        usuario.email = email,
        usuario.password = password,
        usuario.id_carrito = id_Carrito
        WHERE usuario.id = id;
	END IF;
END
//
DELIMITER ; 

/*Creacion Orden*/
DELIMITER //
DROP PROCEDURE IF EXISTS nOrden//
CREATE PROCEDURE nOrden(IN id_User INT, IN impuesto FLOAT, IN pais VARCHAR(45), IN estado ENUM("EN PROCESO","FINALIZADA"), IN sub_total FLOAT, IN total FLOAT)
BEGIN
		IF(SELECT count(*) from usuario WHERE usuario.id = id_User) >= 1 THEN
			INSERT INTO orden
			(id_user, impuesto, pais, estado, sub_total, total)
			VALUES
			(id_User, impuesto, pais, estado, sub_total, total);
        END IF;
END
//
DELIMITER ; 

/*Aceptar Orden*/
DELIMITER //
DROP PROCEDURE IF EXISTS accOrden//
CREATE PROCEDURE accOrden(IN id INT , IN estado ENUM('EN PROCESO','FINALIZADA'))
BEGIN
	IF(SELECT count(*) from orden WHERE orden.id = id) >= 1 THEN
		UPDATE orden
		SET  
			orden.estado = estado
		WHERE 
			orden.id = id;
	END IF;
END
//
DELIMITER ; 

/*Polos_Orden*/
DELIMITER //
DROP PROCEDURE IF EXISTS polo_Ord//
CREATE PROCEDURE polo_Ord(IN id_Polo INT, IN id_Orden INT, IN precio FLOAT, IN cant INT)
BEGIN
        IF(SELECT count(*) from orden WHERE orden.id = id_Orden) >= 1 AND (SELECT count(*) from polo WHERE polo.id = id_Polo) >= 1 THEN
                INSERT INTO polo_orden
                (id_Prod, id_Orden, precio, cantidad)
                VALUES
                (id_Polo, id_Orden, precio, cant);
        END IF;
END
//
DELIMITER ; 

/*Polos_Carrito*/
DELIMITER //
DROP PROCEDURE IF EXISTS polo_Carr//
CREATE PROCEDURE polo_Carr(IN id_Polo INT, IN id_Carr INT, IN precio FLOAT, IN cant INT)
BEGIN
        IF(SELECT count(*) from carrito WHERE carrito.id = id_Carr) >= 1 AND (SELECT count(*) from polo WHERE polo.id = id_Polo) >= 1 THEN
                INSERT INTO carrito_item
                (id_Prod, id_Carrito, precio, cantidad)
                VALUES
                (id_Polo, id_Carr, precio, cant);
        END IF;
END
//
DELIMITER ; 

