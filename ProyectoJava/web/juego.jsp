<%-- 
    Document   : juego
    Created on : Apr 27, 2015, 9:16:56 PM
    Author     : MarthaElena
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                    <select id="seleccionarUsuario">
                        <option>Andres</option>
                        <option>Juan</option>
                    </select>
                    
                    <div id="puntos"></div>
                </div>
                <button onclick="agregarPuntos()">Agregar Puntos</button>
                <br><br>
                <tr>
                    <td onclick="seleccionar(this)" id="q11" value="100" >
                        100<div id="pregunta" hidden='TRUE'>Pregunta</div>
                        <div id="respuesta" hidden='TRUE'>Respuesta</div>
                    </td>
                    <td onclick="seleccionar(this)" id="q21" value ="100">
                        100<div id="pregunta" hidden='TRUE'>Pregunta</div>
                        <div id="respuesta" hidden='TRUE'>Respuesta</div></td>
                    <td onclick="seleccionar(this)" id="q31" value ="100">
                        100<div id="pregunta" hidden='TRUE'>Pregunta</div>
                        <div id="respuesta" hidden='TRUE'>Respuesta</div></td>
                    <td onclick="seleccionar(this)" id="q41" value ="100">
                        100<div id="pregunta" hidden='TRUE'>Pregunta</div>
                        <div id="respuesta" hidden='TRUE'>Respuesta</div></td>
                    <td onclick="seleccionar(this)" id="q51" value ="100">
                        100<div id="pregunta" hidden='TRUE'>Pregunta</div>
                        <div id="respuesta" hidden='TRUE'>Respuesta</div></td>
                </tr>
                <tr>
                    <td onclick="seleccionar(this)" id="q12" value="200" >
                        200<div id="pregunta" hidden='TRUE'>Pregunta</div>
                        <div id="respuesta" hidden='TRUE'>Respuesta</div>
                    </td>
                    <td onclick="seleccionar(this)" id="q22" value="200" >
                        100<div id="pregunta" hidden='TRUE'>Pregunta</div>
                        <div id="respuesta" hidden='TRUE'>Respuesta</div>
                    </td>
                    <td onclick="seleccionar(this)" id="q32" value="200" >
                        200<div id="pregunta" hidden='TRUE'>Pregunta</div>
                        <div id="respuesta" hidden='TRUE'>Respuesta</div>
                    </td>
                    <td onclick="seleccionar(this)" id="q42" value="200" >
                        200<div id="pregunta" hidden='TRUE'>Pregunta</div>
                        <div id="respuesta" hidden='TRUE'>Respuesta</div>
                    </td>
                    <td onclick="seleccionar(this)" id="q52" value="200" >
                        200<div id="pregunta" hidden='TRUE'>Pregunta</div>
                        <div id="respuesta" hidden='TRUE'>Respuesta</div>
                    </td>
                </tr>
                <tr>
                    <td onclick="seleccionar(this)" id="q13" value="300" >
                        300<div id="pregunta" hidden='TRUE'>Pregunta</div>
                        <div id="respuesta" hidden='TRUE'>Respuesta</div>
                    </td>
                    <td onclick="seleccionar(this)" id="q23" value="300" >
                        300<div id="pregunta" hidden='TRUE'>Pregunta</div>
                        <div id="respuesta" hidden='TRUE'>Respuesta</div>
                    </td>
                    <td onclick="seleccionar(this)" id="q33" value="300" >
                        300<div id="pregunta" hidden='TRUE'>Pregunta</div>
                        <div id="respuesta" hidden='TRUE'>Respuesta</div>
                    </td>
                    <td onclick="seleccionar(this)" id="q43" value="300" >
                        300<div id="pregunta" hidden='TRUE'>Pregunta</div>
                        <div id="respuesta" hidden='TRUE'>Respuesta</div>
                    </td>
                    <td onclick="seleccionar(this)" id="q53" value="300" >
                        300<div id="pregunta" hidden='TRUE'>Pregunta</div>
                        <div id="respuesta" hidden='TRUE'>Respuesta</div>
                    </td>
                </tr>
                <tr>
                    <td onclick="seleccionar(this)" id="q14"value="400" >
                        400<div id="pregunta" hidden='TRUE'>Pregunta</div>
                        <div id="respuesta" hidden='TRUE'>Respuesta</div>
                    </td>
                    <td onclick="seleccionar(this)" id="q24"value="400" >
                        400<div id="pregunta" hidden='TRUE'>Pregunta</div>
                        <div id="respuesta" hidden='TRUE'>Respuesta</div>
                    </td>
                    <td onclick="seleccionar(this)" id="q34"value="400" >
                        400<div id="pregunta" hidden='TRUE'>Pregunta</div>
                        <div id="respuesta" hidden='TRUE'>Respuesta</div>
                    </td>
                    <td onclick="seleccionar(this)" id="q44"value="400" >
                        400<div id="pregunta" hidden='TRUE'>Pregunta</div>
                        <div id="respuesta" hidden='TRUE'>Respuesta</div>
                    </td>
                    <td onclick="seleccionar(this)" id="q54"value="400" >
                        400<div id="pregunta" hidden='TRUE'>Pregunta</div>
                        <div id="respuesta" hidden='TRUE'>Respuesta</div>
                    </td>
                </tr>
                <tr>
                    <td onclick="seleccionar(this)" id="q15" value="500" >
                        500<div id="pregunta" hidden='TRUE'>Pregunta</div>
                        <div id="respuesta" hidden='TRUE'>Respuesta</div>
                    </td>
                    <td onclick="seleccionar(this)" id="q25" value="500" >
                        500<div id="pregunta" hidden='TRUE'>Pregunta</div>
                        <div id="respuesta" hidden='TRUE'>Respuesta</div>
                    </td>
                    <td onclick="seleccionar(this)" id="q35"value="500" >
                        500<div id="pregunta" hidden='TRUE'>Pregunta</div>
                        <div id="respuesta" hidden='TRUE'>Respuesta</div>
                    </td>
                    <td onclick="seleccionar(this)" id="q45" value="500" >
                        500<div id="pregunta" hidden='TRUE'>Pregunta</div>
                        <div id="respuesta" hidden='TRUE'>Respuesta</div>
                    </td>
                    <td onclick="seleccionar(this)" id="q55" value="500" >
                        500<div id="pregunta" hidden='TRUE'>Pregunta</div>
                        <div id="respuesta" hidden='TRUE'>Respuesta</div>
                    </td>
                </tr>        
            </table>
        </div>

        <div id="carta">

        </div>
    </center>
</body>
</html>
