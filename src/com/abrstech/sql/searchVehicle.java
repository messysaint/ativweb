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
/*     */ public class searchVehicle
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
/*  26 */   private String Rvin = null;
/*  27 */   private String Ryear = null;
/*  28 */   private String Rmake = null;
/*  29 */   private String Rmodel = null;
/*  30 */   private String Rtrim = null;
/*  31 */   private String Remail = null;
/*  32 */   private String Rquestion = null;
/*  33 */   private String Ranswer = null;
/*  34 */   private String Rzipcode = null;
/*  35 */   private String Rcountry = null;
/*     */ 
/*     */   public String getVin()
/*     */   {
/*  51 */     return this.Rvin;
/*     */   }
/*     */ 
/*     */   public String getYear() {
/*  55 */     return this.Ryear;
/*     */   }
/*     */ 
/*     */   public String getMake() {
/*  59 */     return this.Rmake;
/*     */   }
/*     */ 
/*     */   public String getModel() {
/*  63 */     return this.Rmodel;
/*     */   }
/*     */ 
/*     */   public String getTrim() {
/*  67 */     return this.Rtrim;
/*     */   }
/*     */ 
/*     */   public String getEmail() {
/*  71 */     return this.Remail;
/*     */   }
/*     */ 
/*     */   public String getQuestion() {
/*  75 */     return this.Rquestion;
/*     */   }
/*     */ 
/*     */   public String getAnswer() {
/*  79 */     return this.Ranswer;
/*     */   }
/*     */ 
/*     */   public String getZipcode() {
/*  83 */     return this.Rzipcode;
/*     */   }
/*     */ 
/*     */   public String getCountry() {
/*  87 */     return this.Rcountry;
/*     */   }
/*     */ 
/*     */   public String getSQL() {
/*  91 */     return this.SQLString;
/*     */   }
/*     */ 
/*     */   public searchVehicle()
/*     */   {
/*     */     try
/*     */     {
/*  98 */       Class.forName("com.mysql.jdbc.Driver").newInstance();
/*     */       try
/*     */       {
/* 101 */         this.conn = DriverManager.getConnection("jdbc:mysql://db.santamesa.com/abrstech_obd2db?user=ivwebobd2loguser&password=YuioHjklNm78");
/* 102 */         this.stmt = this.conn.createStatement();
/* 103 */         this.dbConnectionOk = true;
/* 104 */         System.out.println("trackUpload: DB connection is OK");
/*     */       }
/*     */       catch (SQLException ex) {
/* 107 */         System.out.println("trackUpload: SQLException: " + ex.getMessage());
/* 108 */         System.out.println("trackUpload: SQLState: " + ex.getSQLState());
/* 109 */         System.out.println("trackUpload: VendorError: " + ex.getErrorCode());
/*     */       }
/*     */     } catch (Exception ex) {
/* 112 */       System.out.println("trackUpload: SQLException: " + ex.getMessage());
/*     */     }
/*     */   }
/*     */ 
/*     */   public boolean isExisting(String VIN, String year, String make, String model, String trim)
/*     */   {
/* 122 */     boolean rvalue = false;
/* 123 */     String SQLStr = null;
/*     */ 
/* 126 */     DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
/* 127 */     Date date = new Date();
/* 128 */     SystemDT = dateFormat.format(date);
/*     */ 
/* 132 */     if (this.dbConnectionOk)
/*     */     {
/*     */       try
/*     */       {
/* 146 */         SQLStr = "SELECT * from abrstech_obd2db.ref_car_tbl where vin=\"" + VIN + "\" && year=" + year + " && make=\"" + make + "\" && model=\"" + model + "\"";
/* 147 */         System.out.println(SQLStr);
/* 148 */         this.rs = this.stmt.executeQuery(SQLStr);
/* 149 */         this.SQLString = SQLStr;
/* 150 */         if (this.rs.first()) {
/* 151 */           rvalue = true;
/* 152 */           this.Rvin = VIN;
/* 153 */           this.Ryear = this.rs.getString("year");
/* 154 */           this.Rmake = this.rs.getString("make");
/* 155 */           this.Rmodel = this.rs.getString("model");
/* 156 */           this.Rtrim = this.rs.getString("trim");
/* 157 */           this.Remail = this.rs.getString("email");
/* 158 */           this.Rquestion = this.rs.getString("question");
/* 159 */           this.Ranswer = this.rs.getString("answer");
/* 160 */           this.Rzipcode = this.rs.getString("zipcode");
/* 161 */           this.Rcountry = this.rs.getString("country");
/*     */         } else {
/* 163 */           rvalue = false;
/*     */         }
/*     */       }
/*     */       catch (SQLException ex)
/*     */       {
/* 168 */         System.out.println("SQL: " + SQLStr);
/* 169 */         System.out.println("SQLException: " + ex.getMessage());
/* 170 */         System.out.println("SQLState: " + ex.getSQLState());
/* 171 */         System.out.println("VendorError: " + ex.getErrorCode());
/*     */       }
/*     */ 
/*     */     }
/*     */ 
/* 176 */     return rvalue;
/*     */   }
/*     */ 
/*     */   public boolean isExisting(String VIN)
/*     */   {
/* 185 */     boolean rvalue = false;
/* 186 */     String SQLStr = null;
/*     */ 
/* 189 */     DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
/* 190 */     Date date = new Date();
/* 191 */     SystemDT = dateFormat.format(date);
/*     */ 
/* 195 */     if (this.dbConnectionOk)
/*     */     {
/*     */       try
/*     */       {
/* 209 */         SQLStr = "SELECT * from abrstech_obd2db.ref_car_tbl where vin=\"" + VIN + "\"";
/* 210 */         System.out.println(SQLStr);
/* 211 */         this.rs = this.stmt.executeQuery(SQLStr);
/* 212 */         this.SQLString = SQLStr;
/* 213 */         if (this.rs.first()) {
/* 214 */           rvalue = true;
/* 215 */           this.Rvin = VIN;
/* 216 */           this.Ryear = this.rs.getString("year");
/* 217 */           this.Rmake = this.rs.getString("make");
/* 218 */           this.Rmodel = this.rs.getString("model");
/* 219 */           this.Rtrim = this.rs.getString("trim");
/* 220 */           this.Remail = this.rs.getString("email");
/* 221 */           this.Rquestion = this.rs.getString("question");
/* 222 */           this.Ranswer = this.rs.getString("answer");
/* 223 */           this.Rzipcode = this.rs.getString("zipcode");
/* 224 */           this.Rcountry = this.rs.getString("country");
/*     */         } else {
/* 226 */           rvalue = false;
/*     */         }
/*     */       }
/*     */       catch (SQLException ex)
/*     */       {
/* 231 */         System.out.println("SQL: " + SQLStr);
/* 232 */         System.out.println("SQLException: " + ex.getMessage());
/* 233 */         System.out.println("SQLState: " + ex.getSQLState());
/* 234 */         System.out.println("VendorError: " + ex.getErrorCode());
/*     */       }
/*     */ 
/*     */     }
/*     */ 
/* 239 */     return rvalue;
/*     */   }
/*     */ 


