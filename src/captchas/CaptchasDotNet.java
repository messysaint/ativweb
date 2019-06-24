/*     */ package captchas;
/*     */ 
/*     */ import java.security.MessageDigest;
/*     */ import java.security.NoSuchAlgorithmException;
/*     */ import java.util.Random;
/*     */ import javax.servlet.http.HttpSession;
/*     */ 
/*     */ public class CaptchasDotNet
/*     */ {
/*     */   private String client;
/*     */   private String secret;
/*  29 */   final String ALPHABET_RECOMMENDED = "abcdefghkmnopqrstuvwxyz";
/*     */ 
/*  31 */   final String ALPHABET_DEFAULT = "abcdefghijklmnopqrstuvwxyz";
/*  32 */   final int LETTERS_DEFAULT = 6;
/*  33 */   final int WIDTH_DEFAULT = 240;
/*  34 */   final int HEIGHT_DEFAULT = 80;
/*  35 */   private String alphabet = "abcdefghkmnopqrstuvwxyz";
/*  36 */   private int letters = 6;
/*  37 */   private int width = 240;
/*  38 */   private int height = 80;
/*     */   private HttpSession httpSess;
/*  42 */   private String captchaRandom = "";
/*     */ 
/*     */   public CaptchasDotNet(HttpSession httpSess, String client, String secret)
/*     */   {
/*  51 */     this.httpSess = httpSess;
/*  52 */     this.client = client;
/*  53 */     this.secret = secret;
/*     */   }
/*     */ 
/*     */   public CaptchasDotNet(HttpSession httpSess, String client, String secret, String alphabet, int letters)
/*     */   {
/*  61 */     this.httpSess = httpSess;
/*  62 */     this.client = client;
/*  63 */     this.secret = secret;
/*  64 */     this.alphabet = alphabet;
/*  65 */     this.letters = letters;
/*  66 */     this.width = this.width;
/*  67 */     this.height = this.height;
/*     */   }
/*     */ 
/*     */   public CaptchasDotNet(HttpSession httpSess, String client, String secret, String alphabet, int letters, int width, int height)
/*     */   {
/*  77 */     this.httpSess = httpSess;
/*  78 */     this.client = client;
/*  79 */     this.secret = secret;
/*  80 */     this.alphabet = alphabet;
/*  81 */     this.letters = letters;
/*  82 */     this.width = width;
/*  83 */     this.height = height;
/*     */   }
/*     */ 
/*     */   private String randomString()
/*     */   {
/*  94 */     Random r = new Random();
/*  95 */     this.captchaRandom = (Integer.toHexString(r.nextInt()) + Integer.toHexString(r.nextInt()));
/*  96 */     this.httpSess.setAttribute("captchasDotNetRandom", this.captchaRandom);
/*  97 */     return this.captchaRandom;
/*     */   }
/*     */ 
/*     */   public String imageUrl()
/*     */   {
/* 105 */     if ((this.captchaRandom == "") || (this.captchaRandom == "used")) {
/* 106 */       this.captchaRandom = randomString();
/*     */     }
/* 108 */     String url = "http://image.captchas.net/";
/*     */ 
/* 110 */     url = url + "?client=" + this.client;
/* 111 */     url = url + "&random=" + this.captchaRandom;
/*     */ 
/* 113 */     if (!this.alphabet.equals("abcdefghijklmnopqrstuvwxyz")) {
/* 114 */       url = url + "&alphabet=" + this.alphabet;
/*     */     }
/* 116 */     if (this.letters != 6) {
/* 117 */       url = url + "&letters=" + this.letters;
/*     */     }
/* 119 */     if (this.width != 240) {
/* 120 */       url = url + "&width=" + this.width;
/*     */     }
/* 122 */     if (this.height != 80) {
/* 123 */       url = url + "&height=" + this.height;
/*     */     }
/* 125 */     return url;
/*     */   }
/*     */ 
/*     */   public String imageUrl(String randomString) {
/* 129 */     this.captchaRandom = randomString;
/* 130 */     this.httpSess.setAttribute("captchasDotNetRandom", this.captchaRandom);
/* 131 */     return imageUrl();
/*     */   }
/*     */ 
/*     */   public String audioUrl()
/*     */   {
/* 139 */     if ((this.captchaRandom == "") || (this.captchaRandom == "used")) {
/* 140 */       this.captchaRandom = randomString();
/*     */     }
/* 142 */     String url = "http://audio.captchas.net/";
/* 143 */     url = url + "?client=" + this.client;
/* 144 */     url = url + "&random=" + this.captchaRandom;
/* 145 */     if (!this.alphabet.equals("abcdefghijklmnopqrstuvwxyz")) {
/* 146 */       url = url + "&alphabet=" + this.alphabet;
/*     */     }
/* 148 */     if (this.letters != 6) {
/* 149 */       url = url + "&letters=" + this.letters;
/*     */     }
/* 151 */     return url;
/*     */   }
/*     */ 
/*     */   public String audioUrl(String randomString) {
/* 155 */     this.captchaRandom = randomString;
/* 156 */     this.httpSess.setAttribute("captchasDotNetRandom", this.captchaRandom);
/* 157 */     return audioUrl();
/*     */   }
/*     */ 
/*     */   public String image()
/*     */   {
/* 164 */     StringBuffer imageCode = new StringBuffer();
/* 165 */     imageCode.append("<a href=\"http://captchas.net\"><img style=\"border: none; vertical-align: bottom\" ");
/* 166 */     imageCode.append("id=\"captchas.net\" src=\"" + imageUrl() + "\" ");
/* 167 */     imageCode.append("width=\"" + this.width + "\" height=\"" + this.height + "\" ");
/* 168 */     imageCode.append("alt=\"The CAPTCHA image\" /></a> \n");
/* 169 */     imageCode.append("<script type=\"text/javascript\">\n");
/* 170 */     imageCode.append("  <!--\n");
/* 171 */     imageCode.append("  function captchas_image_error (image)\n");
/* 172 */     imageCode.append("  {\n");
/* 173 */     imageCode.append("    if (!image.timeout) return true;\n");
/* 174 */     imageCode.append("    image.src = image.src.replace (/^http:\\/\\/image\\.captchas\\.net/,\n");
/* 175 */     imageCode.append("                                'http://image.backup.captchas.net');\n");
/* 176 */     imageCode.append("    return captchas_image_loaded (image);\n");
/* 177 */     imageCode.append("  }\n\n");
/* 178 */     imageCode.append("  function captchas_image_loaded (image)\n");
/* 179 */     imageCode.append("  {\n");
/* 180 */     imageCode.append("    if (!image.timeout) return true;\n");
/* 181 */     imageCode.append("    window.clearTimeout (image.timeout);\n");
/* 182 */     imageCode.append("    image.timeout = false;\n");
/* 183 */     imageCode.append("    return true;\n");
/* 184 */     imageCode.append("  }\n\n");
/* 185 */     imageCode.append("  var image = document.getElementById ('captchas.net');\n");
/* 186 */     imageCode.append("  image.onerror = function() {return captchas_image_error (image);};\n");
/* 187 */     imageCode.append("  image.onload = function() {return captchas_image_loaded (image);};\n");
/* 188 */     imageCode.append("  image.timeout \n");
/* 189 */     imageCode.append("    = window.setTimeout(\n");
/* 190 */     imageCode.append("    \"captchas_image_error (document.getElementById ('captchas.net'))\",\n");
/* 191 */     imageCode.append("    10000);\n");
/* 192 */     imageCode.append("  image.src = image.src;\n");
/* 193 */     imageCode.append("  //--> \n");
/* 194 */     imageCode.append("</script>\n");
/* 195 */     return imageCode.toString();
/*     */   }
/*     */ 
/*     */   public String image(String randomString) {
/* 199 */     this.captchaRandom = randomString;
/* 200 */     this.httpSess.setAttribute("captchasDotNetRandom", this.captchaRandom);
/* 201 */     return image();
/*     */   }
/*     */ 
/*     */   public char check(String password)
/*     */   {
/* 214 */     this.captchaRandom = (String) this.httpSess.getAttribute("captchasDotNetRandom");
/*     */ 
/* 217 */     if (this.captchaRandom.equals("null")) {
/* 218 */       return 's';
/*     */     }
/*     */ 
/* 221 */     if (this.captchaRandom.equals("used")) {
/* 222 */       return 'm';
/*     */     }
/*     */ 
/* 226 */     String encryptionBase = this.secret + this.captchaRandom;
/* 227 */     if ((!this.alphabet.equals("abcdefghijklmnopqrstuvwxyz")) || (this.letters != 6)) {
/* 228 */       encryptionBase = encryptionBase + ":" + this.alphabet + ":" + this.letters;
/*     */     }
/*     */ 
/* 231 */     byte[] digest = new byte[16];
/*     */     try {
/* 233 */       MessageDigest md5 = MessageDigest.getInstance("MD5");
/* 234 */       md5.update(encryptionBase.getBytes());
/* 235 */       digest = md5.digest();
/*     */     } catch (NoSuchAlgorithmException localNoSuchAlgorithmException) {
/*     */     }
/* 238 */     String correctPassword = "";
/*     */ 
/* 240 */     for (int i = 0; i < this.letters; i++) {
/* 241 */       int index = (digest[i] + 256) % 256 % this.alphabet.length();
/* 242 */       correctPassword = correctPassword + this.alphabet.substring(index, index + 1);
/*     */     }
/*     */ 
/* 245 */     if (!password.equals(correctPassword))
/*     */     {
/* 247 */       return 'w';
/*     */     }
/*     */ 
/* 250 */     this.httpSess.setAttribute("captchasDotNetRandom", "used");
/*     */ 
/* 252 */     return 't';
/*     */   }
/*     */ }

/* Location:           /home/bmutia/Development/workspace/ivweb2/src/
 * Qualified Name:     captchas.CaptchasDotNet
 * JD-Core Version:    0.6.2
 */