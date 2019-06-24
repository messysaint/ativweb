/*    */ import com.abrstech.obd2.log.CollateObd2Data;
/*    */ import com.abrstech.obd2.log.FindVin;
/*    */ import com.abrstech.obd2.log.LogReaderCSVData;
/*    */ import java.io.IOException;
/*    */ import java.io.PrintStream;
/*    */ import java.util.ArrayList;
/*    */ import java.util.Iterator;
/*    */ 
/*    */ public class testLogReaderCSV
/*    */ {
/*    */   public static void main(String[] args)
/*    */   {
/* 15 */     String parentpath = "/media/FreeAgent GoFlex Drive/BACKUP/Development/i-Vehicle/OBD2Data/";
/*    */ 
/* 21 */     FindVin fvin = new FindVin(parentpath, "kiwitorque");
/* 22 */     String[] logfile = fvin.searchVIN();
/*    */ 
/* 25 */     LogReaderCSVData csv = new LogReaderCSVData();
/* 26 */     CollateObd2Data cod = new CollateObd2Data();
/*    */ 
/* 28 */     String[] headers = null;
/* 29 */     String[] data = null;
/*    */ 
/* 34 */     for (int i = 0; i < logfile.length; i++)
/*    */     {
/*    */       try
/*    */       {
/* 38 */         System.out.println("\n\nAdd >> " + logfile[i] + "\n");
/*    */ 
/* 41 */         csv.readLogFile(logfile[i]);
/*    */ 
/* 43 */         headers = csv.getColumnHeaders();
/* 44 */         data = csv.getRowData();
/*    */ 
/* 48 */         System.out.println("Log Line count: " + csv.getNumberOfLogLines());
/*    */ 
/* 50 */         for (int ii = 0; ii < headers.length; ii++) {
/* 51 */           System.out.println(headers[ii] + " = " + data[ii]);
/*    */         }
/*    */ 
/* 56 */         cod.addOBD2DataHeader(headers, data);
/*    */       }
/*    */       catch (IOException e)
/*    */       {
/* 61 */         e.printStackTrace();
/*    */       }
/*    */ 
/*    */     }
/*    */ 
/* 73 */     ArrayList al = cod.getHeaderOBD2Data();
/* 74 */     ArrayList tmp = null;
/* 75 */     Iterator iter = al.iterator();
/*    */ 
/* 77 */     while (iter.hasNext())
/*    */     {
/* 79 */       tmp = (ArrayList)iter.next();
/*    */ 
/* 81 */       System.out.print((String)tmp.get(0) + ": <" + tmp.size() + "> values = | ");
/*    */ 
/* 84 */       for (int iii = 1; iii != tmp.size(); iii++) {
/* 85 */         System.out.print((String)tmp.get(iii) + " | ");
/*    */       }
/* 87 */       System.out.println(" ");
/*    */     }
/*    */   }
/*    */ }

/* Location:           /home/bmutia/Development/workspace/ivweb2/src/
 * Qualified Name:     testLogReaderCSV
 * JD-Core Version:    0.6.2
 */