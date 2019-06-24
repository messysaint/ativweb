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
/*     */ public class saveAutoBusinessMntncOffer
/*     */ {
/*  15 */   boolean dbConnectionOk = false;
/*     */ 
/*  17 */   private Connection conn = null;
/*  18 */   private Statement stmt = null;
/*  19 */   private ResultSet rs = null;
/*  20 */   static String SystemDT = new String();
/*     */ 
/*     */   public saveAutoBusinessMntncOffer()
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
/*     */   public boolean WriteToDB(Integer business_seqno, String car_req_seqno, String vin, String cost, String notes)
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
/*  87 */         SQLStr = "INSERT INTO abrstech_obd2db.auto_business_mtnc_offers_tbl ( datetime, business_seqno, mntnc_request_seqno, vin, cost, notes ) VALUES ( \"" + 
/*  88 */           SystemDT + "\", " + business_seqno + "," + car_req_seqno + ",\"" + vin + "\", " + cost + ",\"" + notes + "\" )";
/*     */ 
/*  93 */         this.stmt.executeUpdate(SQLStr);
/*  94 */         System.out.println("Ok: " + SQLStr);
/*  95 */         rvalue = true;
/*     */       }
/*     */       catch (SQLException ex)
/*     */       {
/* 102 */         System.out.println("Ok: " + SQLStr);
/* 103 */         System.out.println("SQLException: " + ex.getMessage());
/* 104 */         System.out.println("SQLState: " + ex.getSQLState());
/* 105 */         System.out.println("VendorError: " + ex.getErrorCode());
/*     */       }
/*     */ 
/*     */     }
/*     */ 
/* 110 */     return rvalue;
/*     */   }
/*     */ 
/*     */   public void CloseDB()
/*     */   {
/* 117 */     if (this.rs != null) {
/*     */       try {
/* 119 */         this.rs.close(); } catch (SQLException localSQLException) {
/*     */       }
/* 121 */       this.rs = null;
/*     */     }
/* 123 */     if (this.stmt != null) {
/*     */       try {
/* 125 */         this.stmt.close(); } catch (SQLException localSQLException1) {
/*     */       }
/* 127 */       this.stmt = null;
/*     */     }
/* 129 */     System.out.println("DB connection is closed");
/*     */   }
/*     */ }

/* Location:           /home/bmutia/Development/workspace/ivweb2/src/
 * Qualified Name:     com.abrstech.sql.saveAutoBusinessMntncOffer
 * JD-Core Version:    0.6.2
 */