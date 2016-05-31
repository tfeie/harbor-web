package com.the.harbor.web.system.utils;

import java.math.BigDecimal;

public class MathUtil {

    public static BigDecimal divide(long amount, int divisor) {
        return new BigDecimal(amount).divide(new BigDecimal(divisor));
    }

    public static BigDecimal divide(long amount, int divisor, int scale) {
        return divide(amount, divisor).setScale(scale);
    }

    public static BigDecimal divideHalfUp(long amount, int divisor, int scale) {
        return divide(amount, divisor).setScale(scale , BigDecimal.ROUND_HALF_UP);
    }
    
    public static long changeYuanToLi(double yuanAmount){
    	long liAmount = BigDecimal.valueOf(yuanAmount).multiply(new BigDecimal(1000)).longValue();
    	return liAmount;
    }
    public static void main(String[] args) {
		System.out.println(changeYuanToLi(65.10));
	}
    public static long changeYuanToFen(double yuanAmount){
        long fenAmount = BigDecimal.valueOf(yuanAmount).multiply(new BigDecimal(100)).longValue();
        return fenAmount;
    }
    
    public static double changeFenToYuan(long fenAmount){
        double yuanAmount = BigDecimal.valueOf(fenAmount).divide(new BigDecimal(100)).doubleValue();
        return yuanAmount;
    }
    public static double changeLiToYuan(long liAmount){
        double yuanAmount = BigDecimal.valueOf(liAmount).divide(new BigDecimal(1000)).doubleValue();
        return yuanAmount;
    }
}
