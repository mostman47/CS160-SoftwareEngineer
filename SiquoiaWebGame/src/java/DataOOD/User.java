/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package DataOOD;

import Miscellanea.EnumValue;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * User Object
 *
 * @author mr.nam
 */
public class User {

    private int id;
    private String name;
    private String password;
    private String type;
    private int point;

    public User(int id, String name, String password, String type, int point) {
        this.id = id;
        this.name = name;
        this.password = password;
        this.type = type;
        this.point = point;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getPoint() {
        return point;
    }

    public void setPoint(int point) {
        this.point = point;
    }

    /**
     *
     * @param conn
     * @param name
     * @param pass
     * @return
     * @throws SQLException
     */
    public static boolean doQueryAddUser(Connection conn, String name, String pass) throws SQLException {
        List<User> list = doQueryGetAll(conn);
        for (User i : list) {
            if (i.getName().trim().equals(name.trim())) {
                return false;
            }
        }
        String query = "Insert into USER (USERNAME, PASSWORD, TYPE, POINT) VALUES"
                + "('" + name + "','" + pass + "','user'," + EnumValue.INITIAL_POINT.getValue() + ");";
        Statement stmt = conn.createStatement();
        System.out.println("Insert into User table");
        stmt.executeUpdate(query);
        stmt.close();
        return true;
    }

    /**
     * MD5 Hash
     *
     * @param md5 string to hash
     * @return
     */
    public static String hashMD5(String md5) {
        try {
            java.security.MessageDigest md = java.security.MessageDigest.getInstance("MD5");
            byte[] array = md.digest(md5.getBytes());
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < array.length; ++i) {
                sb.append(Integer.toHexString((array[i] & 0xFF) | 0x100).substring(1, 3));
            }
            return sb.toString();
        } catch (java.security.NoSuchAlgorithmException e) {
        }
        return null;
    }

    /**
     * Returns a list of all attributes from the user table in the database.
     *
     * @param conn
     * @return
     * @throws SQLException
     */
    public static List<User> doQueryGetAll(Connection conn) throws SQLException {
        String query = "SELECT * from USER;";
        return doQuery(conn, query);

    }

    /**
     *
     * @param conn
     * @param query
     * @return
     * @throws SQLException
     */
    public static List<User> doQuery(Connection conn, String query) throws SQLException {
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(query);

        List<User> list = new ArrayList<>();
        while (rs.next()) {
            int id = rs.getInt("ID");
            String name = rs.getString("USERNAME");
            String password = rs.getString("PASSWORD");
            String type = rs.getString("TYPE");
            int point = rs.getInt("POINT");

            User i = new User(id, name, password, type, point);
            list.add(i);
        }
        return list;
    }

    /**
     *
     * @param user
     */
    public static void doQueryUpdateUser(Connection conn, User user) throws SQLException {
        String query
                = "UPDATE USER\n"
                + "SET\n"
                + "Username = '"+user.getName()+"',\n"
                + "Password = '"+user.getPassword()+"',\n"
                + "Type = '"+user.getType()+"',\n"
                + "Point = "+user.getPoint()+"\n"
                + "WHERE ID = "+user.getId();
        Statement stmt = conn.createStatement();
        stmt.executeUpdate(query);
        stmt.close();
        System.out.println("User " + user.getId() + " is successfully updated");
    }

    /**
     *
     * @param conn
     * @param i
     * @return
     */
    public static User doQueryGetByID(Connection conn, int i) throws SQLException {
        String query = "SELECT * from USER where ID = " + i;
        return doQuery(conn, query).get(0);
    }

    @Override
    public String toString() {
        return "[" + id + "|" + name + " : " + password + ", " + type + ", " + point + "]";
    }
}
