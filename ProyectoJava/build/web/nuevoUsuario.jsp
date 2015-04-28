<%-- 
    Document   : nuevoUsuario
    Created on : 27/04/2015, 10:28:09 PM
    Author     : Alberto
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
    <center>
        <h1>Regístrate</h1>
        <h2>Ingresa tus datos:</h2>
        <form action="Controlador?action=nuevoUsuario" method="POST">
            Usuario: <input type="text" name="user" required="true">
            <br><br>       
            Correo: <input type="email" name="correo" required="true">
            <br>
            <br>
            <input type="submit" value ="Submit">
            <input type="reset" value="Reset">
        </form>
    </center>
    </body>
</html>
