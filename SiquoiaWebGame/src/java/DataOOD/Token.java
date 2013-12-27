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
 *
 * @author mr.nam
 */
public class Token {

    private int topic_ID;
    private int userID;
    private int numberQuestion;
    private String status;
    private String description;
    private String code;
    private int id;

    public Token(int id, String code, String description, String status, int numberQuestion, int userID, int topic_ID) {
        this.id = id;
        this.code = code;
        this.description = description;
        this.status = status;
        this.numberQuestion = numberQuestion;
        this.userID = userID;
        this.topic_ID = topic_ID;
    }

    public int getTopic_ID() {
        return topic_ID;
    }

    public void setTopic_ID(int topic_ID) {
        this.topic_ID = topic_ID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getNumberQuestion() {
        return numberQuestion;
    }

    public void setNumberQuestion(int numberQuestion) {
        this.numberQuestion = numberQuestion;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    /**
     *
     * @param conn
     * @return
     * @throws SQLException
     */
    public static List<Token> doQueryGetAll(Connection conn) throws SQLException {
        String query = "Select * from TOKEN;";
        return doQuery(conn, query);
    }

    /**
     *
     * @param conn
     * @param id
     * @return
     */
    public static List<Token> doQueryByID(Connection conn, int id) throws SQLException {
        String query = "Select * from TOKEN where ID = " + id;
        return doQuery(conn, query);
    }

    /**
     *
     * @param conn
     * @param query
     * @return
     * @throws SQLException
     */
    private static List<Token> doQuery(Connection conn, String query) throws SQLException {
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(query);

        List<Token> list = new ArrayList<>();
        while (rs.next()) {
            int id = rs.getInt("ID");
            String description = rs.getString("DESCRIPTION");
            String code = rs.getString("CODE");
            String status = rs.getString("Status");
            int numberQuestion = rs.getInt("NUMBERQUESTION");
            int userID = rs.getInt("USER_ID");
            int topicID = rs.getInt("TOPIC_ID");
            Token i = new Token(id, code, description, status, numberQuestion, userID, topicID);
            list.add(i);
        }
        return list;
    }

    /**
     *
     * @param conn
     * @param token
     */
    public static void doQueryUpdateToken(Connection conn, Token token) throws SQLException {
        String query = "UPDATE TOKEN\n"
                + "SET\n"
                + "Code = '" + token.getCode() + "',\n"
                + "Description = '" + token.getDescription() + "',\n"
                + "Status = '" + token.getStatus() + "',\n"
                + "NumberQuestion = " + token.getNumberQuestion() + ",\n";
        if (token.getUserID()> 0) {
            query += "User_ID = " + token.getUserID() + ",\n";
        } 
        query += "Topic_ID = " + token.getTopic_ID() + "\n"
                + "WHERE ID = " + token.getId();
        Statement stmt = conn.createStatement();
        stmt.executeUpdate(query);
        stmt.close();
        System.out.println("Token " + token.getId() + " is successfully updated");
    }

    /**
     *
     * @param conn
     * @param code
     * @return
     */
    public static List<Token> doQueryByCode(Connection conn, String code) throws SQLException {
        String query = "Select * from TOKEN where CODE = '" + code + "'";
        return doQuery(conn, query);
    }

    @Override
    public String toString() {
        return "[" + id + "|" + code + "|" + description
                + "|" + status + "|" + numberQuestion + "|"
                + userID + "|" + topic_ID + "]";
    }

}
