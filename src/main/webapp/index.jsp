<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
 
<html>
<body>
  
   
  <%
            
        	Map<String,List<String>> result = (Map<String,List<String>>)request.getAttribute("imagesLink");
        	for (Map.Entry<String,List<String>> entry : result.entrySet()) {
        		out.println("<h2>" + entry.getKey() +"</td>");
        		List<String> images = entry.getValue();
        		for(int i=0; i<images.size();i++){
        			out.println("<img style=\"height: 200px;width: auto;border: solid;\" class=\"img-responsive images\" src=" + images.get(i) + ">");
        		}
        		
        		
        	}
           
        %>
   

</body>
</html>