/*     */   public boolean isExistingEmail(String email)
/*     */   {
/* 185 */     boolean rvalue = false;
/* 186 */     String SQLStr = null;
/*     */ 
/* 189 */     DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
/* 190 */     Date date = new Date();
/* 191 */     SystemDT = dateFormat.format(date);
/*     */ 
/* 195 */     if (this.dbConnectionOk)
/*     */     {
/*     */       try
/*     */       {
				  // SELECT vin, question, answer from abrstech_obd2db.ref_car_tbl where email="saintmess@yahoo.com"
/* 209 */         SQLStr = "SELECT vin, question, answer from abrstech_obd2db.ref_car_tbl where email=\"" + email + "\"";
/* 210 */         System.out.println(SQLStr);
/* 211 */         this.rs = this.stmt.executeQuery(SQLStr);
/* 212 */         this.SQLString = SQLStr;
	
				  this.Rvin = new String();
				  this.Rquestion = new String();
				  this.Ranswer = new String();
				  
				  while(this.rs.next()) {
/* 213 */         //if (this.rs.first()) {
/* 214 */           rvalue = true;
					//this.Remail = this.rs.getString("email");
/* 215 */           this.Rvin += this.rs.getString("vin") + " | ";
/* 216 */           //this.Ryear += this.rs.getString("year") + " | ";
/* 217 */           //this.Rmake += this.rs.getString("make") + " | ";
/* 218 */           //this.Rmodel += this.rs.getString("model") + " | ";
/* 219 */           //this.Rtrim += this.rs.getString("trim") + " | ";
/* 221 */           this.Rquestion += this.rs.getString("question") + " | ";
/* 222 */           this.Ranswer += this.rs.getString("answer") + " | ";
/* 223 */           //this.Rzipcode += this.rs.getString("zipcode") + " | ";
/* 224 */           //this.Rcountry += this.rs.getString("country") + " | ";
				  } // end while
/*     */         
				  // System.out.println("this.Rvin: " + this.Rvin);
				  // System.out.println("this.Rquestion " + this.Rquestion);
				  // System.out.println("this.Ranswer " + this.Ranswer);
				  
/*     */       }
/*     */       catch (SQLException ex)
/*     */       {
/* 231 */         System.out.println("SQL: " + SQLStr);
/* 232 */         System.out.println("SQLException: " + ex.getMessage());
/* 233 */         System.out.println("SQLState: " + ex.getSQLState());
/* 234 */         System.out.println("VendorError: " + ex.getErrorCode());
/*     */       }
/*     */ 
/*     */     }
/*     */ 
/* 239 */     return rvalue;
/*     */   }


/*     */   public void CloseDB()
/*     */   {
/* 246 */     if (this.rs != null) {
/*     */       try {
/* 248 */         this.rs.close(); } catch (SQLException localSQLException) {
/*     */       }
/* 250 */       this.rs = null;
/*     */     }
/* 252 */     if (this.stmt != null) {
/*     */       try {
/* 254 */         this.stmt.close(); } catch (SQLException localSQLException1) {
/*     */       }
/* 256 */       this.stmt = null;
/*     */     }
/* 258 */     System.out.println("DB connection is closed");
/*     */   }
/*     */ }

/* Location:           /home/bmutia/Development/workspace/ivweb2/src/
 * Qualified Name:     com.abrstech.sql.searchVehicle
 * JD-Core Version:    0.6.2
 */