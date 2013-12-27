/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package DataOOD;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/**
 * Quiz Object
 *
 * @author mr.nam
 */
public class Quiz {

    private List<Question> questionList;//list of question after suffle answers
    private int currentQuestionIndex;//index of the current question in the list
    private List<Question> correctQuestionList;//list of question without suffle
    private int total;//total of questions when the quiz is created

    private int correct = 0;
    private int topicID;

    public Quiz(List<Question> questionList) {
        this.total = questionList.size();
        this.correctQuestionList = questionList;
        this.questionList = this.suffleAllAnswer(questionList);
        currentQuestionIndex = 0;
    }


    public int getTopicID() {
        return topicID;
    }

    public void setTopicID(int topicID) {
        this.topicID = topicID;
    }

    public int getCorrect() {
        return correct;
    }

    public void setCorrect(int correct) {
        this.correct = correct;
    }
    

    public void setCurrentQuestionIndex(int currentQuestionIndex) {
        this.currentQuestionIndex = currentQuestionIndex;
    }

    public int getTotal() {
        return total;
    }

    public int getCurrentNumber() {
        return currentQuestionIndex + 1;
    }

    public List<Question> getQuestionList() {
        return questionList;
    }

    public void setQuestionList(List<Question> questionList) {
        this.questionList = questionList;
    }

    /**
     * check if the quiz still has next question
     *
     * @return true if has next
     */
    public boolean hasNext() {
        return currentQuestionIndex < questionList.size() - 1;
    }

    /**
     * Gets the current question from questionList
     * @return the Question in current index
     */
    public Question getCurrentQuestion() {
        return questionList.get(currentQuestionIndex);
    }

    /**
     * Shuffle the order of the answers from the current question
     * @return the Question in current index and shuffles the answer
     */
    public Question getCurrentQuestionRandomShuffle() {
        Question question = questionList.get(currentQuestionIndex);
        String[] set = {question.getCorrectAnswer(), question.getAnswer1(), question.getAnswer2(), question.getAnswer3()};
        shuffleArray(set);
        Question next = new Question(question.getId(), question.getTopicID(), question.getQuestion(), set[0], set[1], set[2], set[3], question.getRanking(), question.getMedia());
        return next;
    }

    /**
     * increase the index
     */
    public void next() {
        currentQuestionIndex++;
    }

    /**
     * check if the answer is correct
     *
     * @param answer
     * @return true if correct
     */
    public boolean isCurrentCorrect(String answer) {
        Question q = correctQuestionList.get(currentQuestionIndex);
        if(q.getCorrectAnswer().toLowerCase().equals(answer.toLowerCase()))
        {
            Controller.Controller.increaseQuestionRanking(q.getId());
            return true;
        }
        return false;
    }

    /**
     * shuffle the array of string Implementing Fisher–Yates shuffle. From
     * http://stackoverflow.com/
     *
     * @param ar
     */
    private void shuffleArray(String[] ar) {
        Random rnd = new Random();
        for (int i = ar.length - 1; i > 0; i--) {
            int index = rnd.nextInt(i + 1);
            // Simple swap
            String a = ar[index];
            ar[index] = ar[i];
            ar[i] = a;
        }
    }

    /**
     * shuffle all answers of the question list
     *
     * @param questionList
     * @return new question list with shuffled answers
     */
    private List<Question> suffleAllAnswer(List<Question> questionList) {
        List<Question> list = new ArrayList<>();
        for (Question q : questionList) {
            String[] set = {q.getCorrectAnswer(), q.getAnswer1(), q.getAnswer2(), q.getAnswer3()};
            shuffleArray(set);
            Question next = new Question(q.getId(), q.getTopicID(), q.getQuestion(), set[0], set[1], set[2], set[3], q.getRanking(), q.getMedia());
            list.add(next);
        }
        return list;
    }

}
