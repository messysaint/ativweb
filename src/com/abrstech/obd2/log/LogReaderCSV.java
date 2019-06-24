/*     */ package com.abrstech.obd2.log;
/*     */ 
/*     */ import au.com.bytecode.opencsv.CSVReader;
/*     */ import java.io.File;
/*     */ import java.io.FileReader;
/*     */ import java.io.IOException;
/*     */ import java.io.PrintStream;
/*     */ 
/*     */ public class LogReaderCSV
/*     */ {
/*  13 */   static String fileName = null;
/*  14 */   static String myoption = null;
/*     */ 
/*  16 */   private String[] nextLine = null;
/*  17 */   private String[] columnheaders = null;
/*  18 */   private Float[] columntotals = null;
/*  19 */   private Float[] colummnaverages = null;
/*  20 */   private String[] rawdata = null;
/*  21 */   private int headerline = 0;
/*     */ 
/*  23 */   private boolean STORE_DATA = false;
/*     */ 
/*     */   public LogReaderCSV()
/*     */   {
/*     */   }
/*     */ 
/*     */   public LogReaderCSV(boolean storedata)
/*     */   {
/*  31 */     this.STORE_DATA = storedata;
/*     */   }
/*     */ 
/*     */   public String[] getRowData() {
/*  35 */     return this.rawdata;
/*     */   }
/*     */   public String[] getColumnHeaders() {
/*  38 */     return this.columnheaders;
/*     */   }
/*     */ 
/*     */   public Float[] getColumnTotals() {
/*  42 */     return this.columntotals;
/*     */   }
/*     */ 
/*     */   public Float[] getColumnAverages() {
/*  46 */     return this.colummnaverages;
/*     */   }
/*     */ 
/*     */   public int getNumberOfLogLines() {
/*  50 */     return this.headerline;
/*     */   }
/*     */ 
/*     */   public boolean readLogFile(String logname) throws IOException
/*     */   {
/*  55 */     boolean isworking = true;
/*     */ 
/*  57 */     File f = new File(logname);
/*     */ 
/*  59 */     if (f.exists())
/*     */     {
/*  61 */       CSVReader reader = new CSVReader(new FileReader(logname));
/*     */ 
/*  63 */       while ((this.nextLine = reader.readNext()) != null)
/*     */       {
/*  66 */         if (this.headerline == 0) {
/*  67 */           this.columnheaders = this.nextLine;
/*  68 */           this.columntotals = new Float[this.nextLine.length];
/*  69 */           this.colummnaverages = new Float[this.nextLine.length];
/*     */ 
/*  72 */           for (int ii = 0; ii < this.nextLine.length; ii++) {
/*  73 */             this.columntotals[ii] = new Float(0.0D);
/*  74 */             this.colummnaverages[ii] = new Float(0.0D);
/*     */           }
/*     */ 
/*  78 */           for (int i = 0; i < this.columnheaders.length; i++) {
/*  79 */             System.out.println("<<header>> " + this.columnheaders[i]);
/*     */           }
/*     */ 
/*     */         }
/*     */         else
/*     */         {
/*  85 */           for (int ii = 0; ii < this.nextLine.length; ii++)
/*     */           {
/*  87 */             if (checkFloat(this.nextLine[ii]))
/*     */             {
/*     */               int tmp202_200 = ii;
/*     */               Float[] tmp202_197 = this.columntotals; tmp202_197[tmp202_200] = Float.valueOf(tmp202_197[tmp202_200].floatValue() + new Float(this.nextLine[ii]).floatValue());
/*     */             }
/*     */ 
/*     */           }
/*     */ 
/*     */         }
/*     */ 
/*  99 */         this.headerline += 1;
/*     */       }
/*     */ 
/* 103 */       reader.close();
/*     */ 
/* 106 */       for (int ii = 0; ii < this.columntotals.length; ii++) {
/* 107 */         this.colummnaverages[ii] = Float.valueOf(this.columntotals[ii].floatValue() / this.headerline);
/*     */       }
/*     */     }
/*     */     else
/*     */     {
/* 112 */       isworking = false;
/*     */     }
/*     */ 
/* 115 */     return isworking;
/*     */   }
/*     */ 
/*     */   private boolean checkFloat(String num)
/*     */   {
/* 123 */     boolean rvalue = true;
/*     */     try
/*     */     {
/* 126 */       Float.parseFloat(num);
/*     */     } catch (Exception e) {
/* 128 */       rvalue = false;
/*     */     }
/*     */ 
/* 131 */     return rvalue;
/*     */   }
/*     */ }

/* Location:           /home/bmutia/Development/workspace/ivweb2/src/
 * Qualified Name:     com.abrstech.obd2.log.LogReaderCSV
 * JD-Core Version:    0.6.2
 */