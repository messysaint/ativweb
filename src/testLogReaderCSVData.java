/*    */ import com.abrstech.obd2.log.LogReaderCSVData;
/*    */ import java.io.IOException;
/*    */ import java.io.PrintStream;
/*    */ 
/*    */ public class testLogReaderCSVData
/*    */ {
/*    */   public static void main(String[] args)
/*    */   {
/* 10 */     String parentpath = "/media/FreeAgent GoFlex Drive/BACKUP/Development/i-Vehicle/OBD2Data/Kiwi/";
/* 11 */     String[] logfile = new String[1];
/*    */ 
/* 13 */     logfile[0] = (parentpath + "2012.Jun.22_23.02.50_revExport-361885519.704267.csv");
/*    */ 
/* 15 */     LogReaderCSVData csv = new LogReaderCSVData();
/*    */ 
/* 17 */     String[] headers = null;
/* 18 */     String[] rawData = null;
/*    */ 
/* 23 */     for (int i = 0; i < logfile.length; i++)
/*    */     {
/*    */       try
/*    */       {
/* 27 */         System.out.println("Add >> " + logfile[i] + "\n");
/*    */ 
/* 30 */         csv.readLogFile(logfile[i]);
/*    */ 
/* 32 */         headers = csv.getColumnHeaders();
/*    */ 
/* 34 */         int len = headers.length;
/* 35 */         rawData = new String[len];
/*    */ 
/* 37 */         rawData = csv.getRowData();
/*    */ 
/* 39 */         System.out.println("Log Line count: " + csv.getNumberOfLogLines());
/*    */ 
/* 41 */         int ii = 0; if (ii < len) {
/* 42 */           System.out.println(ii + " >> " + headers[ii] + " = " + rawData[ii].trim());
/*    */         }
/*    */ 
/*    */       }
/*    */       catch (IOException e)
/*    */       {
/* 49 */         e.printStackTrace();
/*    */       }
/*    */     }
/*    */   }
/*    */ }

/* Location:           /home/bmutia/Development/workspace/ivweb2/src/
 * Qualified Name:     testLogReaderCSVData
 * JD-Core Version:    0.6.2
 */