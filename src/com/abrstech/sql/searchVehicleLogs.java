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
/*     */ import java.util.ArrayList;
/*     */ import java.util.Date;
/*     */ 
/*     */ public class searchVehicleLogs
/*     */ {
/*  17 */   boolean dbConnectionOk = false;
/*     */ 
/*  19 */   private Connection conn = null;
/*  20 */   private Statement stmt = null;
/*  21 */   private ResultSet rs = null;
/*     */ 
/*  23 */   private String SQLString = null;
/*     */ 
/*  25 */   static String SystemDT = new String();
/*     */ 
/*     */   public searchVehicleLogs()
/*     */   {
/*     */     try
/*     */     {
/*  31 */       Class.forName("com.mysql.jdbc.Driver").newInstance();
/*     */       try
/*     */       {
/*  35 */         this.conn = 
/*  36 */           DriverManager.getConnection("jdbc:mysql://db.santamesa.com/abrstech_obd2db?user=ivwebobd2loguser&password=YuioHjklNm78");
/*  37 */         this.stmt = this.conn.createStatement();
/*  38 */         this.dbConnectionOk = true;
/*  39 */         System.out.println("trackUpload: DB connection is OK");
/*     */       }
/*     */       catch (SQLException ex) {
/*  42 */         System.out.println("trackUpload: SQLException: " + 
/*  43 */           ex.getMessage());
/*  44 */         System.out
/*  45 */           .println("trackUpload: SQLState: " + ex.getSQLState());
/*  46 */         System.out.println("trackUpload: VendorError: " + 
/*  47 */           ex.getErrorCode());
/*     */       }
/*     */     } catch (Exception ex) {
/*  50 */       System.out.println("trackUpload: SQLException: " + ex.getMessage());
/*     */     }
/*     */   }
/*     */ 
/*     */   public String[] getLogNames(String VIN)
/*     */   {
/*  58 */     String[] rvalue = null;
/*  59 */     String SQLStr = null;
/*     */ 
/*  62 */     DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
/*  63 */     Date date = new Date();
/*  64 */     SystemDT = dateFormat.format(date);
/*     */ 
/*  66 */     if (this.dbConnectionOk)
/*     */     {
/*     */       try
/*     */       {
/*  81 */         SQLStr = "SELECT logfilename from abrstech_obd2db.car_trip_sum_tbl where vin=\"" + 
/*  82 */           VIN + "\" order by logfilename desc";
/*  83 */         System.out.println(SQLStr);
/*  84 */         this.rs = this.stmt.executeQuery(SQLStr);
/*  85 */         this.SQLString = SQLStr;
/*     */ 
/*  87 */         ArrayList loglist = new ArrayList();
/*     */ 
/*  89 */         while (this.rs.next()) {
/*  90 */           loglist.add(this.rs.getString("logfilename"));
/*     */         }
/*     */ 
/*  93 */         rvalue = (String[])loglist.toArray(new String[loglist.size()]);
/*     */       }
/*     */       catch (SQLException ex)
/*     */       {
/*  97 */         System.out.println("SQL: " + SQLStr);
/*  98 */         System.out.println("SQLException: " + ex.getMessage());
/*  99 */         System.out.println("SQLState: " + ex.getSQLState());
/* 100 */         System.out.println("VendorError: " + ex.getErrorCode());
/*     */       }
/*     */ 
/*     */     }
/*     */ 
/* 105 */     return rvalue;
/*     */   }
/*     */




/*     */   public String[] getLogNames(String VIN, int count)
/*     */   {
/*  58 */     String[] rvalue = null;
/*  59 */     String SQLStr = null;
/*     */ 
/*  62 */     DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
/*  63 */     Date date = new Date();
/*  64 */     SystemDT = dateFormat.format(date);
/*     */ 
/*  66 */     if (this.dbConnectionOk)
/*     */     {
/*     */       try
/*     */       {
/*  81 */         SQLStr = "SELECT logfilename from abrstech_obd2db.car_trip_sum_tbl where vin=\"" + 
/*  82 */           VIN + "\" order by logfilename desc  LIMIT " + count;
/*  83 */         System.out.println(SQLStr);
/*  84 */         this.rs = this.stmt.executeQuery(SQLStr);
/*  85 */         this.SQLString = SQLStr;
/*     */ 
/*  87 */         ArrayList loglist = new ArrayList();
/*     */ 
/*  89 */         while (this.rs.next()) {
/*  90 */           loglist.add(this.rs.getString("logfilename"));
/*     */         }
/*     */ 
/*  93 */         rvalue = (String[])loglist.toArray(new String[loglist.size()]);
/*     */       }
/*     */       catch (SQLException ex)
/*     */       {
/*  97 */         System.out.println("SQL: " + SQLStr);
/*  98 */         System.out.println("SQLException: " + ex.getMessage());
/*  99 */         System.out.println("SQLState: " + ex.getSQLState());
/* 100 */         System.out.println("VendorError: " + ex.getErrorCode());
/*     */       }
/*     */ 
/*     */     }
/*     */ 
/* 105 */     return rvalue;
/*     */   }







/*     */   public String[] getLogData(String VIN, String[] logNames)
/*     */   {
/* 111 */     String[] rvalue = null;
/* 112 */     String SQLStr = null;
/*     */ 
/* 115 */     DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
/* 116 */     Date date = new Date();
/* 117 */     SystemDT = dateFormat.format(date);
/*     */ 
			  String logs = new String();
			  
			  if( logNames == null ) {
				  logs = " ( \" \" ) ";
			  } else {
				  
				  if( logNames.length > 0 ) {
					  logs = "( ";
					  for (int i = 0; i < logNames.length; i++) {
					  logs = logs + "\"" + logNames[i] + "\", ";
					  }
					  logs = logs.substring(0, logs.length() - 2);
					  logs = logs + " )";
				  } else {
					  logs = " ( \" \" ) ";
				  }
				  
			  }
			  

/*     */ 

/* 130 */     if (this.dbConnectionOk)
/*     */     {
/*     */       try
/*     */       {
/* 145 */         SQLStr = "SELECT datastring from abrstech_obd2db.car_trip_sum_tbl where vin=\"" + 
/* 146 */           VIN + 
/* 147 */           "\" &&  logfilename in " + 
/* 148 */           logs + 
/* 149 */           " order by logfilename asc";
/* 150 */         System.out.println(SQLStr);
/* 151 */         this.rs = this.stmt.executeQuery(SQLStr);
/* 152 */         this.SQLString = SQLStr;
/*     */ 
/* 154 */         ArrayList logDatalist = new ArrayList();
/*     */ 
/* 156 */         while (this.rs.next()) {
/* 157 */           logDatalist.add(this.rs.getString("datastring"));
/*     */         }
/*     */ 
/* 160 */         rvalue = (String[])logDatalist.toArray(
/* 161 */           new String[logDatalist
/* 161 */           .size()]);
/*     */       }
/*     */       catch (SQLException ex)
/*     */       {
/* 165 */         System.out.println("SQL: " + SQLStr);
/* 166 */         System.out.println("SQLException: " + ex.getMessage());
/* 167 */         System.out.println("SQLState: " + ex.getSQLState());
/* 168 */         System.out.println("VendorError: " + ex.getErrorCode());
/*     */       }
/*     */ 
/*     */     }
/*     */ 
/* 173 */     return rvalue;
/*     */   }
/*     */ 
/*     */   public String[] getLogDataLatest(String VIN, int count)
/*     */   {
/* 179 */     String[] rvalue = null;
/* 180 */     String SQLStr = null;
/*     */ 
/* 183 */     DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
/* 184 */     Date date = new Date();
/* 185 */     SystemDT = dateFormat.format(date);
/*     */ 
/* 193 */     if (this.dbConnectionOk)
/*     */     {
/*     */       try
/*     */       {
/* 208 */         SQLStr = "SELECT datastring from abrstech_obd2db.car_trip_sum_tbl where vin=\"" + 
/* 209 */           VIN + 
/* 210 */           "\"" + 
/* 211 */           " order by logfilename asc " + 
/* 212 */           " LIMIT " + count;
/* 213 */         System.out.println(SQLStr);
/* 214 */         this.rs = this.stmt.executeQuery(SQLStr);
/* 215 */         this.SQLString = SQLStr;
/*     */ 
/* 217 */         ArrayList logDatalist = new ArrayList();
/*     */ 
/* 219 */         while (this.rs.next()) {
/* 220 */           logDatalist.add(this.rs.getString("datastring"));
/*     */         }
/*     */ 
/* 223 */         rvalue = (String[])logDatalist.toArray(
/* 224 */           new String[logDatalist
/* 224 */           .size()]);
/*     */       }
/*     */       catch (SQLException ex)
/*     */       {
/* 228 */         System.out.println("SQL: " + SQLStr);
/* 229 */         System.out.println("SQLException: " + ex.getMessage());
/* 230 */         System.out.println("SQLState: " + ex.getSQLState());
/* 231 */         System.out.println("VendorError: " + ex.getErrorCode());
/*     */       }
/*     */ 
/*     */     }
/*     */ 
/* 236 */     return rvalue;
/*     */   }
/*     */ 
/*     */   public void CloseDB()
/*     */   {
/* 242 */     if (this.rs != null) {
/*     */       try {
/* 244 */         this.rs.close();
/*     */       } catch (SQLException localSQLException) {
/*     */       }
/* 247 */       this.rs = null;
/*     */     }
/* 249 */     if (this.stmt != null) {
/*     */       try {
/* 251 */         this.stmt.close();
/*     */       } catch (SQLException localSQLException1) {
/*     */       }
/* 254 */       this.stmt = null;
/*     */     }
/* 256 */     System.out.println("DB connection is closed");
/*     */   }
/*     */ }

/* Location:           /home/bmutia/Development/workspace/ivweb2/src/
 * Qualified Name:     com.abrstech.sql.searchVehicleLogs
 * JD-Core Version:    0.6.2
 */