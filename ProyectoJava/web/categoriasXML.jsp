<%@page import="Jeopardy.Categoria"%>
<%@page contentType="text/xml" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<categorias>
<%
    List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
    for (Categoria categoria : categorias) {
        %>
        <categoria id="<%= categoria.getId()%>" nombre="<%= categoria.getNombre()%>"></categoria>
        <%
    }
%>
</categorias>