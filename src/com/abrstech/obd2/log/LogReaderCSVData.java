/*     */ package com.abrstech.obd2.log;
/*     */ 
/*     */ import au.com.bytecode.opencsv.CSVReader;
/*     */ import java.io.File;
/*     */ import java.io.FileReader;
/*     */ import java.io.IOException;
/*     */ 
/*     */ public class LogReaderCSVData
/*     */ {
/*  13 */   static String fileName = null;
/*  14 */   static String myoption = null;
/*     */ 
/*  16 */   private String[] nextLine = null;
/*  17 */   private String[] columnheaders = null;
/*  18 */   private String[] rawdata = null;
/*  19 */   private int headerline = 0;
/*     */ 
/*     */   public String[] getRowData()
/*     */   {
/*  29 */     return this.rawdata;
/*     */   }
/*     */   public String[] getColumnHeaders() {
/*  32 */     return this.columnheaders;
/*     */   }
/*     */ 
/*     */   public int getNumberOfLogLines()
/*     */   {
/*  37 */     return this.headerline;
/*     */   }
/*     */ 
/*     */   public boolean readLogFile(String logname) throws IOException
/*     */   {
/*  42 */     boolean isworking = true;
/*     */ 
/*  44 */     File f = new File(logname);
/*     */ 
/*  46 */     if (f.exists())
/*     */     {
/*  48 */       CSVReader reader = new CSVReader(new FileReader(logname));
/*     */ 
/*  50 */       while ((this.nextLine = reader.readNext()) != null)
/*     */       {
/*  54 */         if (this.headerline == 0) {
/*  55 */           this.columnheaders = this.nextLine;
/*  56 */           this.rawdata = new String[this.nextLine.length];
/*     */ 
/*  59 */           for (int i = 0; i < this.rawdata.length; i++) {
/*  60 */             this.rawdata[i] = " ";
/*     */           }
/*     */ 
/*     */         }
/*     */         else
/*     */         {
/*  67 */           for (int ii = 0; ii < this.nextLine.length; ii++)
/*     */           {
/*  69 */             if (checkFloat(this.nextLine[ii]))
/*     */             {
/*  71 */               if (ii == 0) {
/*  72 */                 this.rawdata[ii] = this.nextLine[ii];
/*     */               }
/*     */               else
/*     */               {
/*     */                 int tmp144_142 = ii;
/*     */                 String[] tmp144_139 = this.rawdata; tmp144_139[tmp144_142] = (tmp144_139[tmp144_142] + " | " + this.nextLine[ii]);
/*     */               }
/*     */ 
/*     */             }
/*     */ 
/*     */           }
/*     */ 
/*     */         }
/*     */ 
/*  88 */         this.headerline += 1;
/*     */       }
/*     */ 
/*  92 */       reader.close();
/*     */ 
/*  95 */       for (int i = 0; i < this.rawdata.length; i++) {
/*  96 */         if (this.rawdata[i].trim().isEmpty())
/*  97 */           this.rawdata[i] = " 0.00";
/*     */         else {
/*  99 */           this.rawdata[i] = this.rawdata[i].trim().substring(1);
/*     */         }
/*     */       }
/*     */     }
/*     */     else
/*     */     {
/* 105 */       isworking = false;
/*     */     }
/*     */ 
/* 108 */     return isworking;
/*     */   }
/*     */ 
/*     */   private boolean checkFloat(String num)
/*     */   {
/* 116 */     boolean rvalue = true;
/*     */     try
/*     */     {
/* 119 */       Float.parseFloat(num);
/*     */     } catch (Exception e) {
/* 121 */       rvalue = false;
/*     */     }
/*     */ 
/* 124 */     return rvalue;
/*     */   }
/*     */ }

/* Location:           /home/bmutia/Development/workspace/ivweb2/src/
 * Qualified Name:     com.abrstech.obd2.log.LogReaderCSVData
 * JD-Core Version:    0.6.2
 */