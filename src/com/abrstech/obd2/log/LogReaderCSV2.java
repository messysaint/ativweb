/*     */ package com.abrstech.obd2.log;
/*     */ 
/*     */ import au.com.bytecode.opencsv.CSVReader;
/*     */ import java.io.File;
/*     */ import java.io.FileReader;
/*     */ import java.io.IOException;
/*     */ import java.io.PrintStream;
/*     */ 
/*     */ public class LogReaderCSV2
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
/*     */   public String[] getRowData()
/*     */   {
/*  30 */     return this.rawdata;
/*     */   }
/*     */   public String[] getColumnHeaders() {
/*  33 */     return this.columnheaders;
/*     */   }
/*     */ 
/*     */   public Float[] getColumnTotals() {
/*  37 */     return this.columntotals;
/*     */   }
/*     */ 
/*     */   public Float[] getColumnAverages() {
/*  41 */     return this.colummnaverages;
/*     */   }
/*     */ 
/*     */   public int getNumberOfLogLines() {
/*  45 */     return this.headerline;
/*     */   }
/*     */ 
/*     */   public boolean readLogFile(String logname) throws IOException
/*     */   {
/*  50 */     boolean isworking = true;
/*     */ 
/*  52 */     File f = new File(logname);
/*     */ 
/*  54 */     if (f.exists())
/*     */     {
/*  56 */       CSVReader reader = new CSVReader(new FileReader(logname));
/*     */ 
/*  58 */       while ((this.nextLine = reader.readNext()) != null)
/*     */       {
/*  61 */         if (this.headerline == 0) {
/*  62 */           this.columnheaders = this.nextLine;
/*  63 */           this.columntotals = new Float[this.nextLine.length];
/*  64 */           this.colummnaverages = new Float[this.nextLine.length];
/*     */ 
/*  67 */           for (int ii = 0; ii < this.nextLine.length; ii++) {
/*  68 */             this.columntotals[ii] = new Float(0.0D);
/*  69 */             this.colummnaverages[ii] = new Float(0.0D);
/*     */           }
/*     */ 
/*  73 */           for (int i = 0; i < this.columnheaders.length; i++) {
/*  74 */             System.out.println("<<header>> " + this.columnheaders[i]);
/*     */           }
/*     */ 
/*     */         }
/*     */         else
/*     */         {
/*  80 */           for (int ii = 0; ii < this.nextLine.length; ii++)
/*     */           {
/*  82 */             if (checkFloat(this.nextLine[ii]))
/*     */             {
/*     */               int tmp202_200 = ii;
/*     */               Float[] tmp202_197 = this.columntotals; tmp202_197[tmp202_200] = Float.valueOf(tmp202_197[tmp202_200].floatValue() + new Float(this.nextLine[ii]).floatValue());
/*     */             }
/*     */ 
/*     */           }
/*     */ 
/*     */         }
/*     */ 
/*  92 */         this.headerline += 1;
/*     */       }
/*     */ 
/*  96 */       reader.close();
/*     */ 
/*  99 */       for (int ii = 0; ii < this.columntotals.length; ii++) {
/* 100 */         this.colummnaverages[ii] = Float.valueOf(this.columntotals[ii].floatValue() / this.headerline);
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
 * Qualified Name:     com.abrstech.obd2.log.LogReaderCSV2
 * JD-Core Version:    0.6.2
 */