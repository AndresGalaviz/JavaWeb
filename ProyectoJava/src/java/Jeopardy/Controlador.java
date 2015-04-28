package Jeopardy;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author MarthaElena
 */
public class Controlador extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        String url = "/";
        if (action.equals("login")) {
            String user = request.getParameter("user");
            String password = request.getParameter("password");
            int id = DBhandler.validarUsuario(user, password);
            Integer wrongPassword = DBhandler.getCuentaBloqueo(user);
            if (id != -1 && wrongPassword > 0) {
                url = "/menu.jsp";
                boolean usuarioNuevo = DBhandler.getUsuarioNuevo(user);
                if(usuarioNuevo) {
                    url = "/cambiarCont.jsp";
                }
                request.getSession().setAttribute("idPerfil", id);
                request.getSession().setAttribute("usuario", user);
                request.getSession().removeAttribute("message");
            } else {
                url = "/login.jsp";
                wrongPassword -=  1;
                if(wrongPassword >= 0)
                    DBhandler.editarPorUsuario("perfiles", user, "cuentaBloqueo", wrongPassword);
                
                String mensaje;
                
                mensaje = "Contraseña incorrecta, intente de nuevo. Tiene " + String.valueOf(wrongPassword) + " intentos mas.";
                if(wrongPassword <= 0) {
                        // TODO: Bloquear usuario
                    DBhandler.editarPorUsuario("perfiles", user, "bloqueado", 1);
                    mensaje = "Su cuenta ha sido bloqueada";
                }
                request.getSession().setAttribute("message", mensaje);
                
            }
        }
        if(request.getSession().getAttribute("idPerfil") == null) {
            url = "/login.jsp";
        } else if (action.equals("update")) {
            String user = (String)request.getSession().getAttribute("usuario");
            String oldPassword = (String)request.getParameter("oldPassword");
            String newPassword = (String)request.getParameter("newPassword");
            String verifyPassword = (String)request.getParameter("verifyPassword");
            int id = DBhandler.validarUsuario(user, oldPassword);
            if(!newPassword.equals(verifyPassword) || id == -1) {
                url = "/menu.jsp";
                request.getSession().setAttribute("message", "Error en contraseñas");
            } else if (id != -1) {
                DBhandler.editarTabla("perfiles", id, "password", newPassword);
                DBhandler.editarPorUsuario("perfiles", user, "usuarioNuevo", 0);
                url = "/menu.jsp";
            }

        }else if (action.equals("materias")) {
            int idPerfil = (int)request.getSession().getAttribute("idPerfil");
            List<Materia> materias = DBhandler.getMaterias(idPerfil);
            request.setAttribute("materias", materias);
            url = "/materias.jsp";
        } else if (action.equals("editarMateria")) {
            int id = Integer.valueOf(request.getParameter("id"));
            String elemento = (String)request.getParameter("element");
            String valor = (String)request.getParameter("valor");
            DBhandler.editarTabla("materias", id, elemento, valor);
        } else if (action.equals("borrarMateria")) {
            int id = Integer.valueOf(request.getParameter("id"));
            DBhandler.borrarElemento("materias", id);
        } else if (action.equals("agregarMateria")) {
            PrintWriter out = response.getWriter();
            int idPerfil = (int)request.getSession().getAttribute("idPerfil");
            int id = DBhandler.agregarMateria(idPerfil);
            out.println(id);
            return;
        } else if (action.equals("categorias")) {
            int idPerfil = (int)request.getSession().getAttribute("idPerfil");
            List<Materia> materias = DBhandler.getMaterias(idPerfil);
            request.setAttribute("materias", materias);
            url = "/categorias.jsp";
        } else if (action.equals("cargarCategorias")) {
            int idMateria = Integer.valueOf(request.getParameter("materia"));
            List<Categoria> categorias = DBhandler.getCategorias(idMateria);
            request.setAttribute("categorias", categorias);
            url = "/categoriasXML.jsp";
        } else if (action.equals("editarCategoria")) {
            int id = Integer.valueOf(request.getParameter("id"));
            String elemento = (String)request.getParameter("element");
            String valor = (String)request.getParameter("valor");
            DBhandler.editarTabla("categorias", id, elemento, valor);
        } else if (action.equals("borrarCategoria")) {
            int id = Integer.valueOf(request.getParameter("id"));
            DBhandler.borrarElemento("categorias", id);
        } else if (action.equals("agregarCategoria")) {
            PrintWriter out = response.getWriter();
            int idMateria = Integer.valueOf(request.getParameter("idMateria"));
            int id = DBhandler.agregarCategoria(idMateria);
            out.println(id);
            return;
        } else if (action.equals("preguntas")) {
            int idPerfil = (int)request.getSession().getAttribute("idPerfil");
            List<Materia> materias = DBhandler.getMaterias(idPerfil);
            request.setAttribute("materias", materias);
            url = "/preguntas.jsp";
        } else if (action.equals("cargarPreguntas")) {
            int idCategoria = Integer.valueOf(request.getParameter("categoria"));
            List<Pregunta> preguntas = DBhandler.getPreguntas(idCategoria);
            request.setAttribute("preguntas", preguntas);
            url = "/preguntasXML.jsp";
        } else if (action.equals("editarPregunta")) {
            int id = Integer.valueOf(request.getParameter("id"));
            String elemento = (String)request.getParameter("element");
            String valor = (String)request.getParameter("valor");
            DBhandler.editarTabla("preguntas", id, elemento, valor);
        } else if (action.equals("borrarPregunta")) {
            int id = Integer.valueOf(request.getParameter("id"));
            DBhandler.borrarElemento("preguntas", id);
        } else if (action.equals("agregarPregunta")) {
            PrintWriter out = response.getWriter();
            int idCategoria = Integer.valueOf(request.getParameter("idCategoria"));
            int id = DBhandler.agregarPregunta(idCategoria);
            out.println(id);
            return;
        } else if (action.equals("juego")) {
            int idPerfil = (int)request.getSession().getAttribute("idPerfil");
            List<Materia> materias = DBhandler.getMaterias(idPerfil);
            request.setAttribute("materias", materias);
            url = "/configJuego.jsp";
        } else if (action.equals("iniciarJuego")) {

        } else if (action.equals("logout")) {
            request.getSession().removeAttribute("usuario");
            request.getSession().removeAttribute("idPerfil");
            url = "/login.jsp";
        }
        
        
        RequestDispatcher dispatcher
                = getServletContext().getRequestDispatcher(url);
        dispatcher.forward(request, response);
        
        /*try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Controlador</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Controlador at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }*/
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
