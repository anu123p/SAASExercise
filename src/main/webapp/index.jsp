<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
 
<html>
<head>

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-YS52GEWSST"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-YS52GEWSST');
</script>

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-NGYP65PSGB"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-NGYP65PSGB');
</script>

<link rel="stylesheet" href="./css/index.css" type="text/css" />
<link rel="stylesheet" href="./css/w3.css" type="text/css" />
<!-- <link href="http://www.w3schools.com/lib/w3.css" rel="stylesheet"/> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<style>
.text {
  color: #f2f2f2;
  font-size: 24px;
  padding: 8px 12px;
  position: absolute;
  bottom: 8px;
  width: 100%;
  text-align: center;
}

.background{
background-color: #ffffff;
}
</style>

</head>
<body background ="../css/background.jpeg" class = "background">

<center> <h3 ><b>PHOTO ALBUMS </b></h3></center>
   
   
  
  <%
        	
        	Map<String,List<String>> result = (Map<String,List<String>>)request.getAttribute("imagesLink");
			int index=1;
        	for (Map.Entry<String,List<String>> entry : result.entrySet()) {
        		String s = "<div class=\"w3-content w3-display-container slider\" id=\"div"+index+"\">";
 
                out.println(s);
        		
        		List<String> images = entry.getValue();
        		for(int i=0; i<images.size();i++){
        			
        			 out.println(" <img class=\"mySlides\" src="+images.get(i)+" style =\"width:800px;height:600px\" align=\"middle\" >"); 
        			 out.println("<div class=\"text\"><b>"+entry.getKey().toUpperCase()+"</b></div>");
        			}
        		
        		out.println("<a class=\"w3-btn-floating w3-display-left\" onclick=\"plusDivs(this,-1)\">&#10094;</a>");
            	out.println("<a class=\"w3-btn-floating w3-display-right\" onclick=\"plusDivs(this,-1)\">&#10095;</a>");
            	out.println("</div>");
            	out.println("<br>");
            	out.println("<br>");
            	out.println("<br>");
            	out.println("<br>");
            	out.println("<br>");
        		index++;
        		
        	}
        	
           
        	
        	
        %>
  
  



<script>
var sliderObjects = [];
createSliderObjects();

function plusDivs(obj, n) {
  var parentDiv = $(obj).parent();
  var matchedDiv;
  $.each(sliderObjects, function(i, item) {
    if ($(parentDiv[0]).attr('id') == $(item).attr('id')) {
      matchedDiv = item;
      return false;
    }
  });
  matchedDiv.slideIndex=matchedDiv.slideIndex+n;
  showDivs(matchedDiv, matchedDiv.slideIndex);
}

function createSliderObjects() {
  var sliderDivs = $('.slider');
  $.each(sliderDivs, function(i, item) {
    var obj = {};
    obj.id = $(item).attr('id');
    obj.divContent = item;
    obj.slideIndex = 1;
    obj.slideContents = $(item).find('.mySlides');
    showDivs(obj, 1);
    sliderObjects.push(obj);
  });
}

function showDivs(divObject, n) {
  debugger;
  var i;
  if (n > divObject.slideContents.length) {
    divObject.slideIndex = 1
  }
  if (n < 1) {
    divObject.slideIndex = divObject.slideContents.length
  }
  for (i = 0; i < divObject.slideContents.length; i++) {
    divObject.slideContents[i].style.display = "none";
  }
  divObject.slideContents[divObject.slideIndex - 1].style.display = "block";
}
</script>

</body>
</html>