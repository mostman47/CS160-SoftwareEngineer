/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Miscellanea;

/**
 * Enumerated type to store multimedia values for quiz questions.
 * @author mr.nam
 */
public enum EnumString {

    
    VIDEO("video") //
    , IMAGE("image") //
    , AUDIO("audio") //
    , DATETIME_FORMAT("yyyy-MM-dd HH:mm:ss")
    , USED_TOKEN("used")
    , NORMAL_QUIZ("normal")
    , BRANDED_QUIZ("branded")
    , DELIMITER_QUIZHISTORY("\\|")
    ;
    private String s;

    private EnumString(String s) {
        this.s = s;
    }

    public String getValue() {
        return s;
    }
}
