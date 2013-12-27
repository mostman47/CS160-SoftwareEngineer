package Controller;

import DataOOD.Media;
import DataOOD.Node;
import DataOOD.PointHistory;
import DataOOD.Question;
import DataOOD.Quiz;
import DataOOD.QuizHistory;
import DataOOD.Token;
import DataOOD.Topic;
import DataOOD.User;
import Database.MySqlController;
import Miscellanea.EnumString;
import Miscellanea.EnumValue;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Controller controls all request from web pages
 *
 * @author mr.nam
 */
public class Controller {

    private static Connection conn = new MySqlController().connect();
    private static List<User> loginUserList = new ArrayList<User>();
    private static List<Integer> ipList = new ArrayList<Integer>();

    /**
     * get children topics of a topic by its name
     *
     * @param name
     * @return
     */
    public static List<Topic> getSubTopicByName(String name) {
        List<Topic> list = new ArrayList<>();
        try {
            list = Topic.getSubTopicByName(conn, name);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    /**
     * get parent topic of a topic by its name
     *
     * @param name
     * @return
     */
    public static Topic getTopicParentByName(String name) {
        try {
            return Topic.getParentByName(conn, name);
        } catch (SQLException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * generate a tree of Topic's Node
     *
     * @return
     */
    public static Node<Topic> generateNodeTopic() {
        int countTopic = 0;
        Node<Topic> root = new Node(countTopic, new Topic(countTopic, "root"));
        try {
            List<Topic> list = Topic.doQueryGetAll(conn);
            for (Topic t : list) {
                Node<Topic> node = root.getChildNodeByID(t.getParent());
                node.addChild(new Node<Topic>(t.getId(), t));
            }

        } catch (SQLException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
        return root;
    }

    /**
     * get topic by its name
     *
     * @param demo
     * @return
     */
    public static Topic getTopicByName(String demo) {
        try {
            return Topic.doQuerySearchByName(conn, demo);
        } catch (SQLException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * get media by its ID
     *
     * @param id
     * @return
     */
    public static Media getMediaByID(int id) {
        try {
            return Media.doQueryByID(conn, id);
        } catch (SQLException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * generate the Quiz by topic
     *
     * @param topic
     * @return
     */
    public static Quiz generateQuizFromTopic(Topic topic) {
        return generateQuizFromTopic(topic, EnumValue.PACKET_QUESTION_NUMBER.getValue());

    }

    /**
     *
     * @param topic
     * @param numberQuestion
     * @return
     */
    public static Quiz generateQuizFromTopic(Topic topic, int numberQuestion) {
        List<Question> list = new ArrayList<>();
        List<Question> sublist = new ArrayList<>();
        try {
            list = Question.doQueryByTopic(conn, topic);
            while (sublist.size() < numberQuestion
                    && !list.isEmpty()) {
                int random = (int) (Math.random() * list.size());
                sublist.add(list.get(random));
                list.remove(random);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
        return new Quiz(sublist);
    }

    /**
     * get children topics from a topic by its id
     *
     * @param id
     * @return
     */
    public static List<Topic> getSubTopicByID(int id) {
        List<Topic> list = new ArrayList<>();
        try {
            list = Topic.getSubTopicByID(conn, id);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    /**
     * return true if the username and password is in database
     *
     * @param username
     * @param pass
     * @param ip
     * @return
     */
    public static boolean isLogin(String username, String pass, int ip) {
        List<User> list = new ArrayList<>();
        try {
            list = User.doQueryGetAll(conn);
        } catch (SQLException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
        for (User u : list) {
            if (u.getName().equals(username) && u.getPassword().equals(User.hashMD5(pass))) {
                Controller.loginUserList.add(u);
                Controller.ipList.add(ip);
                return true;
            }
        }
        return false;
    }

    /**
     * get user by name and password
     *
     * @param conn
     * @param name
     * @param pass
     * @return
     * @throws SQLException
     */
    public static User login(Connection conn, String name, String pass) throws SQLException {
        List<User> list = User.doQueryGetAll(conn);
        User user = null;
        for (User i : list) {
            if (i.getName().equals(name) && i.getPassword().equals(pass)) {
                user = i;
            }
        }
        return user;
    }

    /**
     * add user to database
     *
     * @param name
     * @param pass
     * @return
     * @throws SQLException
     */
    public static boolean registerUser(String name, String pass) throws SQLException {
        if (User.doQueryAddUser(conn, name, User.hashMD5(pass))) {
            System.out.println("user " + name + " is successfully registered");
            return true;
        } else {
            System.out.println("user " + name + " is already registered");
            return false;
        }
    }

    /**
     *
     * @return
     */
    public static User getLoginUser() {
        if (loginUserList.isEmpty()) {
            return null;
        }
        return loginUserList.get(0);
    }

    /**
     *
     * @param i
     * @return
     */
    public static List<PointHistory> getPointHistoryByUserID(int i) {
        List<PointHistory> list = new ArrayList<>();
        try {
            list = PointHistory.doQueryByID(conn, i);
        } catch (SQLException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    /**
     *
     * @param name
     * @return
     */
    public static boolean logOut(String name) {
        for (User u : loginUserList) {
            if (u.getName().equalsIgnoreCase(name)) {
                loginUserList.remove(u);
                return true;
            }
        }
        return false;
    }

    /**
     *
     * @param topicName
     * @param dateTime
     */
    public static boolean purchase(String topicName, String dateTime) {
        User user = loginUserList.get(0);
        return purchase(user, topicName, dateTime);

    }

    /**
     *
     * @param user
     * @param topicName
     * @param dateTime
     */
    public static boolean purchase(User user, String topicName, String dateTime) {
        int price = EnumValue.PACKET_PRICE_BY_POINT.getValue();
        if (user.getPoint() > price) {

            Topic topic = getTopicByName(topicName);
            //insert purchasehistory by query
            PointHistory p = new PointHistory(0, dateTime, 0, price, user.getId(), topic.getId());
            try {
                PointHistory.doQueryInsert(conn, p);
            } catch (SQLException ex) {
                Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
            }
            //update point of user by query
            user.setPoint(user.getPoint() - price);
            try {
                User.doQueryUpdateUser(conn, user);
            } catch (SQLException ex) {
                Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
            }
            return true;
        }
        return false;
    }

    /**
     *
     * @param topicName
     * @param dateTime
     * @param earnedPoint
     */
    public static void updatePoint(String topicName, String dateTime, int earnedPoint) {
        User user = loginUserList.get(0);
        updatePoint(user, topicName, dateTime, earnedPoint);
    }

    /**
     *
     * @param user
     * @param topicName
     * @param dateTime
     * @param earnedPoint
     */
    public static void updatePoint(User user, String topicName, String dateTime, int earnedPoint) {

        Topic topic = getTopicByName(topicName);
        //insert purchasehistory by query
        PointHistory p = new PointHistory(0, dateTime, earnedPoint, 0, user.getId(), topic.getId());
        try {
            PointHistory.doQueryInsert(conn, p);
        } catch (SQLException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
        //update point of user by query
        user.setPoint(user.getPoint() + earnedPoint);
        try {
            User.doQueryUpdateUser(conn, user);
        } catch (SQLException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    /**
     *
     * @param code
     * @return
     */
    public static boolean isExistedToken(String code) {
        List<Token> list = new ArrayList<>();
        try {
            list = Token.doQueryByCode(conn, code);
        } catch (SQLException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (list.isEmpty()) {
            return false;
        } else {
            return true;
        }
    }

    /**
     *
     * @param code
     * @return
     */
    public static boolean isUsedToken(String code) {
        List<Token> list = new ArrayList<>();
        try {
            list = Token.doQueryByCode(conn, code);
        } catch (SQLException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (list.isEmpty()) {
            return true;
        }
        if (list.get(0).getUserID() > 0
                || list.get(0).getStatus().equalsIgnoreCase(EnumString.USED_TOKEN.getValue())) {
            return true;
        } else {
            return false;
        }
    }

    /**
     *
     * @param aaaa
     * @return
     */
    public static Token getTokenByCode(String code) {
        try {
            return Token.doQueryByCode(conn, code).get(0);
        } catch (SQLException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     *
     * @param token
     * @param userID
     */
    public static void updateTokenToUsed(Token token, int userID) {
        token.setStatus(EnumString.USED_TOKEN.getValue());
        token.setUserID(userID);
        try {
            Token.doQueryUpdateToken(conn, token);
        } catch (SQLException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @param id
     * @return
     */
    public static Topic getTopicByID(int id) {
        try {
            return Topic.getTopicByID(conn, id).getData();
        } catch (SQLException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     *
     * @param user
     */
    public static void updateUser(User user) {
        try {
            User.doQueryUpdateUser(conn, user);
        } catch (SQLException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @param id
     */
    public static void increaseQuestionRanking(int id) {
        try {
            Question q = Question.doQueryGetByID(conn, id);
            q.incrementRanking();
            Question.doQueryUpdateRanking(conn, q);
        } catch (SQLException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @return @throws SQLException
     */
    public static List<Question> getTop10Question() {
        try {
            return Question.doQueryGetTop10(conn);
        } catch (SQLException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
        return new ArrayList<>();
    }

    /**
     *
     * @param quizHistory
     * @return
     */
    public static boolean insertQuizHistory(QuizHistory quizHistory) {
        try {
            QuizHistory.doQueryInsert(conn, quizHistory);
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    /**
     *
     * @param quiz
     * @param topicName
     * @param point
     * @param type
     */
    public static void insertNormalQuizHistory(Quiz quiz, String topicName, int point, String type) {
        int userID = Controller.getLoginUser().getId();
        int topicID = Controller.getTopicByName(topicName).getId();
        int currentQuestion = quiz.getCurrentQuestion().getId();//must be questionID
        List<Question> list = quiz.getQuestionList();
        String questionList = "";
        for (Question q : list) {
            questionList += q.getId() + "|";
        }
        QuizHistory q = new QuizHistory(0, userID, topicID, questionList, currentQuestion, point, type);
        insertQuizHistory(q);
    }

    /**
     *
     * @param quiz
     * @param topicName
     * @param point
     */
    public static void insertNormalQuizHistory(Quiz quiz, String topicName, int point) {
        String type = EnumString.NORMAL_QUIZ.getValue();
        insertNormalQuizHistory(quiz, topicName, point, type);

    }

    /**
     *
     * @param quiz
     * @param topicName
     * @param point
     */
    public static void insertBrandedQuizHistory(Quiz quiz, String topicName, int point) {
        String type = EnumString.BRANDED_QUIZ.getValue();
        insertNormalQuizHistory(quiz, topicName, point, type);

    }

    /**
     *
     * @return
     */
    public static Quiz getNormalQuizFromHistory() {
        return getQuizFromHistory(EnumString.NORMAL_QUIZ.getValue());

    }

    /**
     *
     * @return
     */
    public static Quiz getBrandedQuizFromHistory() {
        return getQuizFromHistory(EnumString.BRANDED_QUIZ.getValue());

    }

    private static Quiz getQuizFromHistory(String type) {
        int userId = Controller.getLoginUser().getId();
        List<QuizHistory> list = new ArrayList<>();
        try {
            list = QuizHistory.doQueryGetByUserID(conn, userId);
        } catch (SQLException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
        QuizHistory quizHistory = null;
        for (QuizHistory q : list) {
            if (q.getType().equalsIgnoreCase(type)) {
                quizHistory = q;
                break;
            }
        }
        if (quizHistory == null) {
            return null;
        } else {
            try {
                //delete QuizHistory
                QuizHistory.doQueryDeleteByID(conn, quizHistory.getId());
            } catch (SQLException ex) {
                Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        String questionL = quizHistory.getQuestionList();
        String[] arr = questionL.split(EnumString.DELIMITER_QUIZHISTORY.getValue());
        List<Question> questionList = new ArrayList<>();
        int index = 0;
        for (int i = 0; i < arr.length; i++) {

            if (arr[i].isEmpty()) {
                break;
            }
            int questionID = Integer.parseInt(arr[i]);
            if (questionID == quizHistory.getCurrent_questionID()) {
                index = i;
            }
            try {
                Question q = Question.doQueryGetByID(conn, questionID);
                questionList.add(q);
            } catch (SQLException ex) {
                Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        Quiz quiz = new Quiz(questionList);
        quiz.setCurrentQuestionIndex(index);
        quiz.setCorrect(quizHistory.getPoint());
        quiz.setTopicID(quizHistory.getTopicID());
        return quiz;
    }

}
