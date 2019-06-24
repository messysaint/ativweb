/*     */ package com.abrstech.obd2.log;
/*     */ 
/*     */ import java.util.ArrayList;
/*     */ import java.util.Iterator;
/*     */ 
/*     */ public class CollateObd2Data
/*     */ {
/*  11 */   private ArrayList headerArray = new ArrayList();
/*     */ 
/*     */   public ArrayList getHeaderOBD2Data()
/*     */   {
/*  22 */     return this.headerArray;
/*     */   }
/*     */ 
/*     */   public void addOBD2DataHeader(String[] headernames, Float[] obd2values)
/*     */   {
/*  29 */     for (int i = 0; i < headernames.length; i++)
/*     */     {
/*  33 */       if (this.headerArray.isEmpty())
/*     */       {
/*  35 */         addNewHeader(headernames[i], obd2values[i]);
/*     */       }
/*  40 */       else if (!isHeaderExisting(headernames[i]))
/*     */       {
/*  42 */         addNewHeader(headernames[i], obd2values[i]);
/*     */       }
/*     */       else
/*     */       {
/*  47 */         int index = getHeaderExistingIndex(headernames[i]);
/*     */ 
/*  49 */         addNewDataToExistingHeader(index, obd2values[i]);
/*     */       }
/*     */     }
/*     */   }
/*     */ 
/*     */   public void addOBD2DataHeader(String[] headernames, String[] obd2values)
/*     */   {
/*  63 */     for (int i = 0; i < headernames.length; i++)
/*     */     {
/*  67 */       if (this.headerArray.isEmpty())
/*     */       {
/*  69 */         addNewHeader(headernames[i], obd2values[i]);
/*     */       }
/*  74 */       else if (!isHeaderExisting(headernames[i]))
/*     */       {
/*  76 */         addNewHeader(headernames[i], obd2values[i]);
/*     */       }
/*     */       else
/*     */       {
/*  81 */         int index = getHeaderExistingIndex(headernames[i]);
/*     */ 
/*  83 */         addNewDataToExistingHeader(index, obd2values[i]);
/*     */       }
/*     */     }
/*     */   }
/*     */ 
/*     */   private void addNewDataToExistingHeader(int index, Float data)
/*     */   {
/*  99 */     ((ArrayList)this.headerArray.get(index)).add(data);
/*     */   }
/*     */ 
/*     */   private void addNewDataToExistingHeader(int index, String data)
/*     */   {
/* 109 */     ((ArrayList)this.headerArray.get(index)).add(data);
/*     */   }
/*     */ 
/*     */   private void addNewHeader(String header, Float data)
/*     */   {
/* 120 */     ArrayList headerData = new ArrayList();
/* 121 */     headerData.add(header);
/* 122 */     headerData.add(data);
/*     */ 
/* 125 */     this.headerArray.add(headerData);
/*     */   }
/*     */ 
/*     */   private void addNewHeader(String header, String data)
/*     */   {
/* 136 */     ArrayList headerData = new ArrayList();
/* 137 */     headerData.add(header);
/* 138 */     headerData.add(data);
/*     */ 
/* 141 */     this.headerArray.add(headerData);
/*     */   }
/*     */ 
/*     */   private boolean isHeaderExisting(String head)
/*     */   {
/* 148 */     boolean rvalue = false;
/*     */ 
/* 150 */     Iterator iter = this.headerArray.iterator();
/* 151 */     ArrayList headerArrayItem = null;
/* 152 */     ArrayList headerDataItem = null;
/* 153 */     String headerLabel = null;
/*     */ 
/* 155 */     while (iter.hasNext())
/*     */     {
/* 157 */       headerArrayItem = (ArrayList)iter.next();
/* 158 */       headerLabel = (String)headerArrayItem.get(0);
/*     */ 
/* 161 */       if (headerLabel.equals(head)) {
/* 162 */         rvalue = true;
/* 163 */         break;
/*     */       }
/* 165 */       rvalue = false;
/*     */     }
/*     */ 
/* 177 */     return rvalue;
/*     */   }
/*     */ 
/*     */   private int getHeaderExistingIndex(String head)
/*     */   {
/* 186 */     int rvalue = -1;
/*     */ 
/* 188 */     Iterator iter = this.headerArray.iterator();
/* 189 */     ArrayList headerArrayItem = null;
/* 190 */     ArrayList headerDataItem = null;
/* 191 */     String headerLabel = null;
/*     */ 
/* 193 */     int indexCtr = 0;
/* 194 */     while (iter.hasNext())
/*     */     {
/* 196 */       headerArrayItem = (ArrayList)iter.next();
/* 197 */       headerLabel = (String)headerArrayItem.get(0);
/*     */ 
/* 199 */       if (headerLabel.equals(head)) {
/* 200 */         rvalue = indexCtr;
/* 201 */         break;
/*     */       }
/* 203 */       indexCtr++;
/*     */     }
/*     */ 
/* 206 */     return rvalue;
/*     */   }
/*     */ }

/* Location:           /home/bmutia/Development/workspace/ivweb2/src/
 * Qualified Name:     com.abrstech.obd2.log.CollateObd2Data
 * JD-Core Version:    0.6.2
 */