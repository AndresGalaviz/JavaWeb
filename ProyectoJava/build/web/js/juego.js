/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var usuarios = {
    Andres: 0,
    Juan: 0,
};

function seleccionar(obj) {
    $("#tablero").hide(1000);
    premio = parseInt(obj.innerText);
    document.getElementById("carta").innerHTML = "<br><h1>"+document.getElementById(obj.id).getElementsByTagName('div')[0].innerHTML + "<h1>";
    respuesta = document.getElementById(obj.id).getElementsByTagName('div')[1].innerHTML;
    document.getElementById("carta").innerHTML += "<br><hr><button onclick='mostrarRespuesta()'>Mostrar Respuesta</button> \n\
                                                      <button onclick='mostrarMenu()'>Mostrar Menu</button>"
    $("#pregunta").fadeIn(1000);
    
    
    document.getElementById(obj.id).innerHTML = "";

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

$('select[name="seleccionarUsuario"]').change(function(){
  
        usuario = $( "#seleccionarUsuario option:selected" ).text();
        document.getElementById("puntos").innerHTML = usuarios[usuario];
    
});