/*    */ import com.abrstech.obd2.log.CollateObd2Data;
/*    */ import com.abrstech.obd2.util.LogLineValidator;
/*    */ import java.io.PrintStream;
/*    */ import java.util.ArrayList;
/*    */ import java.util.Iterator;
/*    */ 
/*    */ public class testCollateObd2Data
/*    */ {
/*    */   public static void main(String[] args)
/*    */   {
/* 18 */     String data1 = "Catalyst Temperature (Bank 1 Sensor 1)(°F) = T457140.0 A1000.00 | Ambient air temp(°F) = T25787.838 A100.00 ";
/* 19 */     String data2 = "Catalyst Temperature (Bank 1 Sensor 1)(°F) = T493417.0 A2000.00 | Ambient air temp(°F) = T26537.479 A200.00 ";
/*    */ 
/* 23 */     CollateObd2Data cod = new CollateObd2Data();
/*    */ 
/* 25 */     String[] header = null;
/* 26 */     Float[] data = null;
/*    */ 
/* 29 */     System.out.println("\nData 1:");
/* 30 */     LogLineValidator lineVal01 = new LogLineValidator();
/* 31 */     lineVal01.parseDataStringFromDB(data1);
/* 32 */     header = lineVal01.getOBD2HeaderNames();
/* 33 */     data = lineVal01.getOBD2AvgData();
/* 34 */     cod.addOBD2DataHeader(header, data);
/*    */ 
/* 40 */     System.out.println("\nData 2:");
/* 41 */     LogLineValidator lineVal02 = new LogLineValidator();
/* 42 */     lineVal02.parseDataStringFromDB(data2);
/* 43 */     header = lineVal02.getOBD2HeaderNames();
/* 44 */     data = lineVal02.getOBD2AvgData();
/* 45 */     cod.addOBD2DataHeader(header, data);
/*    */ 
/* 56 */     System.out.println("\nShow HTML:");
/* 57 */     ArrayList al = cod.getHeaderOBD2Data();
/* 58 */     ArrayList tmp = null;
/* 59 */     Iterator iter = al.iterator();
/*    */ 
/* 61 */     String displayValue = new String();
/* 62 */     String dataValue = new String();
/*    */ 
/* 64 */     boolean firstRadio = true;
/*    */ 
/* 67 */     while (iter.hasNext())
/*    */     {
/* 69 */       Float total = Float.valueOf(0.0F);
/*    */ 
/* 71 */       tmp = (ArrayList)iter.next();
/*    */ 
/* 73 */       displayValue = (String)tmp.get(0);
/*    */ 
/* 76 */       for (int iii = 1; iii != tmp.size(); iii++) {
/* 77 */         dataValue = dataValue + (Float)tmp.get(iii);
/* 78 */         total = Float.valueOf(total.floatValue() + ((Float)tmp.get(iii)).floatValue());
/* 79 */         if (iii < tmp.size() - 1) {
/* 80 */           dataValue = dataValue + " | ";
/*    */         }
/*    */       }
/*    */ 
/* 84 */       if (firstRadio) {
/* 85 */         firstRadio = false;
/*    */ 
/* 87 */         if (total.floatValue() == 0.0F)
/* 88 */           System.out.println(dataValue + " <disable radio>  [ " + displayValue + " ]");
/*    */         else {
/* 90 */           System.out.println(dataValue + " [ " + displayValue + " ]");
/*    */         }
/*    */ 
/*    */       }
/* 94 */       else if (total.floatValue() == 0.0F) {
/* 95 */         System.out.println(dataValue + " <disable radio> [ " + displayValue + " ]");
/*    */       } else {
/* 97 */         System.out.println(dataValue + " [ " + displayValue + " ]");
/*    */       }
/*    */ 
/* 102 */       dataValue = "";
/*    */     }
/*    */   }
/*    */ }

/* Location:           /home/bmutia/Development/workspace/ivweb2/src/
 * Qualified Name:     testCollateObd2Data
 * JD-Core Version:    0.6.2
 */