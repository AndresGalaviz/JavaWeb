<%-- 
    Document   : categorias
    Created on : 25/04/2015, 06:21:57 PM
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
        <title>Crear/editar categorias</title>
        <link rel="StyleSheet" type="text/css" href="css/tabla.css"/>
        <script src="https://code.jquery.com/jquery-2.1.3.min.js"></script>
        <script type="text/javascript" src="js/modificacion.js"></script>
    </head>
    <body>
        <h1>Crear/editar categorias</h1>
        Elige una materia:   
        <select id="materia" onChange="cargaCategorias(this.value)">
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
        <table id="tabla-categorias">
            <tr>
                <th>Nombre</th>
                <th>X</th>
            </tr>
        </table>
        <button type="button" onclick="agregarCategoria(document.getElementById('materia').value)">Agregar categoria</button>

<%@ include file="/includes/footer.jsp" %>