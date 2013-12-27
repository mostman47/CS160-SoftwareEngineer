package DataOOD;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author mr.nam
 */
public class PointHistory {

    private int id;
    private String dateTime;
    private int earnedPoint;
    private int usedPoint;
    private int userID;
    private int topicID;

    public PointHistory(int id, String dateTime, int earnedPoint, int usedPoint, int userID, int topicID) {
        this.id = id;
        this.dateTime = dateTime;
        this.earnedPoint = earnedPoint;
        this.usedPoint = usedPoint;
        this.userID = userID;
        this.topicID = topicID;
    }

    public int getTopicID() {
        return topicID;
    }

    public int getId() {
        return id;
    }

    public String getDateTime() {
        return dateTime;
    }

    public int getEarnedPoint() {
        return earnedPoint;
    }

    public int getUsedPoint() {
        return usedPoint;
    }

    public int getUserID() {
        return userID;
    }

    /**
     *
     * @param conn
     * @param i
     * @return
     */
    public static List<PointHistory> doQueryByID(Connection conn, int i) throws SQLException {
        String query = "SELECT * from POINT_HISTORY where USER_ID = " + i;
        return doQuery(conn, query);
    }

    /**
     *
     * @param conn
     * @return
     * @throws SQLException
     */
    public static List<PointHistory> doQueryGetAll(Connection conn) throws SQLException {
        String query = "SELECT * from POINT_HISTORY;";
        return doQuery(conn, query);
    }

    /**
     *
     * @param conn
     * @param query
     * @return
     */
    private static List<PointHistory> doQuery(Connection conn, String query) throws SQLException {
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(query);

        List<PointHistory> list = new ArrayList<>();
        while (rs.next()) {
            int id = rs.getInt("ID");
            int userID = rs.getInt("USER_ID");
            String dateTime = rs.getString("DATETIME");
            int earnP = rs.getInt("POINTEARNED");
            int useP = rs.getInt("POINTUSED");
            int topicID = rs.getInt("TOPIC_ID");
            PointHistory i = new PointHistory(id, dateTime, earnP, useP, userID, topicID);
            list.add(i);
        }
        return list;
    }

    /**
     *
     * @param p
     */
    public static void doQueryInsert(Connection conn,PointHistory p) throws SQLException {
        String query = "INSERT INTO Point_History \n"
                + "			(DateTime\n"
                + "			,PointEarned\n"
                + "			,PointUsed\n"
                + "			,User_ID"
                + "                     ,Topic_ID)\n"
                + "VALUES\n"
        +"('"+p.getDateTime()+"',"+p.getEarnedPoint()+","
                +p.getUsedPoint()+","+p.getUserID()+","+p.getTopicID()+")";
        Statement stmt = conn.createStatement();
        stmt.executeUpdate(query);
        stmt.close();
        System.out.println("Insert into Point History table");

    }

    @Override
    public String toString() {
        return "[id: " + id + "|dateTime: " + dateTime
                + "|earn: " + earnedPoint + "|use: " + usedPoint + "|userID: " + userID + "]";
    }

}
