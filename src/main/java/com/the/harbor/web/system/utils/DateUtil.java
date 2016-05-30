package com.the.harbor.web.system.utils;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;


public class DateUtil {
	/**
     * 格式化日期串
     * @param timestamp
     * @return
     */
    public static String getFormatDate(Date date, String formatStr){
        if(formatStr==null || null==date){
        	return "";
        }else{
        	return new SimpleDateFormat(formatStr).format(date);
        }
    }
    
    /**
     * 字符串转成日期
     * @param dateString
     * @param format
     * @return
     * @throws ParseException
     * @author zhousf
     */
    public static Date getDateFromStringByFormat(String dateString,String format) throws ParseException{
        SimpleDateFormat sdf =   new SimpleDateFormat(format);
        return sdf.parse( dateString);
    }
    
    public static String timstamp3String(Timestamp timestamp){
        if(timestamp==null)
            return "";
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//定义格式，不显示毫秒      
        String str = df.format(timestamp);
        if(str!=null && str.length()>10)
            str = str.substring(0, 10);
        return str;
    }
    
    public static String timetemp2(long time){
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	return sdf.format(time);
    }
    
}
