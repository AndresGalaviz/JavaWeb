/*
MySQL Data Transfer
Source Host: localhost
Source Database: jeopardy
Target Host: localhost
Target Database: jeopardy
Date: 27/04/2015 10:18:23 a.m.
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
  `usuarioNuevo` bit(1) DEFAULT TRUE,
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

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
INSERT INTO `perfiles` VALUES ('1', 'admin', 'admin', 1, '3');
INSERT INTO `preguntas` VALUES ('1', 'Pregunta 1', 'Respuesta 1', '100', '1');
INSERT INTO `preguntas` VALUES ('2', 'Pregunta 2', 'Respuesta 2', '200', '1');
INSERT INTO `preguntas` VALUES ('4', 'Pregunta 3', 'Respuesta 3', '300', '1');
INSERT INTO `preguntas` VALUES ('5', 'Pregunta 4', 'Respuesta 4', '400', '1');
INSERT INTO `preguntas` VALUES ('6', 'Cuanto es el seno de 30°', '0.5', '100', '2');
INSERT INTO `preguntas` VALUES ('7', 'Pregunta 5', 'Respuesta 5', '500', '1');
INSERT INTO `preguntas` VALUES ('8', 'Pregunta linguistica', 'respuesta', '100', '12');
