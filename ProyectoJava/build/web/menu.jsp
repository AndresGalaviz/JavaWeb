<%-- 
    Document   : menu
    Created on : 24/04/2015, 09:50:16 PM
    Author     : Alberto
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu</title>
    </head>
    <body>
    <center>
        <h1>Menú</h1>
        <p>Bienvenido, <%= (String)session.getAttribute("usuario") %>!</p>
        <a href="Controlador?action=materias">Crear/editar materias</a><br>
        <a href="Controlador?action=categorias">Crear/editar categorías</a><br>
        <a href="Controlador?action=preguntas">Crear/editar preguntas</a><br>
        <a href="Controlador?action=juego">Iniciar juego</a><br>
        <hr>
        <a href="Controlador?action=logout">Logout</a><br>
        
    </center>
    </body>
</html>
