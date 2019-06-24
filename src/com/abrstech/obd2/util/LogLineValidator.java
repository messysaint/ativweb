/*    */ package com.abrstech.obd2.util;
/*    */ 
/*    */ import java.util.StringTokenizer;
/*    */ 
/*    */ public class LogLineValidator
/*    */ {
/*  8 */   static String[] headerNames = null;
/*  9 */   static Float[] averages = null;
/* 10 */   static Float[] totals = null;
/*    */ 
/*    */   public String[] getOBD2HeaderNames()
/*    */   {
/* 16 */     return headerNames;
/*    */   }
/*    */ 
/*    */   public Float[] getOBD2AvgData()
/*    */   {
/* 22 */     return averages;
/*    */   }
/*    */ 
/*    */   public Float[] getOBD2TotalData()
/*    */   {
/* 28 */     return totals;
/*    */   }
/*    */ 
/*    */   public void parseDataStringFromDB(String raw)
/*    */   {
/* 35 */     StringTokenizer paramToken = new StringTokenizer(raw, "|");
/* 36 */     StringTokenizer dataToken = null;
/* 37 */     StringTokenizer tmp = null;
/* 38 */     String header = null;
/*    */ 
/* 40 */     Float total = null;
/* 41 */     Float ave = null;
/*    */ 
/* 43 */     int len = paramToken.countTokens();
/*    */ 
/* 45 */     headerNames = new String[len];
/* 46 */     averages = new Float[len];
/* 47 */     totals = new Float[len];
/*    */ 
/* 49 */     int i = 0;
/* 50 */     while (paramToken.hasMoreTokens()) {
/* 51 */       dataToken = new StringTokenizer(paramToken.nextToken(), "=");
/* 52 */       header = dataToken.nextToken().trim();
/* 53 */       tmp = new StringTokenizer(dataToken.nextToken().trim(), " ");
/* 54 */       total = new Float(tmp.nextToken().substring(1).trim());
/* 55 */       ave = new Float(tmp.nextToken().substring(1).trim());
/* 56 */       headerNames[i] = header;
/* 57 */       totals[i] = total;
/* 58 */       averages[i] = ave;
/* 59 */       i++;
/*    */     }
/*    */   }
/*    */ 
/*    */   public boolean hasOBD2Values(String logLine)
/*    */   {
/* 66 */     boolean rvalue = false;
/* 67 */     char[] s = logLine.toCharArray();
/*    */ 
/* 69 */     for (int i = 0; i < s.length; i++) {
/* 70 */       if ((Character.isDigit(s[i])) && 
/* 71 */         (s[i] != '0'))
/*    */       {
/* 74 */         return true;
/*    */       }
/*    */ 
/*    */     }
/*    */ 
/* 80 */     return rvalue;
/*    */   }
/*    */ }

/* Location:           /home/bmutia/Development/workspace/ivweb2/src/
 * Qualified Name:     com.abrstech.obd2.util.LogLineValidator
 * JD-Core Version:    0.6.2
 */