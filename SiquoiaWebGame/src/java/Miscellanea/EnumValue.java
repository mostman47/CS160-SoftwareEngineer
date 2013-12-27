/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Miscellanea;

/**
 * Enumerated type to store the default number of questions, points, prices, and other values.
 * @author mr.nam
 */
public enum EnumValue {
    PACKET_PRICE_DEFAULTS(10)//
    ,PACKET_QUESTION_NUMBER(20)//
    ,TIME_PER_QUESTION(10)//
    ,TUTORIAL_QUESTION_NUMBER(10)//
    ,INITIAL_POINT(100)//
    ,PACKET_PRICE_BY_POINT(20);//
    
    private int value;
    private EnumValue(int value)
    {
        this.value = value;
    }
    public int getValue()
    {
        return value;
    }
}
