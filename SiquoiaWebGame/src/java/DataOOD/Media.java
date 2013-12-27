/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DataOOD;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * Media Object
 *
 * @author mr.nam
 */
public class Media {

    private String type;
    private String description;
    private int id;

	/**
	 * Set the media ID, description, and type.
	 */
    public Media(int id, String description, String type) {
        this.id = id;
        this.description = description;
        this.type = type;
    }

	/**
	 * Get the media type.
	 */
    public String getType() {
        return type;
    }

	/**
	 * Get the media description.
	 */
    public String getDescription() {
        return description;
    }

	/**
	 * Get the media ID.
	 */
    public int getId() {
        return id;
    }
	
    /**
     * get all Media in database
     */
    public static List<Media> doQueryGetAll(Connection conn) throws SQLException {
        String query = "SELECT * from MULTIMEDIA;";
        return doQuery(conn, query);

    }

    /**
     * find media by  ID
     */
    public static Media doQueryByID(Connection conn, int id) throws SQLException {
        String query = "SELECT * from MULTIMEDIA where id = " + id + ";";
        return doQuery(conn, query).get(0);
    }

	/**
	 * Get list of media.
	 */
    private static List<Media> doQuery(Connection conn, String query) throws SQLException {
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(query);
        List<Media> list = new ArrayList<>();
        while (rs.next()) {
            int id = rs.getInt("ID");
            String des = rs.getString("DESCRIPTION");
            String type = rs.getString("TYPE");
            Media i = new Media(id, des, type);
            list.add(i);
        }
        return list;
    }

    @Override
    public String toString() {
        return "[Media| id: " + id + "|Description: " + description + "|Type: " + type + "]";
    }
}
