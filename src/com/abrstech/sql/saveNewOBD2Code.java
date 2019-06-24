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
/*     */ public class saveNewOBD2Code
/*     */ {
/*  15 */   boolean dbConnectionOk = false;
/*     */ 
/*  17 */   private Connection conn = null;
/*  18 */   private Statement stmt = null;
/*  19 */   private ResultSet rs = null;
/*  20 */   static String SystemDT = new String();
/*     */ 
/*     */   public saveNewOBD2Code()
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
/*     */   public boolean WriteToDB( String obd2code, String  description)
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
/*  86 */        
/*  92 */           SQLStr = "INSERT INTO abrstech_obd2db.ref_obd2code_tbl ( code, description ) VALUES ( \"" + 
/*  93 */             obd2code + "\", \"" + description + "\" )";
/*     */ 
/*  98 */           this.stmt.executeUpdate(SQLStr);
/*  99 */           System.out.println("Ok: " + SQLStr);
/* 100 */           rvalue = true;
/*     */        
/*     */       }
/*     */       catch (SQLException ex)
/*     */       {
/* 107 */         System.out.println("SQLException: " + ex.getMessage());
/* 108 */         System.out.println("SQLState: " + ex.getSQLState());
/* 109 */         System.out.println("VendorError: " + ex.getErrorCode());
/*     */       }
/*     */ 
/*     */     }
/*     */ 
/* 114 */     return rvalue;
/*     */   }
/*     */ 
/*     */   public void CloseDB()
/*     */   {
/* 121 */     if (this.rs != null) {
/*     */       try {
/* 123 */         this.rs.close(); } catch (SQLException localSQLException) {
/*     */       }
/* 125 */       this.rs = null;
/*     */     }
/* 127 */     if (this.stmt != null) {
/*     */       try {
/* 129 */         this.stmt.close(); } catch (SQLException localSQLException1) {
/*     */       }
/* 131 */       this.stmt = null;
/*     */     }
/* 133 */     System.out.println("DB connection is closed");
/*     */   }
/*     */ }

/* Location:           /home/bmutia/Development/workspace/ivweb2/src/
 * Qualified Name:     com.abrstech.sql.saveNewVIN
 * JD-Core Version:    0.6.2
 */