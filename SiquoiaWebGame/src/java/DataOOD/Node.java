/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package DataOOD;

import java.util.ArrayList;
import java.util.List;

/**
 * Node construct tree of Topic
 *
 * @author mr.nam
 */
public class Node<Topic> {

    private Topic data;
    private Node<Topic> parent;
    private List<Node<Topic>> children;
    private int id;

    public Node(int id, Topic data) {
        this.id = id;
        this.data = data;
        parent = null;
        children = new ArrayList<>();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Topic getData() {
        return data;
    }

    public void setData(Topic data) {
        this.data = data;
    }

    public Node<Topic> getParent() {
        return parent;
    }

    public void setParent(Node<Topic> parent) {
        this.parent = parent;
        parent.addChild(this);
    }

    public List<Node<Topic>> getChildren() {
        return children;
    }

    public void setChildren(List<Node<Topic>> children) {
        this.children = children;
    }

    public void addChild(Node<Topic> child) {
        if (children == null) {
            this.children = new ArrayList<>();
        }
        children.add(child);
    }
    /*
     find the node by id
     */

    public Node<Topic> getChildNodeByID(int countTopic) {
        if (id == countTopic) {
            return this;
        } else {
            if (children.isEmpty()) {
                return null;
            } else {
                for (Node<Topic> node : children) {
                    Node<Topic> result = node.getChildNodeByID(countTopic);
                    if (result != null) {
                        return result;
                    }
                }
            }
        }
        return null;
    }
    /*
     get all topic of this node and all children 
     as well as all grand-children untill null
     */

    public List<Topic> getFatherAndAllChildren() {
        List<Topic> list = new ArrayList<>();
        list.add(this.getData());
        List<Node<Topic>> nodeList = this.getChildren();
        if (nodeList == null || nodeList.isEmpty()) {
            return list;
        }
        for (Node<Topic> n : nodeList) {
            list.addAll(n.getFatherAndAllChildren());
        }
        return list;
    }
    /*
     get all topic of this node's children
     */

    public List<Topic> getChildrenOfFather() {
        List<Topic> list = new ArrayList<>();
        for (Node<Topic> n : this.children) {
            list.add(n.getData());
        }
        return list;
    }

    @Override
    public String toString() {
        return "\n" + toString("   ");
    }

    public String toString(String p) {
        String s = "Node{";
        String c = p + "|";
        s += data;
        if (children == null) {
            s += "\n" + c + "_null";
        } else {
            for (Node<Topic> child : children) {
                if (children.indexOf(child) == children.size() - 1) {
                    s += "\n" + c + "_" + child.toString(p + "   ");
                } else {
                    s += "\n" + c + "_" + child.toString(c + " " + "   ");
                }

            }
        }
        s += '}';
        return s;
    }
}
