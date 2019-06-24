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
/*     */ import java.util.Date;
/*     */ 
/*     */ public class trackUpload
/*     */ {
/*  15 */   boolean dbConnectionOk = false;
/*     */ 
/*  17 */   private Connection conn = null;
/*  18 */   private Statement stmt = null;
/*  19 */   private ResultSet rs = null;
/*  20 */   static String SystemDT = new String();
/*     */ 
/*     */   public trackUpload()
/*     */   {
/*     */     try
/*     */     {
/*  38 */       Class.forName("com.mysql.jdbc.Driver").newInstance();
/*     */       try
/*     */       {
/*  41 */         this.conn = DriverManager.getConnection("jdbc:mysql://db.santamesa.com/abrstech_obd2db?user=ivwebobd2loguser&password=YuioHjklNm78");
/*  42 */         this.stmt = this.conn.createStatement();
/*  43 */         this.dbConnectionOk = true;
/*  44 */         System.out.println("trackUpload: DB connection is OK");
/*     */       }
/*     */       catch (SQLException ex) {
/*  47 */         System.out.println("trackUpload: SQLException: " + ex.getMessage());
/*  48 */         System.out.println("trackUpload: SQLState: " + ex.getSQLState());
/*  49 */         System.out.println("trackUpload: VendorError: " + ex.getErrorCode());
/*     */       }
/*     */     } catch (Exception ex) {
/*  52 */       System.out.println("trackUpload: SQLException: " + ex.getMessage());
/*     */     }
/*     */   }
/*     */ 
/*     */   public String WriteToDB(String filename)
/*     */   {
/*  62 */     String rvalue = "db connect error";
/*  63 */     String SQLStr = null;
/*     */ 
/*  66 */     DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
/*  67 */     Date date = new Date();
/*  68 */     SystemDT = dateFormat.format(date);
/*     */ 
/*  72 */     if (this.dbConnectionOk)
/*     */     {
/*     */       try
/*     */       {
/*  85 */         SQLStr = "INSERT INTO abrstech_obd2db.uploaded_obd2 ( datetime, filename ) VALUES ( \"" + SystemDT + "\", \"" + filename + "\"  )";
/*     */ 
/*  89 */         rvalue = SQLStr;
/*  90 */         this.stmt.executeUpdate(SQLStr);
/*  91 */         System.out.println("Ok: " + SQLStr);
/*     */       }
/*     */       catch (SQLException ex)
/*     */       {
/*  96 */         System.out.println("SQLException: " + ex.getMessage());
/*  97 */         System.out.println("SQLState: " + ex.getSQLState());
/*  98 */         System.out.println("VendorError: " + ex.getErrorCode());
/*     */       }
/*     */ 
/*     */     }
/*     */ 
/* 103 */     return rvalue;
/*     */   }
/*     */ 
/*     */   public void CloseDB()
/*     */   {
/* 110 */     if (this.rs != null) {
/*     */       try {
/* 112 */         this.rs.close(); } catch (SQLException localSQLException) {
/*     */       }
/* 114 */       this.rs = null;
/*     */     }
/* 116 */     if (this.stmt != null) {
/*     */       try {
/* 118 */         this.stmt.close(); } catch (SQLException localSQLException1) {
/*     */       }
/* 120 */       this.stmt = null;
/*     */     }
/* 122 */     System.out.println("DB connection is closed");
/*     */   }
/*     */ }

/* Location:           /home/bmutia/Development/workspace/ivweb2/src/
 * Qualified Name:     com.abrstech.sql.trackUpload
 * JD-Core Version:    0.6.2
 */