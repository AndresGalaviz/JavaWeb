<%-- 
    Document   : materias
    Created on : 25/04/2015, 04:26:59 PM
    Author     : Alberto
--%>

<%@page import="java.util.List"%>
<%@page import="Jeopardy.Materia"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html;charset=iso-8859-1" />
        <title>Crear/editar materias</title>
        <link rel="StyleSheet" type="text/css" href="css/tabla.css"/>
        <script type="text/javascript" src="js/modificacion.js"></script>
    </head>
    <body>
        <h1>Crear/editar materias</h1>
        <table id="tabla-materias">
            <tr>
                <th>Nombre</th>
                <th></th>
            </tr>
            <%
                List<Materia> materias = (List<Materia>) request.getAttribute("materias");
                for (Materia materia : materias) {
                    String idRow = "row-" + materia.getId();
            %>
            <tr id="<%= idRow%>">
                <td id="nombre" class="celda" ondblclick="modificar('materias', this, <%= materia.getId()%>)"><%= materia.getNombre()%></td>
                <td id="boton" class="celda">
                    <button type="button" onclick="borrar('materias', <%= materia.getId()%>)">Borrar</button>
                </td>
            </tr>
            <%
                }
            %>
        </table>
        <div>
            <button type="button" onclick="agregarMateria()">Agregar materia</button>
        </div>

    </body>
</html>
