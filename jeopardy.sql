/*
MySQL Data Transfer
Source Host: localhost
Source Database: jeopardy
Target Host: localhost
Target Database: jeopardy
Date: 27/04/2015 11:35:08 p.m.
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for categorias
-- ----------------------------
DROP TABLE IF EXISTS `categorias`;
CREATE TABLE `categorias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) DEFAULT NULL,
  `idMateria` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for juegos
-- ----------------------------
DROP TABLE IF EXISTS `juegos`;
CREATE TABLE `juegos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fechaInicio` datetime DEFAULT NULL,
  `fechaFinal` datetime DEFAULT NULL,
  `idCategoria1` int(11) DEFAULT NULL,
  `idCategoria2` int(11) DEFAULT NULL,
  `idCategoria3` int(11) DEFAULT NULL,
  `idCategoria4` int(11) DEFAULT NULL,
  `idCategoria5` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for materias
-- ----------------------------
DROP TABLE IF EXISTS `materias`;
CREATE TABLE `materias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) DEFAULT NULL,
  `idPerfil` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for perfiles
-- ----------------------------
DROP TABLE IF EXISTS `perfiles`;
CREATE TABLE `perfiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `usuarioNuevo` bit(1) DEFAULT b'1',
  `cuentaBloqueo` int(11) DEFAULT '3',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for preguntas
-- ----------------------------
DROP TABLE IF EXISTS `preguntas`;
CREATE TABLE `preguntas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pregunta` varchar(100) DEFAULT NULL,
  `respuesta` varchar(100) DEFAULT NULL,
  `puntos` int(11) DEFAULT NULL,
  `idCategoria` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for resultados
-- ----------------------------
DROP TABLE IF EXISTS `resultados`;
CREATE TABLE `resultados` (
  `id` int(11) NOT NULL,
  `nombre` varchar(20) DEFAULT NULL,
  `puntos` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `categorias` VALUES ('1', 'Algebra', '2');
INSERT INTO `categorias` VALUES ('2', 'Trigonometria', '2');
INSERT INTO `categorias` VALUES ('5', 'Geometria', '2');
INSERT INTO `categorias` VALUES ('6', 'Gramatica', '4');
INSERT INTO `categorias` VALUES ('7', 'Biologia', '5');
INSERT INTO `categorias` VALUES ('9', 'Combinatoria', '2');
INSERT INTO `categorias` VALUES ('10', 'Calculo', '2');
INSERT INTO `categorias` VALUES ('11', 'Quimica', '5');
INSERT INTO `categorias` VALUES ('12', 'Linguistica', '4');
INSERT INTO `materias` VALUES ('2', 'Matematicas', '1');
INSERT INTO `materias` VALUES ('4', 'Español', '1');
INSERT INTO `materias` VALUES ('5', 'Ciencias', '1');
INSERT INTO `materias` VALUES ('11', 'Programacion', '1');
INSERT INTO `perfiles` VALUES ('1', 'admin', 'admin', '', '3');
INSERT INTO `preguntas` VALUES ('8', 'Pregunta linguistica', 'respuesta', '100', '12');
INSERT INTO `preguntas` VALUES ('9', '¿Cuántos puntos tiene una recta? ', 'Infinito', '100', '5');
INSERT INTO `preguntas` VALUES ('10', '¿Qué angulo determinan las bisectrices de dos ángulos opuestos por el vértice?  ', ' ángulo llano (180º) ', '200', '5');
INSERT INTO `preguntas` VALUES ('11', '¿Cómo son los ángulos adyacentes de dos ángulos opuestos por el vértice?', 'Iguales', '300', '5');
INSERT INTO `preguntas` VALUES ('12', '¿Cómo se denominan los prismas cuyas aristas laterales son perpendiculares a las bases?', 'Rectos', '400', '5');
INSERT INTO `preguntas` VALUES ('13', '¿Cómo se denominan los prismas cuyas aristas laterales no son perpendiculares a las bases?', 'Oblicuos', '500', '5');
INSERT INTO `preguntas` VALUES ('14', 'Si lanzas una moneda que no está cargada al aire 55 veces, ¿cuál es la probabilidad de que obtengas ', '365 a la 10', '100', '9');
INSERT INTO `preguntas` VALUES ('15', '¿Cuántos números de 4 dígitos se pueden formar con las cifras 1,2,. . . , 9?', '6561', '200', '9');
INSERT INTO `preguntas` VALUES ('16', '¿De cuántas maneras pueden sentarse 10 personas en un banco si hay 4 sitios disponibles?', '5040', '300', '9');
INSERT INTO `preguntas` VALUES ('17', 'Si lanzas una moneda que no está cargada al aire 55 veces, ¿cuál es la probabilidad de que obtengas ', '5/16', '400', '9');
INSERT INTO `preguntas` VALUES ('18', 'Un alumno tiene que elegir 7 de las 10 preguntas de un examen. ¿De cuantas maneras puede elegirlas?', '120 a la 10', '500', '9');
INSERT INTO `preguntas` VALUES ('19', 'In a right triangle ABC with angle A equal to 90o, find angle B and C so that sin(B) = cos(B).', '45', '100', '2');
INSERT INTO `preguntas` VALUES ('20', 'In a right triangle ABC, tan(A) = 3/4. Find sin(A) and cos(A).', '4/5', '200', '2');
INSERT INTO `preguntas` VALUES ('21', 'The area of a right triangle is 50. One of its angles is 45o. Find the lengths of the sides and hypo', '10 sqrt(2)', '300', '2');
INSERT INTO `preguntas` VALUES ('22', 'A rectangle has dimensions 10 cm by 5 cm. Determine the measures of the angles at the point where th', '53', '400', '2');
INSERT INTO `preguntas` VALUES ('23', 'Pregunta 5', 'Respuesta 5', '500', '2');
INSERT INTO `preguntas` VALUES ('24', 'Cuanto es el seno de 30°', '0.5', '100', '1');
INSERT INTO `preguntas` VALUES ('25', 'Cuanto es el coseno de 60°', '0.5', '400', '1');
INSERT INTO `preguntas` VALUES ('26', 'Cual es el valor de c que completa el cuadrado  p^2 ? 14 p + c', '49', '300', '1');
INSERT INTO `preguntas` VALUES ('27', 'Cual es el valor de c que completa el cuadrado  n^2 + 28n + c', '196', '200', '1');
INSERT INTO `preguntas` VALUES ('28', '2 m³ of soil containing 35% sand was mixed into 6 m³ of soil containing 15% sand. What is the sand c', '20%', '400', '1');
INSERT INTO `preguntas` VALUES ('29', '¿Cómo se llama la glandua mas grande del cuerpo humano?', 'Higado', '100', '7');
INSERT INTO `preguntas` VALUES ('30', '¿Qué nombre recibe la estructura biologica que une al musculo y al hueso?', 'Tendones', '200', '7');
INSERT INTO `preguntas` VALUES ('31', ' ¿En que parte del cerebro se realizan las emosiones?', 'HEMISFERIO DERECHO ', '300', '7');
INSERT INTO `preguntas` VALUES ('32', '¿Qué le da el color rojo a la sangre?', 'Emoglobina', '400', '7');
INSERT INTO `preguntas` VALUES ('33', '¿Qué funcion cumple el globulo blanco?', 'Eliminar los virus de las celulas', '500', '7');
INSERT INTO `preguntas` VALUES ('34', 'Derivada de sin(x)', 'cos(x)', '100', '10');
INSERT INTO `preguntas` VALUES ('35', 'Derivada de cos(x)', '-sin(x)', '200', '10');
INSERT INTO `preguntas` VALUES ('36', 'Como se expresa una derivada?', 'df(x)/dx', '300', '10');
INSERT INTO `preguntas` VALUES ('37', 'Derivada de e^x', 'e^x', '400', '10');
INSERT INTO `preguntas` VALUES ('38', 'Integral de x^2', 'x^3/3   C', '500', '10');
