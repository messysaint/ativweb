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
/*     */ public class saveUpdatedVIN
/*     */ {
/*  15 */   boolean dbConnectionOk = false;
/*     */ 
/*  17 */   private Connection conn = null;
/*  18 */   private Statement stmt = null;
/*  19 */   private ResultSet rs = null;
/*  20 */   static String SystemDT = new String();
/*     */ 
/*     */   public saveUpdatedVIN()
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
/*     */   public boolean WriteToDB(String country, String email, String question, String answer, String vin, String zipcode)
/*     */   {
/*  62 */     boolean rvalue = false;
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
/*  87 */         SQLStr = "UPDATE abrstech_obd2db.ref_car_tbl  SET country = \"" + country + "\", email = \"" + email + "\", question = \"" + question + "\", answer = \"" + answer + "\", zipcode = \"" + zipcode + "\" WHERE vin = \"" + vin + "\"";
/*     */ 
/*  93 */         this.stmt.executeUpdate(SQLStr);
/*  94 */         System.out.println("Ok: " + SQLStr);
/*  95 */         rvalue = true;
/*     */       }
/*     */       catch (SQLException ex)
/*     */       {
/*  99 */         System.out.println("SQLException: " + ex.getMessage());
/* 100 */         System.out.println("SQLState: " + ex.getSQLState());
/* 101 */         System.out.println("VendorError: " + ex.getErrorCode());
/*     */       }
/*     */ 
/*     */     }
/*     */ 
/* 106 */     return rvalue;
/*     */   }
/*     */ 
/*     */   public void CloseDB()
/*     */   {
/* 113 */     if (this.rs != null) {
/*     */       try {
/* 115 */         this.rs.close(); } catch (SQLException localSQLException) {
/*     */       }
/* 117 */       this.rs = null;
/*     */     }
/* 119 */     if (this.stmt != null) {
/*     */       try {
/* 121 */         this.stmt.close(); } catch (SQLException localSQLException1) {
/*     */       }
/* 123 */       this.stmt = null;
/*     */     }
/* 125 */     System.out.println("DB connection is closed");
/*     */   }
/*     */ }

/* Location:           /home/bmutia/Development/workspace/ivweb2/src/
 * Qualified Name:     com.abrstech.sql.saveUpdatedVIN
 * JD-Core Version:    0.6.2
 */