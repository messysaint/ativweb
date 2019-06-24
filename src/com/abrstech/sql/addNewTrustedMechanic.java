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
/*     */ public class addNewTrustedMechanic
/*     */ {
/*  15 */   boolean dbConnectionOk = false;
/*     */ 
/*  17 */   private Connection conn = null;
/*  18 */   private Statement stmt = null;
/*  19 */   private ResultSet rs = null;
/*  20 */   static String SystemDT = new String();
/*     */ 
/*     */   public addNewTrustedMechanic()
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
/*     */   public boolean WriteToDB(String vin, String business_seqno)
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
/*  88 */         SQLStr = "INSERT INTO abrstech_obd2db.car_mechanic_tbl ( datetime, vin, auto_business_seqno ) VALUES ( \"" + 
/*  89 */           SystemDT + "\", \"" + vin + "\", \"" + business_seqno + "\" )";
/*     */ 
/*  91 */         this.stmt.executeUpdate(SQLStr);
/*  92 */         System.out.println("Ok: " + SQLStr);
/*  93 */         rvalue = true;
/*     */       }
/*     */       catch (SQLException ex)
/*     */       {
/* 100 */         System.out.println("SQLException: " + ex.getMessage());
/* 101 */         System.out.println("SQLState: " + ex.getSQLState());
/* 102 */         System.out.println("VendorError: " + ex.getErrorCode());
/*     */       }
/*     */ 
/*     */     }
/*     */ 
/* 107 */     return rvalue;
/*     */   }
/*     */ 
/*     */   public boolean DeleteFromDB(String vin)
/*     */   {
/* 113 */     boolean rvalue = false;
/* 114 */     String SQLStr = null;
/*     */ 
/* 117 */     DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
/* 118 */     Date date = new Date();
/* 119 */     SystemDT = dateFormat.format(date);
/*     */ 
/* 123 */     if (this.dbConnectionOk)
/*     */     {
/*     */       try
/*     */       {
/* 138 */         SQLStr = "DELETE from  abrstech_obd2db.car_mechanic_tbl where vin=\"" + vin + "\"";
/*     */ 
/* 140 */         this.stmt.executeUpdate(SQLStr);
/* 141 */         System.out.println("Ok: " + SQLStr);
/* 142 */         rvalue = true;
/*     */       }
/*     */       catch (SQLException ex)
/*     */       {
/* 146 */         System.out.println("SQLException: " + ex.getMessage());
/* 147 */         System.out.println("SQLState: " + ex.getSQLState());
/* 148 */         System.out.println("VendorError: " + ex.getErrorCode());
/*     */       }
/*     */     }
/*     */ 
/* 152 */     return rvalue;
/*     */   }
/*     */ 
/*     */   public void CloseDB()
/*     */   {
/* 158 */     if (this.rs != null) {
/*     */       try {
/* 160 */         this.rs.close(); } catch (SQLException localSQLException) {
/*     */       }
/* 162 */       this.rs = null;
/*     */     }
/* 164 */     if (this.stmt != null) {
/*     */       try {
/* 166 */         this.stmt.close(); } catch (SQLException localSQLException1) {
/*     */       }
/* 168 */       this.stmt = null;
/*     */     }
/* 170 */     System.out.println("DB connection is closed");
/*     */   }
/*     */ }

/* Location:           /home/bmutia/Development/workspace/ivweb2/src/
 * Qualified Name:     com.abrstech.sql.saveMyTrustedMechanic
 * JD-Core Version:    0.6.2
 */