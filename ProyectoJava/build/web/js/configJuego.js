function cargarCategorias(materia) {
    if (materia === 'dummy') {
        return;
    }
    $.ajax({
        url: 'Controlador?action=cargarCategorias&materia=' + materia,
        type: 'GET',
        dataType: 'xml',
        success: function(returnedXMLResponse) {
            $divP = $('#seleccionCategorias');
            $divP.empty();
            $('#seleccionPreguntas').empty();
            $divP.append($('<p></p>').text('Elige cinco categorias:'));
            $('categoria', returnedXMLResponse).each(function() {
                var id = $(this).attr('id');
                var nombre = $(this).attr('nombre');
                $input = $('<input>').attr('type', 'checkbox').attr('name', 'categorias').attr('value', id).attr('nombre', nombre);
                $divP.append($input);
                $divP.append(nombre + '<br>');
            });
            $boton = $('<button></button>').attr('type', 'button').attr('onclick', 'cargarMaterias()').text('Aceptar');
            $divP.append('<br>');
            $divP.append($boton);
        }
    });
}

function cargarMaterias() {
    var count = $("input[name='categorias']:checked").size();
    if (count !== 5) {
        alert('Debes de elegir cinco categorias');
    } else {
        $divP = $('#seleccionPreguntas');
        $divP.empty();
        $divP.append($('<p></p>').text('Elige una de las categorias:'));
        $select = $('<select></select>').attr('id', 'categoria').attr('onChange', 'aparecerPreguntas(this.value)');
        $select.append($('<option disabled select></option>').attr('value', 'dummy').text(' -- Elige una categoria -- '));
        $divP.append($select);
        $divP.append('<br>');
        $("input[name='categorias']:checked").each(function() {
            $opt = $('<option></option>').attr('value', $(this).attr('value')).text($(this).attr('nombre'));
            $select.append($opt);
            $subdiv = $('<div></div>').attr('id', 'preguntas').attr('categoria', $(this).attr('value')).attr('hidden', true);
            $divP.append($subdiv);
            cargarPreguntas($(this).attr('value'));
        });
        $select.val('dummy');
        $divP.append('<br>');
        $divP.append($('<button type="button" onclick="iniciarJuego()">Iniciar juego</button>'));
    }
}

function aparecerPreguntas(categoria) {
    if (categoria === 'dummy') {
        return;
    }
    $("div[id='preguntas']").each(function() {
        this.hidden = true;
        if ($(this).attr('categoria') === categoria)
            this.hidden = false;
    });
}

function cargarPreguntas(categoria) {
    $.ajax({
        url: 'Controlador?action=cargarPreguntas&categoria=' + categoria,
        type: 'GET',
        dataType: 'xml',
        success: function(returnedXMLResponse) {
            $divX = $("div[categoria='" + categoria + "']");
            $divX.append($('<p></p>').text('Elige cinco preguntas para esta categoria:'));
            $('pregunta', returnedXMLResponse).each(function() {
                var id = $(this).attr('id');
                var pregunta = $(this).attr('pregunta');
                $input = $('<input>').attr('type', 'checkbox').attr('name', 'idPreguntas' + categoria).attr('value', id);
                $divX.append($input);
                $divX.append(pregunta + '<br>')
            });
        }
    });
}

function iniciarJuego() {
    var preguntasCompletas = true;
    $("div[id='preguntas']").each(function() {
        var categoria = $(this).attr('categoria');
        var count = $("input[name='idPreguntas" + categoria + "']:checked").size();
        if (count !== 5) {
            preguntasCompletas = false;
        }
    });
    if (!preguntasCompletas) {
        alert('No se eligieron 5 preguntas para cada categoria');
    } else {
        document.getElementById("configJuego").submit();
    }
}