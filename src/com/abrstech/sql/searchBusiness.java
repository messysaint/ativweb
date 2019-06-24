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
/*     */ public class searchBusiness
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
/*  25 */   private int Rseqno = 0;
/*  26 */   private String Rcountry = null;
/*  27 */   private String Rcitytown = null;
/*  27 */   private String Rstate = null;
/*  28 */   private String Rzipcode = null;
/*  29 */   private String Remail = null;
/*  30 */   private String Rbusinessname = null;
/*  31 */   private String Rbusinessdescription = null;
/*  32 */   private String Rwebsite = null;
/*  33 */   private String Rphone = null;
/*  34 */   private String Rreminderquestion = null;
/*  35 */   private String Rreminderanswer = null;
/*  36 */   private String Rservicedzipcodes = null;
/*     */ 
/*     */   public int getSeqno()
/*     */   {
/*  52 */     return this.Rseqno;
/*     */   }
/*     */ 
/*     */   public String getCountry() {
/*  56 */     return this.Rcountry;
/*     */   }
/*     */ 
/*     */   public String getCitytown() {
/*  60 */     return this.Rcitytown;
/*     */   }
/*     */
/*     */   public String getState() {
/*  60 */     return this.Rstate;
/*     */   }


/*     */   public String getZipcode() {
/*  64 */     return this.Rzipcode;
/*     */   }
/*     */ 
/*     */   public String getEmail() {
/*  68 */     return this.Remail;
/*     */   }
/*     */ 
/*     */   public String getBusinessname() {
/*  72 */     return this.Rbusinessname;
/*     */   }
/*     */ 
/*     */   public String getBusinessdescription() {
/*  76 */     return this.Rbusinessdescription;
/*     */   }
/*     */ 
/*     */   public String getWebsite() {
/*  80 */     return this.Rwebsite;
/*     */   }
/*     */ 
/*     */   public String getPhone() {
/*  84 */     return this.Rphone;
/*     */   }
/*     */ 
/*     */   public String getReminderquestion() {
/*  88 */     return this.Rreminderquestion;
/*     */   }
/*     */ 
/*     */   public String getReminderanswer() {
/*  92 */     return this.Rreminderanswer;
/*     */   }
/*     */ 
/*     */   public String getServicedzipcodes() {
/*  96 */     return this.Rservicedzipcodes;
/*     */   }
/*     */ 
/*     */   public String getSQL()
/*     */   {
/* 102 */     return this.SQLString;
/*     */   }
/*     */ 
/*     */   public searchBusiness()
/*     */   {
/*     */     try
/*     */     {
/* 109 */       Class.forName("com.mysql.jdbc.Driver").newInstance();
/*     */       try
/*     */       {
/* 112 */         this.conn = DriverManager.getConnection("jdbc:mysql://db.santamesa.com/abrstech_obd2db?user=ivwebobd2loguser&password=YuioHjklNm78");
/* 113 */         this.stmt = this.conn.createStatement();
/* 114 */         this.dbConnectionOk = true;
/* 115 */         System.out.println("trackUpload: DB connection is OK");
/*     */       }
/*     */       catch (SQLException ex) {
/* 118 */         System.out.println("trackUpload: SQLException: " + ex.getMessage());
/* 119 */         System.out.println("trackUpload: SQLState: " + ex.getSQLState());
/* 120 */         System.out.println("trackUpload: VendorError: " + ex.getErrorCode());
/*     */       }
/*     */     } catch (Exception ex) {
/* 123 */       System.out.println("trackUpload: SQLException: " + ex.getMessage());
/*     */     }
/*     */   }
/*     */ 
/*     */   public boolean isExisting(String country, String email)
/*     */   {
/* 133 */     boolean rvalue = false;
/* 134 */     String SQLStr = null;
/*     */ 
/* 137 */     DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
/* 138 */     Date date = new Date();
/* 139 */     SystemDT = dateFormat.format(date);
/*     */ 
/* 143 */     if (this.dbConnectionOk)
/*     */     {
/*     */       try
/*     */       {
/* 157 */         SQLStr = "SELECT * from abrstech_obd2db.auto_business_tbl where country=\"" + country + "\"  && email=\"" + email + "\"";
/* 158 */         System.out.println(SQLStr);
/* 159 */         this.rs = this.stmt.executeQuery(SQLStr);
/* 160 */         this.SQLString = SQLStr;
/* 161 */         if (this.rs.first()) {
/* 162 */           rvalue = true;
/* 163 */           this.Rcountry = country;
/* 164 */           this.Rseqno = this.rs.getInt("seqno");
/* 165 */           this.Rcitytown = this.rs.getString("citytown");
/* 165 */           this.Rstate = this.rs.getString("state");
/* 166 */           this.Rzipcode = this.rs.getString("zipcode");
/* 167 */           this.Remail = this.rs.getString("email");
/* 168 */           this.Rbusinessname = this.rs.getString("businessname");
/* 169 */           this.Rbusinessdescription = this.rs.getString("businessdescription");
/* 170 */           this.Rwebsite = this.rs.getString("website");
/* 171 */           this.Rphone = this.rs.getString("phone");
/* 172 */           this.Rreminderquestion = this.rs.getString("reminderquestion");
/* 173 */           this.Rreminderanswer = this.rs.getString("reminderanswer");
/* 174 */           this.Rservicedzipcodes = this.rs.getString("servicedzipcodes");
/*     */         } else {
/* 176 */           rvalue = false;
/*     */         }
/*     */       }
/*     */       catch (SQLException ex)
/*     */       {
/* 181 */         System.out.println("SQL: " + SQLStr);
/* 182 */         System.out.println("SQLException: " + ex.getMessage());
/* 183 */         System.out.println("SQLState: " + ex.getSQLState());
/* 184 */         System.out.println("VendorError: " + ex.getErrorCode());
/*     */       }
/*     */ 
/*     */     }
/*     */ 
/* 189 */     return rvalue;
/*     */   }
/*     */ 
/*     */   public boolean isBusSeqNoExisting(int busSeqNo)
/*     */   {
/* 195 */     boolean rvalue = false;
/* 196 */     String SQLStr = null;
/*     */ 
/* 199 */     DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
/* 200 */     Date date = new Date();
/* 201 */     SystemDT = dateFormat.format(date);
/*     */ 
/* 205 */     if (this.dbConnectionOk)
/*     */     {
/*     */       try
/*     */       {
/* 219 */         SQLStr = "SELECT * from abrstech_obd2db.auto_business_tbl where seqno=" + busSeqNo;
/* 220 */         System.out.println(SQLStr);
/* 221 */         this.rs = this.stmt.executeQuery(SQLStr);
/* 222 */         this.SQLString = SQLStr;
/* 223 */         if (this.rs.first()) {
/* 224 */           rvalue = true;
/* 225 */           this.Rcountry = this.rs.getString("country");
/* 226 */           this.Rseqno = this.rs.getInt("seqno");
/* 227 */           this.Rcitytown = this.rs.getString("citytown");
/* 228 */           this.Rzipcode = this.rs.getString("zipcode");
/* 229 */           this.Remail = this.rs.getString("email");
/* 230 */           this.Rbusinessname = this.rs.getString("businessname");
/* 231 */           this.Rbusinessdescription = this.rs.getString("businessdescription");
/* 232 */           this.Rwebsite = this.rs.getString("website");
/* 233 */           this.Rphone = this.rs.getString("phone");
/* 234 */           this.Rreminderquestion = this.rs.getString("reminderquestion");
/* 235 */           this.Rreminderanswer = this.rs.getString("reminderanswer");
/* 236 */           this.Rservicedzipcodes = this.rs.getString("servicedzipcodes");
/*     */         } else {
/* 238 */           rvalue = false;
/*     */         }
/*     */       }
/*     */       catch (SQLException ex)
/*     */       {
/* 243 */         System.out.println("SQL: " + SQLStr);
/* 244 */         System.out.println("SQLException: " + ex.getMessage());
/* 245 */         System.out.println("SQLState: " + ex.getSQLState());
/* 246 */         System.out.println("VendorError: " + ex.getErrorCode());
/*     */       }
/*     */ 
/*     */     }
/*     */ 
/* 251 */     return rvalue;
/*     */   }
/*     */ 
/*     */   public void CloseDB()
/*     */   {
/* 257 */     if (this.rs != null) {
/*     */       try {
/* 259 */         this.rs.close(); } catch (SQLException localSQLException) {
/*     */       }
/* 261 */       this.rs = null;
/*     */     }
/* 263 */     if (this.stmt != null) {
/*     */       try {
/* 265 */         this.stmt.close(); } catch (SQLException localSQLException1) {
/*     */       }
/* 267 */       this.stmt = null;
/*     */     }
/* 269 */     System.out.println("DB connection is closed");
/*     */   }
/*     */ }

/* Location:           /home/bmutia/Development/workspace/ivweb2/src/
 * Qualified Name:     com.abrstech.sql.searchBusiness
 * JD-Core Version:    0.6.2
 */