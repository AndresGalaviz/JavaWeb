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
    } else if (tabla === 'categorias') {
        url = 'Controlador?action=editarCategoria';
    } else if (tabla === 'preguntas') {
        url = 'Controlador?action=editarPregunta';
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
    } else if (tabla === 'categorias') {
        url = 'Controlador?action=borrarCategoria';
    } else if (tabla === 'preguntas') {
        url = 'Controlador?action=borrarPregunta';
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
    request.onload = agregarMateriaAux;
    request.open("GET", 'Controlador?action=agregarMateria', true);
    request.send(null);
}

function agregarMateriaAux() {
    var id = request.responseText;
    if (id === '-1') {
        return;
    }
    agregarMateriaAlHTML(id, 'nombre');
}

function agregarCategoria(materia) {
    if (materia === 'dummy')
        return;
    request = getRequestObject();
    request.onload = agregarCategoriaAux;
    request.open("GET", 'Controlador?action=agregarCategoria&idMateria=' + materia, true);
    request.send(null);
}

function agregarCategoriaAux() {
    var id = request.responseText;
    if (id === '-1') {
        return;
    }
    agregarCategoriaAlHTML(id, "nombre");
}

function agregarPregunta(categoria) {
    if (categoria === 'dummy')
        return;
    request = getRequestObject();
    request.onload = agregarPreguntaAux;
    request.open("GET", 'Controlador?action=agregarPregunta&idCategoria=' + categoria, true);
    request.send(null);
}

function agregarPreguntaAux() {
    var id = request.responseText;
    if (id === '-1') {
        return;
    }
    agregarPreguntaAlHTML(id, 'pregunta', 'respuesta', '0');
}

function agregarMateriaAlHTML(id, nombreVal) {
    var table = document.getElementById('tabla-materias');
    var row = table.insertRow(-1);
    row.id = 'row-' + id;

    var nombre = row.insertCell(0);
    nombre.id=nombreVal;
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

function agregarCategoriaAlHTML(id, nombreVal) {
    var table = document.getElementById('tabla-categorias');
    var row = table.insertRow(-1);
    row.id = 'row-' + id;

    var nombre = row.insertCell(0);
    nombre.id="nombre";
    nombre.className="celda";
    nombre.ondblclick=function() {
        modificar('categorias', nombre, id);
    };
    nombre.innerHTML=nombreVal;

    var borrarR = row.insertCell(1);
    borrarR.id = "boton";
    borrarR.className = "celda";
    
    var boton = document.createElement("button");
    boton.type="button";
    boton.onclick = function () {
        borrar('categorias', id);
    };
    boton.innerHTML = "Borrar";

    borrarR.appendChild(boton);
}

function agregarPreguntaAlHTML(id, preguntaVal, respuestaVal, puntosVal) {
    var table = document.getElementById('tabla-preguntas');
    var row = table.insertRow(-1);
    row.id = 'row-' + id;

    var pregunta = row.insertCell(0);
    pregunta.id="pregunta";
    pregunta.className="celda";
    pregunta.ondblclick=function() {
        modificar('preguntas', pregunta, id);
    };
    pregunta.innerHTML=preguntaVal;

    var respuesta = row.insertCell(1);
    respuesta.id="respuesta";
    respuesta.className="celda";
    respuesta.ondblclick=function() {
        modificar('preguntas', respuesta, id);
    };
    respuesta.innerHTML=respuestaVal;
    
    var puntos = row.insertCell(2);
    puntos.id="puntos";
    puntos.className="celda";
    puntos.ondblclick=function() {
        modificar('preguntas', puntos, id);
    };
    puntos.innerHTML=puntosVal;
    
    var borrarR = row.insertCell(3);
    borrarR.id = "boton";
    borrarR.className = "celda";
    
    var boton = document.createElement("button");
    boton.type="button";
    boton.onclick = function () {
        borrar('preguntas', id);
    };
    boton.innerHTML = "Borrar";

    borrarR.appendChild(boton);
}

function cargaCategorias(materia) {
    $.ajax({
        url: 'Controlador?action=cargarCategorias&materia=' + materia,
        type: 'GET',
        dataType: 'xml',
        success: function(returnedXMLResponse) {
            vaciarTabla('tabla-categorias');
            $('categoria', returnedXMLResponse).each(function() {
                var id = $(this).attr('id');
                var nombre = $(this).attr('nombre');
                agregarCategoriaAlHTML(id, nombre);
            });
        }
    });
}

function cargaCategoriasDropdown(materia) {
    vaciarTabla('tabla-preguntas');
    $.ajax({
        url: 'Controlador?action=cargarCategorias&materia=' + materia,
        type: 'GET',
        dataType: 'xml',
        success: function(returnedXMLResponse) {
            $('#categoria option:gt(0)').remove();
            var $el = $('#categoria');
            $('categoria', returnedXMLResponse).each(function() {
                var nombre = $(this).attr('nombre');
                var id = $(this).attr('id');
                $el.append($("<option></option>").attr("value", id).text(nombre));
            });
            $el.val('dummy');
        }
    });
}

function cargaPreguntas(categoria) {
    $.ajax({
        url: 'Controlador?action=cargarPreguntas&categoria=' + categoria,
        type: 'GET',
        dataType: 'xml',
        success: function(returnedXMLResponse) {
            vaciarTabla('tabla-preguntas');
            $('pregunta', returnedXMLResponse).each(function() {
                var id = $(this).attr('id');
                var pregunta = $(this).attr('pregunta');
                var respuesta = $(this).attr('respuesta');
                var puntos = $(this).attr('puntos');
                agregarPreguntaAlHTML(id, pregunta, respuesta, puntos);
            });
        }
    });
}

function vaciarTabla(idTabla) {
    var tabla = document.getElementById(idTabla);
    var rowCount = tabla.rows.length;
    while (--rowCount) {
        tabla.deleteRow(rowCount);
    }
}