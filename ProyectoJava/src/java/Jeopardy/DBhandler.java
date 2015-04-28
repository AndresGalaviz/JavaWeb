/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Jeopardy;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author rperez
 */
public class DBhandler {

    private static Connection connection;

    public DBhandler() {
        createConnection();
    }
    
    private static void createConnection() {
        try {
            //Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost/jeopardy", "root", "");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static int validarUsuario(String usuario, String pw) {
        int id = -1;
        try {            
            if (connection == null) {
                createConnection();
            }
            
            Statement statement = connection.createStatement();
            String query = "select id from perfiles where usuario = '" 
                    + usuario + "' and password = '" + pw + "'";
            ResultSet results = statement.executeQuery(query);
            if (results.next()) {
                id = results.getInt("id");
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return id;
    }
    
    public static String crearUsuario(String usuario, String correo) {
        String pw = RandomPassword.randomPassword(10);
        System.out.println(pw);
        try {          
            if (connection == null) {
                createConnection();
            }
            Statement statement = connection.createStatement();
            String query = "insert into perfiles (usuario, password, usuarioNuevo) values ('" + usuario + "', '" + pw + "', 1)";
            statement.execute(query);
        } catch (SQLException ex) {
            Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
        MailHandler.sendMail(correo, usuario, pw);
        return pw;
    }
    
    public static int getCuentaBloqueo(String usuario) {
        int cuentaBloqueo = -1;
        try {            
            if (connection == null) {
                createConnection();
            }
            
            Statement statement = connection.createStatement();
            String query = "select cuentaBloqueo from perfiles where usuario = '" 
                    + usuario + "'";
            ResultSet results = statement.executeQuery(query);
            if (results.next()) {
                cuentaBloqueo = results.getInt("cuentaBloqueo");
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return cuentaBloqueo;
    }
    
    public static boolean getUsuarioNuevo(String usuario) {
        boolean usuarioNuevo = false;
        try {            
            if (connection == null) {
                createConnection();
            }
            
            Statement statement = connection.createStatement();
            String query = "select usuarioNuevo from perfiles where usuario = '" 
                    + usuario + "'";
            ResultSet results = statement.executeQuery(query);
            if (results.next()) {
                usuarioNuevo = results.getBoolean("usuarioNuevo");
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return usuarioNuevo;
    }
    
    public static void editarTabla(String tabla, int idElemento, String columna, String valor) {
        if (connection == null) {
            createConnection();
        }
        try {
            Statement statement = connection.createStatement();
            String query = "update " + tabla + " set " + columna + " = '" + valor + "' where id = " + idElemento;
            statement.execute(query);
        } catch (SQLException ex) {
            Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void editarPorUsuario(String tabla, String user, String columna, int valor) {
        if (connection == null) {
            createConnection();
        }
        try {
            Statement statement = connection.createStatement();
            String query = "update " + tabla + " set " + columna + " = " + String.valueOf(valor) + " where usuario = '" + user + "'";
            statement.execute(query);
        } catch (SQLException ex) {
            Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static void borrarElemento(String tabla, int idElemento) {
        if (connection == null) {
            createConnection();
        }
        try {
            Statement statement = connection.createStatement();
            String query = "delete from " + tabla + " where id = " + idElemento;
            statement.execute(query);
        } catch (SQLException ex) {
            Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static List<Materia> getMaterias(int idPerfil) {
        List<Materia> materias = new ArrayList<>();
        if (connection == null) {
            createConnection();
        }
        try {
            Statement statement = connection.createStatement();
            String query = "select * from materias where idPerfil = " + idPerfil;
            ResultSet results = statement.executeQuery(query);
            while (results.next()) {
                int id = results.getInt("id");
                String nombre = results.getString("nombre");
                materias.add(new Materia(id, nombre));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return materias;
    }
    /*
    public static void actualizarMateria(Materia materia) {
        try {
            Statement statement = connection.createStatement();
            String query = "update materias set nombre = '" + materia.getNombre() +
                    "' where id = " + materia.getId();
            statement.execute(query);
        } catch (SQLException ex) {
            Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    */
    
    public static int agregarMateria(int idPerfil) {
        int id = -1;
        try {
            Statement statement = connection.createStatement();
            String query;
            query = "insert into materias (nombre, idPerfil) values ('nombre', " + idPerfil + ")";
            statement.execute(query);
            query = "select max(id) as id from materias";
            ResultSet results = statement.executeQuery(query);
            if (results.next()) {
                id = results.getInt("id");
            }
        } catch (SQLException ex) {
            Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return id;
    }
    
    public static List<Categoria> getCategorias(int idMateria) {
        List<Categoria> categorias = new ArrayList<>();
        if (connection == null) {
            createConnection();
        }
        try {
            Statement statement = connection.createStatement();
            String query = "select * from categorias where idMateria = " + idMateria;
            ResultSet results = statement.executeQuery(query);
            while (results.next()) {
                int id = results.getInt("id");
                String nombre = results.getString("nombre");
                categorias.add(new Categoria(id, nombre));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return categorias;
    }
    
    /*
    public static void actualizarCategoria(Categoria categoria) {
        try {
            Statement statement = connection.createStatement();
            String query = "update categorias set nombre = '" + categoria.getNombre() +
                    "' where id = " + categoria.getId();
            statement.execute(query);
        } catch (SQLException ex) {
            Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    */
    
    public static int agregarCategoria(int idMateria) {
        int id = -1;
        try {
            Statement statement = connection.createStatement();
            String query;
            query = "insert into categorias (nombre, idMateria) values ('nombre', " + idMateria + ")";
            statement.execute(query);
            query = "select max(id) as id from categorias";
            ResultSet results = statement.executeQuery(query);
            if (results.next()) {
                id = results.getInt("id");
            }
        } catch (SQLException ex) {
            Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return id;
    }

    public static List<Pregunta> getPreguntas(int idCategoria) {
        List<Pregunta> preguntas = new ArrayList<>();
        if (connection == null) {
            createConnection();
        }
        try {
            Statement statement = connection.createStatement();
            String query = "select * from preguntas where idCategoria = " + idCategoria;
            ResultSet results = statement.executeQuery(query);
            while (results.next()) {
                int id = results.getInt("id");
                String pregunta = results.getString("pregunta");
                String respuesta = results.getString("respuesta");
                int puntos = results.getInt("puntos");
                preguntas.add(new Pregunta(id, pregunta, respuesta, puntos));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return preguntas;
    }
    
    /*
    public static void actualizarPregunta(Pregunta pregunta) {
        try {
            Statement statement = connection.createStatement();
            String query = "update preguntas set pregunta = '" + pregunta.getPregunta() +
                    "', respuesta = '" + pregunta.getRespuesta() +
                    "' where id = " + pregunta.getId();
            statement.execute(query);
        } catch (SQLException ex) {
            Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    */
    
    public static int agregarPregunta(int idCategoria) {
        int id = -1;
        try {
            Statement statement = connection.createStatement();
            String query;
            query = "insert into preguntas (pregunta, respuesta, puntos, idCategoria) "
                    + "values ('pregunta', 'respuesta', 0, " + idCategoria + ")";
            statement.execute(query);
            query = "select max(id) as id from preguntas";
            ResultSet results = statement.executeQuery(query);
            if (results.next()) {
                id = results.getInt("id");
            }
        } catch (SQLException ex) {
            Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        return id;
    }
}
