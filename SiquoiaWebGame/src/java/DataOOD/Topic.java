/*
 * To change this template, choose Tools | Templates
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
 * Topic Object
 *
 * @author mr.nam
 */
public class Topic {

    

    

    private int id;
    private String description;
    private int parent;
    private int level;

    public Topic(int id, String topic) {
        this.id = id;
        this.description = topic;
    }

    public Topic(int id, String topic, int parent) {
        this.id = id;
        this.description = topic;
        this.parent = parent;
    }

    public Topic(int id, String description, int parent, int level) {
        this.id = id;
        this.description = description;
        this.parent = parent;
        this.level = level;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String topic) {
        this.description = topic;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getParent() {
        return parent;
    }

    public void setParent(int parent) {
        this.parent = parent;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    /**
     * get all topics in database
     *
     * @param conn
     * @return
     * @throws SQLException
     */
    public static List<Topic> doQueryGetAll(Connection conn) throws SQLException {
        String query = "SELECT * from TOPIC;";

        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(query);

        List<Topic> list = new ArrayList<>();
        while (rs.next()) {
            int id = rs.getInt("ID");
            String descr = rs.getString("DESCRIPTION");
            int parent_id = rs.getInt("PARENT_ID");
            if (rs.wasNull()) {
                parent_id = 0;
            }
            int level = rs.getInt("LEVEL");

            Topic i = new Topic(id, descr, parent_id, level);
            list.add(i);
        }
        return list;
    }

    /**
     * get topic by name
     *
     * @param conn
     * @param name
     * @return null if not found
     * @throws SQLException
     */
    public static Topic doQuerySearchByName(Connection conn, String name) throws SQLException {
        String query = "SELECT * from TOPIC where DESCRIPTION ='" + name + "';";

        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(query);

        if (rs.next()) {
            int id = rs.getInt("ID");
            String descr = rs.getString("DESCRIPTION");
            int parent_id = rs.getInt("PARENT_ID");
            int level = rs.getInt("LEVEL");

            Topic topic = new Topic(id, descr, parent_id, level);

            return topic;
        }
        return null;
    }
    
    /**
     * get topic by ID
     *
     * @param conn
     * @param i
     * @return null if not found
     * @throws SQLException
     */
    private static Topic doQuerySearchByID(Connection conn, int i) throws SQLException {
        String query = "SELECT * from TOPIC where ID ='" + i + "';";

        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(query);

        if (rs.next()) {
            int id = rs.getInt("ID");
            String descr = rs.getString("DESCRIPTION");
            int parent_id = rs.getInt("PARENT_ID");
            int level = rs.getInt("LEVEL");

            Topic topic = new Topic(id, descr, parent_id, level);

            return topic;
        }
        return null;
    }

    /**
     * create the tree node of topic
     *
     * @param conn
     * @return the root node
     * @throws SQLException
     */
    public static Node<Topic> createRootNode(Connection conn) throws SQLException {
        List<Topic> list = doQueryGetAll(conn);
        Node<Topic> root = new Node<Topic>(0, new Topic(0, "root", 0, 0));
        try {
            for (Topic t : list) {
                int parent_id = t.getParent();
                Node<Topic> node = root.getChildNodeByID(parent_id);
                node.addChild(new Node<Topic>(t.getId(), t));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return root;

    }

    /**
     * get the topic and all its sub-topic by its ID
     *
     * @param conn
     * @param id
     * @return
     * @throws SQLException
     */
    public static List<Topic> getTopicAndAllSubTopicByID(Connection conn, int id) throws SQLException {
        Node<Topic> root = createRootNode(conn);
        root = root.getChildNodeByID(id);
        List<Topic> list = root.getFatherAndAllChildren();
        return list;

    }

    /**
     * get all its sub topics by its ID
     *
     * @param conn
     * @param id
     * @return
     * @throws SQLException
     */
    public static List<Topic> getSubTopicByID(Connection conn, int id) throws SQLException {
        Node<Topic> root = createRootNode(conn);
        root = root.getChildNodeByID(id);
        List<Topic> list = root.getChildrenOfFather();
        return list;
    }

    /**
     * get all its sub topics by its name
     *
     * @param conn
     * @param name
     * @return
     * @throws SQLException
     */
    public static List<Topic> getSubTopicByName(Connection conn, String name) throws SQLException {
        Node<Topic> root = createRootNode(conn);
        Topic topic = Topic.doQuerySearchByName(conn, name);
        root = root.getChildNodeByID(topic.getId());
        List<Topic> list = root.getChildrenOfFather();
        return list;
    }

    /**
     * get its up-topic by its name
     *
     * @param conn
     * @param name
     * @return
     * @throws SQLException
     */
    public static Topic getParentByName(Connection conn, String name) throws SQLException {
        Topic topic = Topic.doQuerySearchByName(conn, name);
        if (topic.parent > 0) {
            topic = Topic.doQuerySearchByID(conn, topic.getParent());
            return topic;
        }
        return null;
    }
    /**
     * 
     * @param conn
     * @param id
     * @return 
     */
    public static Node<Topic> getTopicByID(Connection conn, int id) throws SQLException {
        Node<Topic> root = createRootNode(conn);
        return root.getChildNodeByID(id);
    }
    @Override
    public String toString() {
        return "[(id : " + id + "),(topic : " + description
                + "),(parent : " + parent + "),(level : " + level + ")]";
    }
    /**
     * 
     * @return 
     */
    String toSimpleString() {
        return description;
    }
}
