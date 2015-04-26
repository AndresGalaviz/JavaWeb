<%-- 
    Document   : preguntasXML
    Created on : 26/04/2015, 03:59:19 PM
    Author     : Alberto
--%>

<%@page import="Jeopardy.Pregunta"%>
<%@page contentType="text/xml" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<preguntas>
<%
    List<Pregunta> preguntas = (List<Pregunta>) request.getAttribute("preguntas");
    for (Pregunta pregunta : preguntas) {
        %>
        <pregunta id="<%= pregunta.getId()%>" 
                   pregunta="<%= pregunta.getPregunta()%>"
                   respuesta="<%= pregunta.getRespuesta()%>"
                   puntos="<%= pregunta.getPuntos()%>">
        </pregunta>
        <%
    }
%>
</preguntas>
