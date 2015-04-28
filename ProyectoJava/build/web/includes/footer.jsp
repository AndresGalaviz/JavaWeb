<%@ page import="java.util.*" %>
<%
    // initialize the current year that's used in the
    // copyright notice
    GregorianCalendar currentDate = new GregorianCalendar();
    int currentYear = currentDate.get(Calendar.YEAR);
%>
<hr>
<center>
    <a href="menu.jsp">Volver al menú</a><br>
    <a href="Controlador?action=logout">Logout</a><br>
    <p><small>
            &copy; Copyright <%= currentYear%>
            All rights reserved
        </small></p>
</center>
</body>
</html>
