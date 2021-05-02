<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>

<!DOCTYPE html>
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

<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
* {box-sizing: border-box}
body {font-family: Verdana, sans-serif; margin:0}
.mySlides {display: none}
img {vertical-align: middle;}

/* Slideshow container */
.slideshow-container {
 max-width: 800px;
  position: relative;
  margin: auto; 

}

/* Next & previous buttons */
.prev, .next {
  cursor: pointer;
  position: absolute;
  top: 50%;
  width: auto;
  padding: 16px;
  margin-top: -22px;
  color: white;
  font-weight: bold;
  font-size: 18px;
  transition: 0.6s ease;
  border-radius: 0 3px 3px 0;
  user-select: none;
}

/* Position the "next button" to the right */
.next {
  right: 0;
  border-radius: 3px 0 0 3px;
}

/* On hover, add a black background color with a little bit see-through */
.prev:hover, .next:hover {
  background-color: rgba(0,0,0,0.8);
}

/* Caption text */
.text {
  color: #f2f2f2;
  font-size: 24px;
  padding: 8px 12px;
  position: absolute;
  bottom: 8px;
  width: 100%;
  text-align: center;
}

/* Number text (1/3 etc) */
.numbertext {
  color: black;
  font-size: 18px;
  padding: 8px 12px;
  position: absolute;
  top: 0;
}

/* The dots/bullets/indicators */
.dot {
  cursor: pointer;
  height: 15px;
  width: 15px;
  margin: 0 2px;
  background-color: #bbb;
  border-radius: 50%;
  display: inline-block;
  transition: background-color 0.6s ease;
}

.background{
background-color: #ffffff;
}

.active, .dot:hover {
  background-color: #717171;
}

/* Fading animation */
.fade {
  -webkit-animation-name: fade;
  -webkit-animation-duration: 1.5s;
  animation-name: fade;
  animation-duration: 1.5s;
}
.imagestyle{
  
    width:  100%;
    object-fit: contain;
    max-height:500px;
    

}

@-webkit-keyframes fade {
  from {opacity: .4} 
  to {opacity: 1}
}

@keyframes fade {
  from {opacity: .4} 
  to {opacity: 1}
}

/* On smaller screens, decrease text size */
/* @media only screen and (max-width: 300px) {
  .prev, .next,.text {font-size: 11px}
} */
</style>
</head>
<body background ="../css/background.jpeg" class = "background">


<div class="slideshow-container">
      <%
            String label = (String)request.getAttribute("labelAttribute");
        	List<String> result = (List<String>)request.getAttribute("imagesLink");
        	if(result.size()==0)
        	{
        		out.println("<center> <h3> No Images Found with label : " + label.toUpperCase() + "</h3></center>");
        	}
        	else
        	{
        		out.println("<center> <h3>" + result.size() + " Images Found with label : " + label.toUpperCase() + "</h3></center>");
        		for(int i=0; i<result.size();i++){
        			out.println("<div class=\"mySlides fade\">");
        			out.println("<div class=\"numbertext\">"+ (i+1) + "/" +(result.size())+ "</div>");
        			out.println("<img style =\"width:800px;height:500px\" align=\"middle\" src=" + result.get(i) + ">");
        			out.println("<div class=\"text\"> <b> " + label.toUpperCase() + "</b> </div>");
        			out.println("</div>");
        		} 
        		
        	}
      	        
        %> 

<a class="prev" onclick="plusSlides(-1)">&#10094;</a>
<a class="next" onclick="plusSlides(1)">&#10095;</a>

</div>
<br>


<div style="text-align:center">

<% 
	for(int i=0; i<result.size();i++){
	
	out.println("<span class=\"dot\" onclick=\"currentSlide("+ i + ")\"></span>");
	}
 	

%>
</div>




<script>
var slideIndex = 1;
showSlides(slideIndex);

function plusSlides(n) {
  showSlides(slideIndex += n);
}

function currentSlide(n) {
  showSlides(slideIndex = n);
}

function showSlides(n) {
  var i;
  var slides = document.getElementsByClassName("mySlides");
  var dots = document.getElementsByClassName("dot");
  if (n > slides.length) {slideIndex = 1}    
  if (n < 1) {slideIndex = slides.length}
  for (i = 0; i < slides.length; i++) {
      slides[i].style.display = "none";  
  }
  for (i = 0; i < dots.length; i++) {
      dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex-1].style.display = "block";  
  dots[slideIndex-1].className += " active";
}
</script>

</body>
</html> 

 
<%-- <html>
<body>

    <h1>Images Found: </h1>
   

        <%
            
        	List<String> result = (List<String>)request.getAttribute("imagesLink");
        		for(int i=0; i<result.size();i++){
        			out.println("<img style=\"height: 200px;width 200px: auto;border: solid;\" class=\"img-responsive images\" src=" + result.get(i) + ">");
        		}
        		
           
        %>
   

</body>
</html> --%>