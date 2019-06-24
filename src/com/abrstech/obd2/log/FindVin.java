/*    */ package com.abrstech.obd2.log;
/*    */ 
/*    */ import java.io.File;
/*    */ import java.io.FilenameFilter;
/*    */ import java.util.Arrays;
/*    */ import java.util.Collections;
/*    */ 
/*    */ public class FindVin
/*    */ {
/* 11 */   private String vin = new String();
/*    */ 
/* 13 */   private static String basedir = "/obd2/vin/";
/*    */ 
/* 84 */   FilenameFilter filter = new FilenameFilter() {
/*    */     public boolean accept(File dir, String name) {
/* 86 */       return name.toLowerCase().endsWith(".csv");
/*    */     }
/* 84 */   };
/*    */ 
/*    */   public FindVin(String v)
/*    */   {
/* 18 */     this.vin = v;
/*    */   }
/*    */ 
/*    */   public FindVin(String base, String v)
/*    */   {
/* 23 */     basedir = base;
/* 24 */     this.vin = v;
/*    */   }
/*    */ 
/*    */   public String[] searchLogs()
/*    */   {
/* 31 */     String[] rvalue = null;
/* 32 */     String[] logFiles = null;
/* 33 */     String fullDirPath = basedir + this.vin;
/* 34 */     File VINdirectory = new File(fullDirPath);
/*    */ 
/* 36 */     if ((VINdirectory.exists()) && 
/* 37 */       (VINdirectory.isDirectory())) {
/* 38 */       logFiles = VINdirectory.list(this.filter);
/* 39 */       rvalue = new String[logFiles.length];
/* 40 */       for (int i = 0; i < logFiles.length; i++) {
/* 41 */         rvalue[i] = (fullDirPath + '/' + logFiles[i]);
/*    */       }
/*    */ 
/*    */     }
/*    */ 
/* 47 */     if (rvalue != null) {
/* 48 */       Arrays.sort(rvalue, Collections.reverseOrder());
/*    */     }
/*    */ 
/* 51 */     return rvalue;
/*    */   }
/*    */ 
/*    */   public String[] searchVIN()
/*    */   {
/* 59 */     String[] rvalue = null;
/* 60 */     String[] logFiles = null;
/* 61 */     String fullDirPath = basedir + this.vin;
/* 62 */     File VINdirectory = new File(fullDirPath);
/*    */ 
/* 64 */     if ((VINdirectory.exists()) && 
/* 65 */       (VINdirectory.isDirectory())) {
/* 66 */       logFiles = VINdirectory.list(this.filter);
/* 67 */       rvalue = new String[logFiles.length];
/* 68 */       for (int i = 0; i < logFiles.length; i++) {
/* 69 */         rvalue[i] = (fullDirPath + '/' + logFiles[i]);
/*    */       }
/*    */ 
/*    */     }
/*    */ 
/* 75 */     if (rvalue != null) {
/* 76 */       Arrays.sort(rvalue, Collections.reverseOrder());
/*    */     }
/*    */ 
/* 79 */     return rvalue;
/*    */   }
/*    */ }

/* Location:           /home/bmutia/Development/workspace/ivweb2/src/
 * Qualified Name:     com.abrstech.obd2.log.FindVin
 * JD-Core Version:    0.6.2
 */