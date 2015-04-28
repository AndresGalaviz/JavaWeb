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
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost/jeopardy", "root", "");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    /**
     * recibe un usuario y password, y regresa el id si es valido, o -1 si no lo es
     * @param usuario
     * @param pw
     * @return 
     */
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
    
    /**
     * Crea un nuevo usuario, le asigna una contrasena random y le envia correo
     * @param usuario
     * @param correo
     * @return 
     */
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
    
    /**
     * Regresa la informacion sobre el bloqueo de una cuenta
     * @param usuario
     * @return 
     */
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
    
    /**
     * Le indica si el usuario es nuevo o no
     * @param usuario
     * @return 
     */
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
    
    /**
     * Edita un registro de una tabla
     * @param tabla nombre de la tabla
     * @param idElemento id del renglon a modificar
     * @param columna nombre de la columna a modificar
     * @param valor valor que tomara la columna
     */
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
    
    /**
     * Similar a la funcion anterior pero valor es entero
     * @param tabla
     * @param user
     * @param columna
     * @param valor 
     */
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
    
    /**
     * borra un elemento de una tabla
     * @param tabla tabla a modificar
     * @param idElemento id del renglon a borrar
     */
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
    
    /**
     * obtiene la lista de materias de un perfil
     * @param idPerfil
     * @return 
     */
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
    
    /**
     * Agrega una materia a un perfil
     * @param idPerfil
     * @return 
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
    
    /**
     * Obtiene las categorias de cierta materia
     * @param idMateria
     * @return 
     */
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
    
    /**
     * Agrega una categoria a una materia
     * @param idMateria
     * @return 
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
        /**
     * Obtiene las categorias para cierto id
     * @param idCategoria
     * @param idPregunta
     * @return 
     */
    public static List<Categoria> getCategorias(String[] idCategoria) {
        List<Categoria> categorias = new ArrayList<>();
        if (connection == null) {
            createConnection();
        }
        try {
            Statement statement = connection.createStatement();
            for(String s : idCategoria) {
           
            
            String query = "select * from categorias where id = " + s;
            ResultSet results = statement.executeQuery(query);
            while (results.next()) {
                int id = results.getInt("id");
                String nombre = results.getString("nombre");
                categorias.add(new Categoria(id, nombre));
            }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return categorias;
    }
    /**
     * Obtiene las preguntas para cierta categoria y id
     * @param idCategoria
     * @param idPregunta
     * @return 
     */
    public static List<Pregunta> getPreguntas(String[] idPregunta) {
        List<Pregunta> preguntas = new ArrayList<>();
        if (connection == null) {
            createConnection();
        }
        try {
            Statement statement = connection.createStatement();
            for(String s : idPregunta) {
           
                String query = "select * from preguntas where id = "+s;
                ResultSet results = statement.executeQuery(query);
                while (results.next()) {
                    int id = results.getInt("id");
                    String pregunta = results.getString("pregunta");
                    String respuesta = results.getString("respuesta");
                    int puntos = results.getInt("puntos");
                    int idCategoria = results.getInt("idCategoria");
                    preguntas.add(new Pregunta(id, pregunta, respuesta, puntos, idCategoria));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return preguntas;
    }
    /**
     * Obtiene las preguntas para cierta categoria
     * @param idCategoria
     * @return 
     */
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
                preguntas.add(new Pregunta(id, pregunta, respuesta, puntos, idCategoria));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return preguntas;
    }
    
    /**
     * Agrega una pregunta a una categoria dada
     * @param idCategoria
     * @return 
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
