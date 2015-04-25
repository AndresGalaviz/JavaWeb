/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Jeopardy;

import java.sql.*;
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
    
    private void createConnection() {
        try {
            //Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost/jeopardy", "root", "");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    
    public static boolean validUser(String usuario, String pw) {
        boolean valido = false;
        System.out.println("entrando a funcion");
        try {            
            if (connection == null) {
                connection = DriverManager.getConnection("jdbc:mysql://localhost/jeopardy", "root", "");
            }
            
            Statement statement = connection.createStatement();
            String query = "select * from perfiles where usuario = '" 
                    + usuario + "' and password = '" + pw + "'";
            ResultSet results = statement.executeQuery(query);
            System.out.println(query);
            while (results.next()) {
                valido = true;
            }
            statement.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(DBhandler.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return valido;
    }
    
   

}
