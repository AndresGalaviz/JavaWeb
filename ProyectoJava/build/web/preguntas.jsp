<%-- 
    Document   : preguntas
    Created on : 26/04/2015, 03:24:46 PM
    Author     : Alberto
--%>

<%@page import="java.util.List"%>
<%@page import="Jeopardy.Materia"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("usuario") == null) {%>
        <jsp:forward page="login.jsp" />
    <%} 
    if(request.getAttribute("materias") == null) {
        %>
        <jsp:forward page="menu.jsp" />
    <%}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Crear/editar preguntas</title>
        <link rel="StyleSheet" type="text/css" href="css/tabla.css"/>
        <script src="https://code.jquery.com/jquery-2.1.3.min.js"></script>
        <script type="text/javascript" src="js/modificacion.js"></script>
    </head>
    <body>
        <h1>Crear/editar preguntas</h1>
        Elige una materia:   
        <select id="materia" onChange="cargaCategoriasDropdown(this.value)">
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
        <br>
        Elige una categoria:
        <select id="categoria" onChange="cargaPreguntas(this.value)">
            <option disabled selected value="dummy"> -- Elige una categoria -- </option>
        </select>
        <br>
        <table id="tabla-preguntas">
            <tr>
                <th>Pregunta</th>
                <th>Respuesta</th>
                <th>Puntos</th>
                <th>X</th>
            </tr>
        </table>
        <button type="button" onclick="agregarPregunta(document.getElementById('categoria').value)">Agregar pregunta</button>
    </body>
</html>
