<%@ page language="java" contentType="text/html" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>
<%@ page import="com.pearson.piiadmin.*" %>

<html> <head/> <body>
<%
try
{
 URL url = new URL("http://localhost:8000/cgi-bin"+request.getServletPath().replaceAll(".jsp",".pl"));
 URLConnection conn = url.openConnection();
 conn.setDoOutput(true);
 String  user = "user="+request.getRemoteUser()+"&";
 conn.getOutputStream().write(user.getBytes("UTF-8"), 0, user.length());
 // Send post data to perl code.
 BufferedInputStream  bis = new BufferedInputStream(request.getInputStream());
 byte[] buff = new byte[65545];
 int n = 0;
 while ((n = bis.read(buff)) >= 0)
 {
  conn.getOutputStream().write(buff, 0, n);
 }
 bis.close();
 // Write results of perl code to jsp page.
 String line;
 BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
 while ((line = reader.readLine()) != null)
 {
  out.println(line);
 }
 reader.close();
}
catch (Exception ex) { out.println(ex.toString()); }
out.close();
%>
</body> </html>
