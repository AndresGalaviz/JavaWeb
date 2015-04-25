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
    xhr.open("POST", url, true);
    xhr.onload = function() {};
    var data = new FormData();
    data.append("id", id);
    data.append("element", obj.id);
    data.append("valor", valor);
    xhr.send(data);
}


function borrar(tabla, id) {
    var xhr = new XMLHttpRequest();
    var url = '/';
    if (tabla === 'materias') {
        url = 'Controlador?action=borrarMateria';
    }
    xhr.open("POST", url, true);
    xhr.onload = function() {};
    var data = new FormData();
    data.append("id", id);
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

function agregarFila() {
    request = getRequestObject();
    request.onload = agregarFilaAlHTML;
    request.open("GET", "agregar.php", true);
    request.send(null);
}

function agregarFilaAlHTML() {
    var id = request.responseText;
    var table = document.getElementById('tabla-usuarios');
    var row = table.insertRow(-1);
    var rownum = table.rows.length;

    var nombre = row.insertCell(0);
    nombre.id="nombre";
    nombre.className="celda";
    nombre.ondblclick=function() {
        modificar(nombre, id);
    };
    nombre.innerHTML="nombre";

    var apellido = row.insertCell(1);
    apellido.id="apellido";
    apellido.className="celda";
    apellido.ondblclick=function() {
        modificar(apellido, id);
    };
    apellido.innerHTML="apellido";

    var direccion = row.insertCell(2);
    direccion.id="direccion";
    direccion.className="celda";
    direccion.ondblclick=function() {
        modificar(direccion, id);
    };
    direccion.innerHTML="direccion";

    var codigo = row.insertCell(3);
    codigo.id="codigo";
    codigo.className="celda";
    codigo.ondblclick=function() {
        modificar(codigo, id);
    };
    codigo.innerHTML="codigo";

    var ciudad = row.insertCell(4);
    ciudad.id="ciudad";
    ciudad.className="celda";
    ciudad.ondblclick=function() {
        modificar(ciudad, id);
    };
    ciudad.innerHTML="ciudad";

    var hijos = row.insertCell(5);
    hijos.id="hijos";
    hijos.className="celda";
    hijos.ondblclick=function() {
        modificar(hijos, id);
    };
    hijos.innerHTML="0";

    var email = row.insertCell(6);
    email.id="email";
    email.className="celda";
    email.ondblclick= function () {
        modificar(email, id);
    };
    email.innerHTML="email";

    var borrar = row.insertCell(7);
    borrar.id = "boton";
    borrar.className = "celda";
    //borrar.innerHTML = "<button type=\"button\" onclick=\"borrar(" + id + "," + rownum + ")\">Borrar</button>";
    //borrar.innerHTML = "Borrar";
    borrar.className = "celda";

    var boton = document.createElement("button");
    boton.type="button";
    boton.onclick = function () {
        borrar(id, rownum);
    };
    boton.innerHTML = "Borrar";

    borrar.appendChild(boton);

}