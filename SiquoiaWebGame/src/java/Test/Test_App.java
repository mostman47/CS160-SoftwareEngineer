/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Test;

import Controller.Controller;
import DataOOD.Node;
import DataOOD.Question;
import DataOOD.Quiz;
import DataOOD.QuizHistory;
import DataOOD.Token;
import DataOOD.Topic;
import DataOOD.User;
import Database.MySqlController;
import Miscellanea.EnumString;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Test the functions of the SiQuoia application; connect to the database,
 * generate packet topic, select topic, generate quiz, login, querying media,
 * security hashing, etc.
 *
 * @author mr.nam
 */
public class Test_App {

    private static Connection conn;

    public static void main(String[] args) {
        MySqlController ctrl = new MySqlController();
        try {
            conn = ctrl.connect();

            testToken();
            testTopic();
            testUser();
            testQuestion();
            testQuizHistory();
            test_other();

            conn.close();

        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    private static void test_SelectTopicAndSubTopic(Connection conn) throws SQLException {
        String message = "-------Command-------\n"
                + "(n) next to subtopic\n"
                + "(s) start the quiz\n"
                + "(e) exit\n"
                + "--------------------\n";
        System.out.println(message);
        List<Topic> list = Topic.getSubTopicByID(conn, 0);
        Scanner sc;
        int n = -1;

        while (true) {
            for (int i = 1; i <= list.size(); i++) {
                System.out.println("(" + i + ")" + list.get(i - 1).getDescription());
            }
            System.out.print(">");
            //read command
            sc = new Scanner(System.in);
            if (sc.hasNextInt()) {
                n = sc.nextInt();
                if (n > list.size()) {
                    System.out.println(">Wrong choice");
                    System.out.println(message);
                    n = -1;
                } else {
                    System.out.println(">" + list.get(n - 1).getDescription() + " is selected");
                }
            } else {
                String s = sc.nextLine().trim();
                if (s.equalsIgnoreCase("n") && n > 0) {
                    System.out.println(">Next to subtopic of " + list.get(n - 1).getDescription() + "\n");
                    List<Topic> tmp = Topic.getSubTopicByID(conn, list.get(n - 1).getId());
                    if (tmp.isEmpty()) {
                        System.out.println(list.get(n - 1).getDescription() + " has no subtopic\n");
                    } else {
                        list = tmp;
                    }
                    n = -1;
                } else if (s.equalsIgnoreCase("s")) {
                    if (n > 0) {
                        System.out.println(">Start quiz of " + list.get(n - 1).getDescription());
                        break;

                    } else {
                        System.out.println(">Error: you need to choose a topic");
                    }
                } else if (s.equalsIgnoreCase("e")) {
                    System.out.println(">Exit");
                    break;
                } else {
                    System.out.println(">Wrong choice");

                    System.out.println(message);
                }
            }
        }
    }

    private static void testGenerateNodeTopic(Connection conn) {
        Node<Topic> root = Controller.generateNodeTopic();
        System.out.println(root.toString());
    }

    private static void test_generateQuiz() {
        Node<Topic> root = Controller.generateNodeTopic();
        Quiz q = Controller.generateQuizFromTopic(root.getChildren().get(2).getData());
        q.next();
        System.out.println(q.getCurrentQuestion());
        System.out.println(q.getCurrentQuestionRandomShuffle());
        q.next();
        System.out.println(q.getCurrentQuestion());
        System.out.println(q.getCurrentQuestionRandomShuffle());
    }

    private static void test_login() {
        System.out.println(Controller.isLogin("user1", "user1", 111));
    }

    private static void test_getMediaByID() {
        System.out.println(Controller.getMediaByID(1).toString());
    }

    private static void test_hashMD5() throws NoSuchAlgorithmException, UnsupportedEncodingException {

        System.out.println(MD5("admin1"));
        System.out.println(MD5("user1"));
        System.out.println(MD5("user2"));

    }

    public static String MD5(String md5) {
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

    private static void test_getCurrentDateTIme(Connection conn) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = new Date();
        System.out.println(dateFormat.format(date));
    }

    private static void testToken() throws SQLException {
        test_checkToken();
        //test_getByCode();
        //test_updateTokenToUsed();

    }

    private static void test_checkToken() throws SQLException {
        String t = "AAAA";
        System.out.println(Controller.isExistedToken(t));
        System.out.println(Controller.isUsedToken(t));
        t = "CCCC";
        System.out.println(Controller.isExistedToken(t));
        System.out.println(Controller.isUsedToken(t));
        t = "DDDD";
        System.out.println(Controller.isExistedToken(t));
        System.out.println(Controller.isUsedToken(t));

    }

    private static void test_getByCode() {
        Token t = Controller.getTokenByCode("AAAA");
        System.out.println(t.toString());
        System.out.println(Controller.getTopicByID(t.getTopic_ID()));
    }

    private static void test_updateTokenToUsed() {
        //guest
        Token t = Controller.getTokenByCode("BBBB");
        Controller.updateTokenToUsed(t, 0);
    }

    private static void testTopic() {
        //test_getTopicbyID();
        //test_SelectTopicAndSubTopic(conn);
        //testGenerateNodeTopic(conn);

    }

    private static void test_getTopicbyID() {
        System.out.println(Controller.getTopicByID(1).toString());

    }

    private static void testUser() throws SQLException {
        //test_updateUser();
        //test_login();
    }

    private static void test_updateUser() throws SQLException {
        User user = User.doQueryGetByID(conn, 2);
        user.setPoint(user.getPoint() + 100);
        Controller.updateUser(user);
    }


    private static void testQuestion() {
        //test_increaseRanking();
        //test_top10();
    }

    private static void test_increaseRanking() {
        Controller.increaseQuestionRanking(23);
    }

    private static void test_top10() {
        List<Question> list = Controller.getTop10Question();
        for (Question q : list) {
            System.out.print("|" + q.getId() + "-" + q.getRanking());
        }
    }

    private static void testQuizHistory() {
        //test_InsertQuizHistory();
        test_getQuizHistoey();
    }

    private static void test_InsertQuizHistory() {
        int userID = 3;
        int topicID = 2;
        int currentQuestion = 26;
        int point = 3;
        String questionList = "2|5|9|15|19|21|25|26|29|31|32|33|35|36|44|48|51|54|58|59";
        QuizHistory q = new QuizHistory(0, userID, topicID, questionList, currentQuestion, point, EnumString.NORMAL_QUIZ.getValue());
        Controller.insertQuizHistory(q);
    }

    private static void test_getQuizHistoey() {
        Quiz q = Controller.getNormalQuizFromHistory();
    }

    private static void test_other() {
        //test_generateQuiz();
        //test_getMediaByID();
        //test_hashMD5();
        //test_getCurrentDateTIme(conn);
    }
}
