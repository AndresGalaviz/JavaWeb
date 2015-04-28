/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var usuarios = {
    Jugador1: 0,
    Jugador2: 0,
};

var respuestas = 0;
function seleccionar(obj) {
    $("#tablero").hide(1000);
    premio = parseInt(obj.innerText);
    document.getElementById("carta").innerHTML = "<br><h2>"+document.getElementById(obj.id).getElementsByTagName('div')[0].innerHTML + "<h2>";
    respuesta = document.getElementById(obj.id).getElementsByTagName('div')[1].innerHTML;
    document.getElementById("carta").innerHTML += "<br><hr><button onclick='mostrarRespuesta()'>Mostrar Respuesta</button> \n\
                                                      <button onclick='mostrarMenu()'>Mostrar Menu</button>"
    $("#pregunta").fadeIn(1000);
    
    document.getElementById(obj.id).removeAttribute("onclick");
    document.getElementById(obj.id).innerHTML = "";
    respuestas +=1;
    if(respuestas >= 25) {
        alert("Juego terminado! Guarda tus puntos")
    }
}

function terminarJuego() {
    var url = "/Controlador?action=guardarJuego&jugadorUno=" + document.getElementById('jugadorUno').value;
    url += "&jugadorDos=" + document.getElementById('jugadorDos').value
    url = url + '&puntosUno=' + usuarios.Jugador1;
    url = url + '&puntosDos=' + usuarios.Jugador2;
    

   
}
function mostrarRespuesta() {
    document.getElementById("carta").innerHTML += "<br><br>" + respuesta;
}

function mostrarMenu() {
    document.getElementById("carta").innerHTML = "";   
    $("#pregunta").hide(2000);
    $("#tablero").fadeIn(1000);
}

function agregarPuntos() {
    usuario = $( "#seleccionarUsuario option:selected" ).text();
    console.log(usuario);
    usuarios[usuario] += premio;
    premio = 0;
    document.getElementById("puntos").innerHTML = usuarios[usuario];
}

$(function() {
    $("#seleccionarUsuario").change(function() {
        usuario = $( "#seleccionarUsuario option:selected" ).text();
        document.getElementById("puntos").innerHTML = usuarios[usuario];
    });

});

function resetPuntos() {
    premio = 0;
}