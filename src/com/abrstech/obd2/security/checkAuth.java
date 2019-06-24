/*    */ package com.abrstech.obd2.security;
/*    */ 
/*    */ public class checkAuth
/*    */ {
/*    */   public boolean isLoggedIn(String IsHuman) 
/*    */   {
/* 46 */     boolean rvalue = false;
/*    */ 
/* 48 */     if ((IsHuman != null) && 
/* 49 */       (IsHuman.equalsIgnoreCase("YES"))) {
/* 50 */       rvalue = true;
/*    */     }
/*    */ 
/* 55 */     return rvalue;
/*    */   }
/*    */ }

/* Location:           /home/bmutia/Development/workspace/ivweb2/src/
 * Qualified Name:     com.abrstech.obd2.security.checkAuth
 * JD-Core Version:    0.6.2
 */