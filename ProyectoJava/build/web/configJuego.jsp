<%-- 
    Document   : configJuego
    Created on : 26/04/2015, 08:46:45 PM
    Author     : Alberto
--%>

<%@page import="java.util.List"%>
<%@page import="Jeopardy.Materia"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Jeopardy</title>
        <link rel="StyleSheet" type="text/css" href="css/tabla.css"/>
        <script src="https://code.jquery.com/jquery-2.1.3.min.js"></script>
        <script type="text/javascript" src="js/configJuego.js"></script>
    </head>
    <body>
        <h1>Jeopardy!</h1>
        <form id="configJuego" name="configJuego" method="post" action="Controlador?action=iniciarJuego">
        <div id="seleccionMateria">
            <p>Elige una materia:</p>
            <select id="materia" name="materia">
                <option disabled selected value="dummy"> -- Elige una materia -- </option>
                <%
                    List<Materia> materias = (List<Materia>) request.getAttribute("materias");
                    for (Materia materia : materias) {
                %>
                <option value="<%= materia.getId()%>"><%= materia.getNombre()%></option>
                <%
                    }
                %>
            </select>
            <button type="button" onClick="cargarCategorias(document.getElementById('materia').value)">Aceptar</button>
        </div><hr>
        <div id="seleccionCategorias"></div><hr>
        <div id="seleccionPreguntas"></div>
        </form>
    </body>
</html>
