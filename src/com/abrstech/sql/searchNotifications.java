/*     */ package com.abrstech.sql;
/*     */ 
/*     */ import java.io.PrintStream;
/*     */ import java.sql.Connection;
/*     */ import java.sql.DriverManager;
/*     */ import java.sql.ResultSet;
/*     */ import java.sql.SQLException;
/*     */ import java.sql.Statement;
/*     */ import java.text.DateFormat;
/*     */ import java.text.SimpleDateFormat;
/*     */ import java.util.ArrayList;
/*     */ import java.util.Date;
/*     */ 
/*     */ public class searchNotifications
/*     */ {
/*  19 */   boolean dbConnectionOk = false;
/*     */ 
/*  21 */   private Connection conn = null;
/*  22 */   private Statement stmt = null;
/*  23 */   private ResultSet rs = null;
/*     */ 
/*  25 */   private String SQLString = null;
/*     */ 
/*  27 */   static String SystemDT = new String();
/*     */ 
/*     */   public searchNotifications()
/*     */   {
/*     */     try
/*     */     {
/*  54 */       Class.forName("com.mysql.jdbc.Driver").newInstance();
/*     */       try
/*     */       {
/*  57 */         this.conn = DriverManager.getConnection("jdbc:mysql://db.santamesa.com/abrstech_obd2db?user=ivwebobd2loguser&password=YuioHjklNm78");
/*  58 */         this.stmt = this.conn.createStatement();
/*  59 */         this.dbConnectionOk = true;
/*  60 */         System.out.println("trackUpload: DB connection is OK");
/*     */       }
/*     */       catch (SQLException ex) {
/*  63 */         System.out.println("trackUpload: SQLException: " + ex.getMessage());
/*  64 */         System.out.println("trackUpload: SQLState: " + ex.getSQLState());
/*  65 */         System.out.println("trackUpload: VendorError: " + ex.getErrorCode());
/*     */       }
/*     */     } catch (Exception ex) {
/*  68 */       System.out.println("trackUpload: SQLException: " + ex.getMessage());
/*     */     }
/*     */   }
/*     */ 
/*     */   public ArrayList getSearchNotifications(String VIN)
/*     */   {
/*  80 */     String SQLStr = null;
/*  81 */     ArrayList paramList = new ArrayList();
/*     */ 
/*  84 */     DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
/*  85 */     Date date = new Date();
/*  86 */     SystemDT = dateFormat.format(date);
/*     */ 
/*  90 */     if (this.dbConnectionOk)
/*     */     {
/*     */       try
/*     */       {
/* 106 */         SQLStr = "Select paramname from abrstech_obd2db.car_obd2_notifications where vin=\"" + VIN + "\"";
/* 107 */         System.out.println(SQLStr);
/* 108 */         this.SQLString = SQLStr;
/*     */ 
/* 110 */         this.rs = this.stmt.executeQuery(SQLStr);
/*     */ 
/* 119 */         while (this.rs.next()) {
/* 120 */           paramList.add(this.rs.getString("paramname"));
/* 121 */           System.out.println(this.rs.getString("paramname"));
/*     */         }
/*     */ 
/*     */       }
/*     */       catch (SQLException ex)
/*     */       {
/* 133 */         System.out.println("SQL: " + SQLStr);
/* 134 */         System.out.println("SQLException: " + ex.getMessage());
/* 135 */         System.out.println("SQLState: " + ex.getSQLState());
/* 136 */         System.out.println("VendorError: " + ex.getErrorCode());
/*     */       }
/*     */ 
/*     */     }
/*     */ 
/* 141 */     return paramList;
/*     */   }
/*     */ 
/*     */   public void CloseDB()
/*     */   {
/* 148 */     if (this.rs != null) {
/*     */       try {
/* 150 */         this.rs.close(); } catch (SQLException localSQLException) {
/*     */       }
/* 152 */       this.rs = null;
/*     */     }
/* 154 */     if (this.stmt != null) {
/*     */       try {
/* 156 */         this.stmt.close(); } catch (SQLException localSQLException1) {
/*     */       }
/* 158 */       this.stmt = null;
/*     */     }
/* 160 */     System.out.println("DB connection is closed");
/*     */   }
/*     */ }

/* Location:           /home/bmutia/Development/workspace/ivweb2/src/
 * Qualified Name:     com.abrstech.sql.searchNotifications
 * JD-Core Version:    0.6.2
 */