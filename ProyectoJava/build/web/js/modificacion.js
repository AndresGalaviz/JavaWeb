function trim(value) {
   var temp = value;
   var obj = /^(\s*)([\W\w]*)(\b\s*$)/;
   if (obj.test(temp)) { temp = temp.replace(obj, '$2');}
   var obj = /  /g;
   while (temp.match(obj)) { temp = temp.replace(obj, " ");}
   return temp;
}

//Funcion para calcular el largo en pixels det texto dado
function getTextWidth(texto)
{
	//Valor por default : 150 pixels
	var ancho = 150;

	if(trim(texto) === "")
	{
		return ancho;
	}

	//Creaci�n de un span escondido que se puedr� medir 
	var span = document.createElement("span");
	span.style.visibility = "hidden";
	span.style.position = "absolute";

	//Se agrega el texto al span y el span a la p�gina
	span.appendChild(document.createTextNode(texto));
	document.getElementsByTagName("body")[0].appendChild(span);

	//tama�o del texto
	ancho = span.offsetWidth;

	//Eliminaci�n del span
	document.getElementsByTagName("body")[0].removeChild(span);
	span = null;

	return ancho;
}


//Funcion de modificacion del elemento seleccionado mediante doble-click
function modificar(tabla, obj, id)
{ 
	//Objeto que sirve para editar el valor en la pagina 
	var input = null;

	input = document.createElement("input");


	//Asignar en la caja el valor de la casilla
	if (obj.innerText)
		input.value = obj.innerText;
	else
		input.value = obj.textContent;
	input.value = trim(input.value);

	//a la caja INPUT se la asigna un tama�o un poco mayor que el texto a modificar
	input.style.width  = getTextWidth(input.value) + 30 + "px";

	//Se remplaza el texto por el objeto INPUT
	obj.replaceChild(input, obj.firstChild);

	//Se selecciona el elemento y el texto a modificar
	input.focus();
	input.select();

	//Asignaci�n de los 2 eventos que provocar�n la escritura en la base de datos 

      //Salida de la INPUT
	input.onblur = function salir()
	{
		salvarMod(obj, input.value);
                actualizarBD(tabla, obj, input.value, id);
		delete input;
	};

	//La tecla Enter
	input.onkeydown = function keyDown(event)
	{
		if(event.keyCode === 13)
        {
			salvarMod(obj, input.value);
                        actualizarBD(tabla, obj, input.value, id);
			delete input;
		}
	};
}

//Salvando las modificaciones
function salvarMod(obj, valor)
{
obj.replaceChild(document.createTextNode(valor), obj.firstChild);
}

function actualizarBD(tabla, obj, valor, id) {
    var xhr = new XMLHttpRequest();
    var url = '/';
    if (tabla === 'materias') {
        url = 'Controlador?action=editarMateria';
    }
    url = url + '&id=' + id;
    url = url + '&element=' + obj.id;
    url = url + '&valor=' + valor;
    xhr.open("POST", url, true);
    xhr.onload = function() {};
    var data = new FormData();
    xhr.send(data);
}


function borrar(tabla, id) {
    var xhr = new XMLHttpRequest();
    var url = '/';
    if (tabla === 'materias') {
        url = 'Controlador?action=borrarMateria';
    }
    url = url + '&id=' + id;
    xhr.open("POST", url, true);
    xhr.onload = function() {};
    var data = new FormData();
    xhr.send(data);
    var row = document.getElementById('row-'+id);
    row.parentNode.removeChild(row);
    //document.getElementById('tabla-usuarios').deleteRow(rownum);
}

var request;
function getRequestObject() {
    if (window.ActiveXObject) {
        return(new ActiveXObject("Microsoft.XMLHTTP"));
    } else if (window.XMLHttpRequest) {
        return(new XMLHttpRequest());
    } else {
        return(null);
    }
}

function agregarMateria() {
    request = getRequestObject();
    request.onload = agregarMateriaAlHTML;
    request.open("GET", 'Controlador?action=agregarMateria', true);
    request.send(null);
}

function agregarMateriaAlHTML() {
    var id = request.responseText;
    if (id === '-1') {
        return;
    }
    var table = document.getElementById('tabla-materias');
    var row = table.insertRow(-1);
    row.id = 'row-' + id;

    var nombre = row.insertCell(0);
    nombre.id="nombre";
    nombre.className="celda";
    nombre.ondblclick=function() {
        modificar('materias', nombre, id);
    };
    nombre.innerHTML="nombre";

    var borrarR = row.insertCell(1);
    borrarR.id = "boton";
    borrarR.className = "celda";
    
    var boton = document.createElement("button");
    boton.type="button";
    boton.onclick = function () {
        borrar('materias', id);
    };
    boton.innerHTML = "Borrar";

    borrarR.appendChild(boton);

}