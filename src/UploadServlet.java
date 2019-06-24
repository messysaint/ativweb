/*    */ import com.abrstech.sql.trackUpload;
/*    */ import java.io.File;
/*    */ import java.io.IOException;
/*    */ import java.io.PrintWriter;
/*    */ import java.net.URLDecoder;
/*    */ import java.text.SimpleDateFormat;
/*    */ import java.util.Calendar;
/*    */ import java.util.Iterator;
/*    */ import java.util.List;
/*    */ import javax.servlet.ServletConfig;
/*    */ import javax.servlet.ServletException;
/*    */ import javax.servlet.http.HttpServlet;
/*    */ import javax.servlet.http.HttpServletRequest;
/*    */ import javax.servlet.http.HttpServletResponse;
/*    */ import org.apache.commons.fileupload.FileItem;
/*    */ import org.apache.commons.fileupload.FileItemFactory;
/*    */ import org.apache.commons.fileupload.disk.DiskFileItemFactory;
/*    */ import org.apache.commons.fileupload.servlet.ServletFileUpload;
/*    */ 
/*    */ public class UploadServlet extends HttpServlet
/*    */ {
/*    */   private static final long serialVersionUID = 1L;
/*    */   private static final String BASE_DIRECTORY = "/obd2/vin";
/* 38 */   private String referredby = new String();
/*    */ 
/* 40 */   private String VIN = "novinreceived";
/*    */ 
/* 42 */   private trackUpload track = null;
/*    */ 
/* 44 */   private String tempname = new String();
/*    */ 
/*    */   public void init(ServletConfig config) throws ServletException
/*    */   {
/* 48 */     super.init(config);
/*    */   }
/*    */ 
/*    */   protected void doGet(HttpServletRequest request, HttpServletResponse response)
/*    */     throws ServletException, IOException
/*    */   {
/* 55 */     PrintWriter out = response.getWriter();
/* 56 */     response.setContentType("text/plain");
/* 57 */     out.println("HTTP Get Method is not supported");
/* 58 */     out.close();
/*    */   }
/*    */ 
/*    */   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
/*    */   {
/* 63 */     Calendar currentDate = Calendar.getInstance();
/* 64 */     SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
/* 65 */     String dateNow = formatter.format(currentDate.getTime()).replace('/', '.').replace(':', '.').replace(' ', '_');
/*    */ 
/* 69 */     PrintWriter out = response.getWriter();
/* 70 */     response.setContentType("text/plain");
/*    */ 
/* 72 */     boolean isMultipart = ServletFileUpload.isMultipartContent(request);
/*    */ 
/* 75 */     boolean success = false;
/*    */ 
/* 79 */     if (isMultipart)
/*    */     {
/* 82 */       FileItemFactory factory = new DiskFileItemFactory();
/*    */ 
/* 85 */       ServletFileUpload servletFileUpload = new ServletFileUpload(factory);
/*    */ 
/* 90 */       servletFileUpload.setSizeMax(-1L);
/*    */       try
/*    */       {
/* 94 */         this.referredby = request.getHeader("referer");
/*    */ 
/* 96 */         int vinidx = 0;
/* 97 */         if (this.referredby.contains("vin=")) {
/* 98 */           this.VIN = this.referredby.substring(this.referredby.indexOf("vin=") + 4);
/*    */         }
/*    */ 
/* 103 */         List items = servletFileUpload.parseRequest(request);
/*    */ 
/* 106 */         Iterator iter = items.iterator();
/*    */ 
/* 109 */         if (iter.hasNext())
/*    */         {
/* 111 */           FileItem item = (FileItem)iter.next();
/*    */ 
/* 114 */           String fileName = URLDecoder.decode(item.getName());
/* 115 */           boolean okToUpload = false;
/*    */ 
/* 118 */           if (fileName.toLowerCase().endsWith(".csv")) {
/* 119 */             okToUpload = true;
/*    */           }
/*    */ 
/* 122 */           if (okToUpload)
/*    */           {
/* 124 */             File file = new File(this.VIN, dateNow + "_" + fileName);
/* 125 */             file = new File("/obd2/vin", file.getPath());
/*    */ 
/* 128 */             File parentFile = file.getParentFile();
/*    */ 
/* 130 */             if (parentFile != null) {
/* 131 */               parentFile.mkdirs();
/*    */             }
/*    */ 
/* 135 */             item.write(file);
/*    */ 
/* 138 */             this.tempname = ("/obd2/vin/" + parentFile.getName() + '/' + file.getName());
/*    */ 
/* 140 */             this.track = new trackUpload();
/* 141 */             this.track.WriteToDB(this.tempname);
/* 142 */             this.track.CloseDB();
/*    */           }
/*    */ 
/*    */         }
/*    */ 
/* 151 */         success = true;
/*    */       }
/*    */       catch (Exception e) {
/* 154 */         e.printStackTrace();
/* 155 */         response.setStatus(500);
/* 156 */         out.println("SC_INTERNAL_SERVER_ERROR");
/* 157 */         out.close();
/*    */       }
/*    */ 
/* 160 */       if (success) {
/* 161 */         response.setStatus(200);
/* 162 */         out.println("ok");
/*    */       } else {
/* 164 */         response.setStatus(203);
/* 165 */         out.println("SC_NON_AUTHORITATIVE_INFORMATION");
/*    */       }
/*    */ 
/* 168 */       out.close();
/*    */     }
/*    */     else {
/* 171 */       response.setStatus(400);
/* 172 */       out.println("SC_BAD_REQUEST");
/* 173 */       out.close();
/*    */     }
/*    */   }
/*    */ }

/* Location:           /home/bmutia/Development/workspace/ivweb2/src/
 * Qualified Name:     UploadServlet
 * JD-Core Version:    0.6.2
 */