/*     */ package com.abrstech.sql;
/*     */ 
/*     */ 
/*     */ import java.sql.Connection;
/*     */ import java.sql.DriverManager;
/*     */ import java.sql.ResultSet;
/*     */ import java.sql.SQLException;
/*     */ import java.sql.Statement;
/*     */ import java.text.DateFormat;
/*     */ import java.text.SimpleDateFormat;
/*     */ import java.util.Date;
/*     */ 
/*     */ public class VINGauges
/*     */ {
/*  15 */   boolean dbConnectionOk = false;
/*     */ 
/*  17 */   private Connection conn = null;
/*  18 */   private Statement stmt = null;
/*  19 */   private ResultSet rs = null;
/*  20 */   static String SystemDT = new String();
/*     */ 


/*  26 */   private String gauge01 = null;
/*  27 */   private String gauge02 = null;
/*  28 */   private String gauge03 = null;
/*  29 */   private String gauge04 = null;
/*  30 */   private String gauge05 = null;
/*  31 */   private String gauge06 = null;
/*     */ 
/*     */   public String getGauge01()
/*     */   {
/*  51 */     return this.gauge01;
/*     */   }
/*     */ 
/*     */   public String getGauge02() {
/*  55 */     return this.gauge02;
/*     */   }
/*     */ 
/*     */   public String getGauge03() {
/*  59 */     return this.gauge03;
/*     */   }
/*     */ 
/*     */   public String getGauge04() {
/*  63 */     return this.gauge04;
/*     */   }
/*     */ 
/*     */   public String getGauge05() {
/*  67 */     return this.gauge05;
/*     */   }
/*     */ 
/*     */   public String getGauge06() {
/*  71 */     return this.gauge06;
/*     */   }
/*     */ 




/*     */   public VINGauges()
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
/*     */   public boolean getMyGauges(String vin)
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
/*  87 */         SQLStr = "SELECT gauge01, gauge02, gauge03, gauge04, gauge05, gauge06 from abrstech_obd2db.ref_car_tbl  WHERE vin = \"" + vin + "\"";
/*     */ 
/*  93 */         this.rs = this.stmt.executeQuery(SQLStr);
/*  94 */         System.out.println("Ok: " + SQLStr);
									  
/* 150 */         if (this.rs.first()) {
/* 151 */           rvalue = true;
/* 153 */           this.gauge01 = this.rs.getString("gauge01");
/* 154 */           this.gauge02 = this.rs.getString("gauge02");
/* 155 */           this.gauge03 = this.rs.getString("gauge03");
/* 156 */           this.gauge04 = this.rs.getString("gauge04");
/* 157 */           this.gauge05 = this.rs.getString("gauge05");
/* 158 */           this.gauge06 = this.rs.getString("gauge06");

					System.out.println("Gauge01: " + gauge01);
					System.out.println("Gauge02: " + gauge02);
					System.out.println("Gauge03: " + gauge03);
					System.out.println("Gauge04: " + gauge04);
					System.out.println("Gauge05: " + gauge05);
					System.out.println("Gauge06: " + gauge06);
					
/*     */         } else {
					rvalue = false;
				  }
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
 * Qualified Name:     com.abrstech.sql.saveUpdateBusinessRecord
 * JD-Core Version:    0.6.2
 */