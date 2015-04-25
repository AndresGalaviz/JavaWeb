<%-- 
    Document   : login
    Created on : Apr 24, 2015, 2:29:57 PM
    Author     : MarthaElena
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String message = (String) session.getAttribute("message");
    if (message == null) {
        message = "";
    }
    session.removeAttribute("message");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <jsp:useBean id = "datos" scope= "session"
                     class = "Jeopardy.DBhandler" />
    <center>
        <h1>Login</h1>
        <h2>Ingresa tus datos:</h2>
        <p style="color:blue"><%= message%></p>
        <form action="Controlador?action=login" method="POST">
            Usuario: <input type="text" name="user" required="true">
            <br><br>       
            Contraseña: <input type="password" name="password" required="true">
            <br>
            <br>
            <input type="submit" value ="Submit">
            <input type="reset" value="Reset">
        </form>
    </center>
    </body>
</html>
