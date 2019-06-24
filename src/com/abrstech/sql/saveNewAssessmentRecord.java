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
/*     */ public class saveNewAssessmentRecord
/*     */ {
/*  15 */   boolean dbConnectionOk = false;
/*     */ 
/*  17 */   private Connection conn = null;
/*  18 */   private Statement stmt = null;
/*  19 */   private ResultSet rs = null;
/*  20 */   static String SystemDT = new String();
/*     */ 
/*     */   public saveNewAssessmentRecord()
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
/*     */   public boolean WriteToDB(String ref_car_tbl_seqno, String vin, String cityhighwaympg, String citympg, String highwaympg, String reliabilitydependabilityRating, String reliabilitydependabilityKudos, String reliabilitydependabilityComplaints, String comfortRating, String comfortKudos, String comfortComplaints, String performanceRating, String performanceKudos, String performanceComplaints, String looksRating, String looksKudos, String looksComplaints, String valueRating, String valueKudos, String valueComplaints, String overAllRating, String otherNotes)
/*     */   {
/*  84 */     boolean rvalue = false;
/*  85 */     String SQLStr = null;
/*     */ 
/*  88 */     DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
/*  89 */     Date date = new Date();
/*  90 */     SystemDT = dateFormat.format(date);
/*     */ 
/*  94 */     if (this.dbConnectionOk)
/*     */     {
/*     */       try
/*     */       {
/* 109 */         SQLStr = "INSERT INTO abrstech_obd2db.car_assess_tbl ( datetime, ref_car_tbl_seqno, vin, cityhighwaympg, citympg, highwaympg, reliabilitydependabilityRating, reliabilitydependabilityKudos,  reliabilitydependabilityComplaints,  comfortRating, comfortKudos, comfortComplaints, performanceRating, performanceKudos, performanceComplaints, looksRating, looksKudos, looksComplaints, valueRating, valueKudos, valueComplaints, overAllRating, otherNotes ) VALUES ( \"" + 
/* 110 */           SystemDT + "\", \"" + ref_car_tbl_seqno + "\",\"" + vin + "\",\"" + cityhighwaympg + "\",\"" + citympg + "\",\"" + highwaympg + "\",\"" + reliabilitydependabilityRating + "\",\"" + reliabilitydependabilityKudos + "\",\"" + reliabilitydependabilityComplaints + "\",\"" + comfortRating + "\",\"" + comfortKudos + "\",\"" + comfortComplaints + "\",\"" + performanceRating + "\",\"" + performanceKudos + "\",\"" + performanceComplaints + "\",\"" + looksRating + "\",\"" + looksKudos + "\",\"" + looksComplaints + "\",\"" + valueRating + "\",\"" + valueKudos + "\",\"" + valueComplaints + "\",\"" + overAllRating + "\",\"" + otherNotes + "\" )";
/*     */ 
/* 115 */         this.stmt.executeUpdate(SQLStr);
/* 116 */         System.out.println("Ok: " + SQLStr);
/* 117 */         rvalue = true;
/*     */       }
/*     */       catch (SQLException ex)
/*     */       {
/* 124 */         System.out.println("Ok: " + SQLStr);
/* 125 */         System.out.println("SQLException: " + ex.getMessage());
/* 126 */         System.out.println("SQLState: " + ex.getSQLState());
/* 127 */         System.out.println("VendorError: " + ex.getErrorCode());
/*     */       }
/*     */ 
/*     */     }
/*     */ 
/* 132 */     return rvalue;
/*     */   }
/*     */ 
/*     */   public void CloseDB()
/*     */   {
/* 139 */     if (this.rs != null) {
/*     */       try {
/* 141 */         this.rs.close(); } catch (SQLException localSQLException) {
/*     */       }
/* 143 */       this.rs = null;
/*     */     }
/* 145 */     if (this.stmt != null) {
/*     */       try {
/* 147 */         this.stmt.close(); } catch (SQLException localSQLException1) {
/*     */       }
/* 149 */       this.stmt = null;
/*     */     }
/* 151 */     System.out.println("DB connection is closed");
/*     */   }
/*     */ }

/* Location:           /home/bmutia/Development/workspace/ivweb2/src/
 * Qualified Name:     com.abrstech.sql.saveNewAssessmentRecord
 * JD-Core Version:    0.6.2
 */