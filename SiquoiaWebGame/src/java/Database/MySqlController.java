/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Database;

import java.sql.Connection;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Connect to the MySQL database.
 * @author mr.nam
 */
public class MySqlController {
    MySqlConnection conn = new MySqlConnection();

    public MySqlController() {
    }
    /**
     * Connect to the database or return an error.
     * @return 
     */
    public Connection connect() {
        try {
            return conn.connect();
        } catch (Exception ex) {
            Logger.getLogger(MySqlController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

   
    
}
