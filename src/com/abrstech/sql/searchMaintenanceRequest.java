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
/*     */ public class searchMaintenanceRequest
/*     */ {
/*  15 */   boolean dbConnectionOk = false;
/*     */ 
/*  17 */   private Connection conn = null;
/*  18 */   private Statement stmt = null;
/*  19 */   private ResultSet rs = null;
/*     */ 
/*  21 */   private String SQLString = null;
/*     */ 
/*  23 */   static String SystemDT = new String();
/*     */ 
/*  25 */   private String Rreqno = null;
/*  26 */   private String Rvin = null;
/*  27 */   private String Rcountry = null;
/*  28 */   private String Rzip = null;
/*  29 */   private String Rservicedate = null;
/*  30 */   private String Rcaryear = null;
/*  31 */   private String Rcarmake = null;
/*  32 */   private String Rcarmodel = null;
/*  33 */   private String Rcarodometer = null;
/*  34 */   private String Rservicesrequested = null;
/*  35 */   private String Remail = null;
/*     */ 
/*     */   public String getRequestNo()
/*     */   {
/*  50 */     return this.Rreqno;
/*     */   }
/*     */ 
/*     */   public String getCarVin() {
/*  54 */     return this.Rvin;
/*     */   }
/*     */ 
/*     */   public String getCarCountry() {
/*  58 */     return this.Rcountry;
/*     */   }
/*     */ 
/*     */   public String getCarZip() {
/*  62 */     return this.Rzip;
/*     */   }
/*     */ 
/*     */   public String getCarServiceDate() {
/*  66 */     return this.Rservicedate;
/*     */   }
/*     */ 
/*     */   public String getCarYear() {
/*  70 */     return this.Rcaryear;
/*     */   }
/*     */ 
/*     */   public String getCarMake() {
/*  74 */     return this.Rcarmake;
/*     */   }
/*     */ 
/*     */   public String getCarModel() {
/*  78 */     return this.Rcarmodel;
/*     */   }
/*     */ 
/*     */   public String getCarOdometer() {
/*  82 */     return this.Rcarodometer;
/*     */   }
/*     */ 
/*     */   public String getCarServicesRequested() {
/*  86 */     return this.Rservicesrequested;
/*     */   }
/*     */ 
/*     */   public String getCarEmail() {
/*  90 */     return this.Remail;
/*     */   }
/*     */ 
/*     */   public String getSQL() {
/*  94 */     return this.SQLString;
/*     */   }
/*     */ 
/*     */   public searchMaintenanceRequest()
/*     */   {
/*     */     try
/*     */     {
/* 101 */       Class.forName("com.mysql.jdbc.Driver").newInstance();
/*     */       try
/*     */       {
/* 104 */         this.conn = DriverManager.getConnection("jdbc:mysql://db.santamesa.com/abrstech_obd2db?user=ivwebobd2loguser&password=YuioHjklNm78");
/* 105 */         this.stmt = this.conn.createStatement();
/* 106 */         this.dbConnectionOk = true;
/* 107 */         System.out.println("trackUpload: DB connection is OK");
/*     */       }
/*     */       catch (SQLException ex) {
/* 110 */         System.out.println("trackUpload: SQLException: " + ex.getMessage());
/* 111 */         System.out.println("trackUpload: SQLState: " + ex.getSQLState());
/* 112 */         System.out.println("trackUpload: VendorError: " + ex.getErrorCode());
/*     */       }
/*     */     } catch (Exception ex) {
/* 115 */       System.out.println("trackUpload: SQLException: " + ex.getMessage());
/*     */     }
/*     */   }
/*     */ 
/*     */   public boolean isExisting(String SESSIONCountry, String SESSIONServicedzipcodes, String reqno)
/*     */   {
/* 125 */     boolean rvalue = false;
/* 126 */     String SQLStr = null;
/*     */ 
/* 129 */     DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
/* 130 */     Date date = new Date();
/* 131 */     SystemDT = dateFormat.format(date);
/*     */ 
/* 135 */     if (this.dbConnectionOk)
/*     */     {
/*     */       try
/*     */       {
/* 149 */         SQLStr = "SELECT CAR.country, CAR.year, CAR.make, CAR.model, CAR.email, REQUEST.seqno, REQUEST.vin, REQUEST.currentzipcode, REQUEST.odometer, REQUEST.datetime, REQUEST.servicesrequested  FROM abrstech_obd2db.car_mtnc_request_tbl as REQUEST JOIN (abrstech_obd2db.ref_car_tbl as CAR) ON (REQUEST.vin=CAR.vin) WHERE CAR.country=\"" + 
/* 153 */           SESSIONCountry + "\" and locate( REQUEST.currentzipcode, \"" + SESSIONServicedzipcodes + "\" ) and REQUEST.active=\"y\" and REQUEST.seqno=" + reqno;
/*     */ 
/* 156 */         System.out.println(SQLStr);
/* 157 */         this.rs = this.stmt.executeQuery(SQLStr);
/* 158 */         this.SQLString = SQLStr;
/* 159 */         if (this.rs.first()) {
/* 160 */           rvalue = true;
/*     */ 
/* 162 */           this.Rvin = this.rs.getString("vin");
/* 163 */           this.Rcountry = this.rs.getString("country");
/* 164 */           this.Rzip = this.rs.getString("currentzipcode");
/* 165 */           this.Rservicedate = this.rs.getString("datetime");
/* 166 */           this.Rcaryear = this.rs.getString("year");
/* 167 */           this.Rcarmake = this.rs.getString("make");
/* 168 */           this.Rcarmodel = this.rs.getString("model");
/* 169 */           this.Rcarodometer = this.rs.getString("odometer");
/* 170 */           this.Rservicesrequested = this.rs.getString("servicesrequested");
/* 171 */           this.Remail = this.rs.getString("email");
/*     */         }
/*     */         else {
/* 174 */           rvalue = false;
/*     */         }
/*     */       }
/*     */       catch (SQLException ex)
/*     */       {
/* 179 */         System.out.println("SQL: " + SQLStr);
/* 180 */         System.out.println("SQLException: " + ex.getMessage());
/* 181 */         System.out.println("SQLState: " + ex.getSQLState());
/* 182 */         System.out.println("VendorError: " + ex.getErrorCode());
/*     */       }
/*     */ 
/*     */     }
/*     */ 
/* 187 */     return rvalue;
/*     */   }
/*     */ 
/*     */   public void CloseDB()
/*     */   {
/* 194 */     if (this.rs != null) {
/*     */       try {
/* 196 */         this.rs.close(); } catch (SQLException localSQLException) {
/*     */       }
/* 198 */       this.rs = null;
/*     */     }
/* 200 */     if (this.stmt != null) {
/*     */       try {
/* 202 */         this.stmt.close(); } catch (SQLException localSQLException1) {
/*     */       }
/* 204 */       this.stmt = null;
/*     */     }
/* 206 */     System.out.println("DB connection is closed");
/*     */   }
/*     */ }

/* Location:           /home/bmutia/Development/workspace/ivweb2/src/
 * Qualified Name:     com.abrstech.sql.searchMaintenanceRequest
 * JD-Core Version:    0.6.2
 */