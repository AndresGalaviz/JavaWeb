<%-- 
    Document   : cambiarCont
    Created on : Apr 27, 2015, 8:37:30 PM
    Author     : MarthaElena
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("usuario") == null) {%>
        <jsp:forward page="login.jsp" />
    <%} 
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
        <h1>Actualiza tu contraseña</h1>
        <h2>Ingresa tus datos</h2>
        
        <form action="Controlador?action=update" method="POST">
            Contraseña antigua <input type="password" name="oldPassword" required="true">
            <br><br>       
            Contraseña nueva: <input type="password" name="newPassword" required="true">
            <br><br>
            Verificar contraseñaÑ <input type="password" name="verifyPassword" required="true">
            <br><br>
            <input type="submit" value ="Submit">
            <input type="reset" value="Reset">
        </form>
    </center>
    </body>
</html>
