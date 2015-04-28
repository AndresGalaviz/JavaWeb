<%-- 
    Document   : juego
    Created on : Apr 27, 2015, 9:16:56 PM
    Author     : MarthaElena
--%>

<%@page import="Jeopardy.Categoria"%>
<%@page import="Jeopardy.Pregunta"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Pregunta> preguntas = (List<Pregunta>) request.getAttribute("preguntas");
    List<Categoria> categorias = (List<Categoria>)request.getAttribute("categorias");
    String materia = request.getParameter("materia");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Jeopardy!</title>
        <script src="https://code.jquery.com/jquery-2.1.3.min.js"></script>
        <script type="text/javascript" src="js/juego.js"></script>
        <style>
            td {
                background-color: darkblue;
                color: white;
                text-align: center;
            }
            td:hover {
                background-color: red;          
            }

        </style>
    </head>
    <body>
    <center>
        <div id="tablero">
            <h1>Play</h1>
                
            <table border="5" width="500" height = "500">
                <div id="jugadores">
                    
                    Jugador uno:<input type="text" name ="jugadorUno" id ="jugadorUno" required/>
                    Jugador dos:<input type="text" name ="jugadorDos" id ="jugadorDos" required/>
                    
                    
                    
                    <hr>
                    <select id="seleccionarUsuario">
                        <option>Jugador1</option>
                        <option>Jugador2</option>
                    </select>
                    
                    Puntaje: <div id="puntos"></div>
                </div>
                <button onclick="agregarPuntos()">Agregar Puntos</button>
                <button onclick="resetPuntos()">No asignar Puntos</button>
                <br><br>
                <tr>
                    <% for(Categoria cat : categorias) { %>
                    <th><%=cat.getNombre()%></th>
                    <%}%>
                </tr>
                <% for(int i = 0; i < preguntas.size(); i++) { %>
                <tr>
                    <td onclick="seleccionar(this)" id="q<%= i%5 %><%= i/5 %>">
                        <%= preguntas.get(i).getPuntos()%><div id="pregunta" hidden='TRUE'><%= preguntas.get(i).getPregunta()%></div>
                        <div id="respuesta" hidden='TRUE'><%= preguntas.get(i).getRespuesta()%></div>
                    </td>
                    <%i++;%>
                    <td onclick="seleccionar(this)" id="q<%= i%5 %><%= i/5 %>">
                        <%= preguntas.get(i).getPuntos()%><div id="pregunta" hidden='TRUE'><%= preguntas.get(i).getPregunta()%></div>
                        <div id="respuesta" hidden='TRUE'><%= preguntas.get(i).getRespuesta()%></div>
                    </td>
                    <%i++;%>
                    <td onclick="seleccionar(this)" id="q<%= i%5 %><%= i/5 %>">
                        <%= preguntas.get(i).getPuntos()%><div id="pregunta" hidden='TRUE'><%= preguntas.get(i).getPregunta()%></div>
                        <div id="respuesta" hidden='TRUE'><%= preguntas.get(i).getRespuesta()%></div>
                    </td>
                    <%i++;%>
                    <td onclick="seleccionar(this)" id="q<%= i%5 %><%= i/5 %>">
                        <%= preguntas.get(i).getPuntos()%><div id="pregunta" hidden='TRUE'><%= preguntas.get(i).getPregunta()%></div>
                        <div id="respuesta" hidden='TRUE'><%= preguntas.get(i).getRespuesta()%></div>
                    </td>
                    <%i++;%>
                    <td onclick="seleccionar(this)" id="q<%= i%5 %><%= i/5 %>">
                        <%= preguntas.get(i).getPuntos()%><div id="pregunta" hidden='TRUE'><%= preguntas.get(i).getPregunta()%></div>
                        <div id="respuesta" hidden='TRUE'><%= preguntas.get(i).getRespuesta()%></div>
                    </td>
                   
                </tr>
                <%}%>
                </tr>        
            </table>
        </div>

        <div id="carta">

        </div>
    </center>
</body>
<%@ include file="/includes/footer.jsp" %>
</html>
