<%--
  Created by IntelliJ IDEA.
  User: atiyakailany
  Date: 11/25/20
  Time: 9:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" xmlns:fb="http://www.facebook.com/2008/fbml" xmlns:og="http://opengraphprotocol.org/schema/" lang="en">
<head>
<script src="//connect.facebook.net/en_US/all.js"></script>

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-YS52GEWSST"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('event', 'screen_view', {
	  'app_name': 'myAppName',
	  'screen_name' : 'Home'
	});

  gtag('config', 'G-YS52GEWSST');
</script>

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-NGYP65PSGB"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('event', 'screen_view', {
	  'app_name': 'myAppName',
	  'screen_name' : 'Home'
	});

  gtag('config', 'G-NGYP65PSGB');
</script>

<link rel="stylesheet" href="./css/index.css" type="text/css" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<title>Facebook Login JavaScript</title>
<meta charset="UTF-8">



<style>
.button {
  padding: 15px 25px;
  font-size: 24px;
  text-align: center;
  cursor: pointer;
  outline: none;
  color: #fff;
  background-color: #04AA6D;
  border: none;
  border-radius: 15px;
  box-shadow: 0 9px #999;
}

.button:hover {background-color: #3e8e41}

.button:active {
  background-color: #3e8e41;
  box-shadow: 0 5px #666;
  transform: translateY(4px);
}

body {
	background-color: #dad5ce;
	display: flex;
	flex-direction: column;
	padding: 20px;
	position: relative;
}

* {
  box-sizing: border-box;
}

form.example input[type=text] {
  padding: 10px;
  font-size: 17px;
  border: 1px solid grey;
  float: left;
  width: 80%;
  background: #f1f1f1;
}

form.example button {
  float: left;
  width: 20%;
  padding: 10px;
  background: #2196F3;
  color: white;
  font-size: 17px;
  border: 1px solid grey;
  border-left: none;
  cursor: pointer;
}

form.example button:hover {
  background: #0b7dda;
}

form.example::after {
  content: "";
  clear: both;
  display: table;
}

.wrapper {
	background-color: #fff;
	padding: 25px;
	border-radius: 5px;
	width: auto;
	max-width: 100%;
	margin: 50px auto;
	align-self: center;
	box-sizing: border-box;
}

header {
	border-bottom: 1px solid #ddd;
	padding-bottom: 10px;
	margin-bottom: 20px;
	display: flex;
}

h2 {
	flex: 1;
	padding: 0;
	margin: 0;
	font-size: 16px;
	letter-spacing: 1px;
	font-weight: 700;
	color: #7A7B7F;
}

header span {
	flex: 1;
	text-align: right;
	font-size: 12px;
	color: #999;
}

section {
	display: none;
}

section.active {
	display: block;
}

section input, section textarea {
	display: block;
	width: 100%;
	box-sizing: border-box;
	border: 1px solid #ddd;
	outline: 0;
	background-color: #F5F7FA;
	padding: 10px;
	margin-bottom: 10px;
	letter-spacing: 1.4px;
}

section textarea {
	min-height: 200px;
}

section select {
	display: none;
}

.images {
	display: flex;
	flex-wrap: wrap;
	margin-top: 20px;
}

.images .img:hover span {
	display: block;
	color: #fff;
}
.app-name{
color:white;
}

@media screen and (max-width: 400px) {
	.wrapper {
		margin-top: 0;
	}
	header {
		flex-direction: column;
	}
	header span {
		text-align: left;
		margin-top: 10px;
	}
	.ways li, section input, section textarea, .select-option .head,
		.select-option .option div {
		font-size: 8px;
	}
	.images .img, .images .pic {
		flex-basis: 100%;
		margin-right: 0;
	}
}


.wrapper footer ul {
	margin: 0;
	margin-top: 30px;
	display: flex;
	list-style: none;
	padding: 0;
}

.wrapper footer ul li {
	flex: 1;
}

.wrapper footer li span {
	text-transform: capitalize;
	cursor: pointer;
}

.wrapper footer li:first-child {
	color: #999;
	text-align: left;
	font-size: 12px;
}

.wrapper footer li:first-child span {
	display: inline-block;
	border-bottom: 1px solid #ddd;
}

.wrapper footer li:last-child {
	text-align: right;
}

.wrapper footer li:last-child span {
	background-color: #22A4E6;
	padding: 10px 20px;
	color: #fff;
	border-radius: 3px;
}

@
keyframes fadeIn { 0% {
	opacity: 0;
}
100
%
{
opacity
:
1;
}
}
</style>
</head>

<body background ="../css/facebook.jpeg" class = "background">
<script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v8.0&appId=3404674302977168&autoLogAppEvents=1" nonce="iGO5Dyev"></script>
	<script>
    // This is called with the results from from FB.getLoginStatus().
    function statusChangeCallback(response) {
        console.log('statusChangeCallback');
        console.log(response);
        // The response object is returned with a status field that lets the
        // com.groupFive.web.app know the current login status of the person.
        // Full docs on the response object can be found in the documentation
        // for FB.getLoginStatus().
        if (response.status === 'connected') {
            //session.setAttribute("accessToken", response.authResponse.accessToken);
            //< c:set var="accessToken" value=response.authResponse.accessToken scope="request"/>
            // Logged into your com.groupFive.web.app and Facebook
            storeUserID();
            storeImages();
            testAPI();
        } else {
            // The person is not logged into your com.groupFive.web.app or we are unable to tell.
            // document.getElementById('status').innerHTML = 'Please log ' + 'into this com.groupFive.web.app.';
            console.log("Login unsuccessful");
        }
    }
    // This function is called when someone finishes with the Login
    // Button.  See the onlogin handler attached to it in the sample
    // code below.
    function checkLoginState() {
        FB.getLoginStatus(function (response) {
            statusChangeCallback(response);
            document.getElementById('facebookLoginButton').style.display='none'
        });
        
    }
    
    //CALL FB.init
    window.fbAsyncInit = function () {
        FB.init({
            appId: '1174911079629067',
            cookie: true,  // enable cookies to allow the server to access
            // the session
            xfbml: true,  // parse social plugins on this page
            version: 'v9.0' // use graph api version 2.8
        });
        // NOW that we've initialized the JavaScript SDK, we call
        // FB.getLoginStatus().  This function gets the state of the
        // person visiting this page and can return one of three states to
        // the callback you provide.  They can be:
        //
        // 1. Logged into your com.groupFive.web.app ('connected')
        // 2. Logged into Facebook, but not your com.groupFive.web.app ('not_authorized')
        // 3. Not logged into Facebook and can't tell if they are logged into
        //    your com.groupFive.web.app or not.
        //
        // These three cases are handled in the callback function.
        FB.getLoginStatus(function (response) {
            statusChangeCallback(response);
        });
    };
    // Load the SDK asynchronously
    (function (d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s);
        js.id = id;
        js.src = "https://connect.facebook.net/en_US/sdk.js#xfbml=1&appId=261463080590982";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));
    function testAPI() {
        console.log('Welcome!  Fetching your information.... testAPI ');
        FB.api('/me', function (response) {
            console.log('Successful login for: ' + response.name);
            document.getElementById('status').innerHTML =
                'Thanks for logging in, ' + response.name + '!';
            document.getElementById('startapp').type = 'submit';
            document.getElementById('hello').type ='text';
            document.getElementById('startapp1').style.display='block';
            document.getElementById('startapp1').type ='submit';
            document.getElementById('search').style.display='block'

        });
    }
    function storeUserID() {
        var userID;
        console.log('Welcome!  Fetching your information.... in storeUserID');
        FB.api('/me', function (response) {
            console.log('Successful login for: ' + response.name + '\n userid:' + response.id);
            userID = response.id;
            document.getElementById('userID').value = userID;
            document.getElementById('userID1').value = userID;
        });
    }
    // Here we run a very simple test of the Graph API after login is
    // successful.  See statusChangeCallback() for when this call is made.
    function storeImages() {
        console.log('Welcome!  Fetching your information.... StoreImages');
        var imageLinks = new Array();
        var imageID = new Array();
        FB.api('me/albums?fields=photos.limit(5){webp_images}&limit=5', function (response) {
            var albums = response.data;
            albums.forEach(album => {
                console.log("album")
                console.log(album)
                var photos = album.photos
                console.log("\nphotos:")
                console.log(photos)
                if (photos != undefined) {
                    photos.data.forEach(photo => {
                        imageLinks.push(photo.webp_images[0].source)
                        imageID.push(photo.id)
                    });
                }
            });
            document.getElementById('imageLinks').value = imageLinks;
            document.getElementById('imageID').value = imageID;
            console.log(imageID);
            console.log(imageLinks);
        });
    }
</script>

	<!--    Below we include the Login Button social plugin. This button uses
    the JavaScript SDK to present a graphical Login button that triggers
    the FB.login() function when clicked.  -->

	<div class='main-page'>
		<div class='menu flex-center'>
			<h1 class="app-name">Photo Album</h1>
		</div>
		<div class='sidebar flex-center'>
			<div>
				<fb:login-button id="facebookLoginButton" class="fb-login-button" style="display:block" scope="user_photos"
					onlogin="checkLoginState();" size="xlarge"
					login_text="Facebook Login">
				</fb:login-button>
			</div>
			<h2 id="status"></h2>
		</div>
		<div class='content flex-center'>
			
			<div style="padding: 10px">
				<form id="form_home" action="/generateAlbum" target="_blank" method="post">
					<input type="hidden" name="userID" id="userID"> <input
						type="hidden" name="imageLinks" id="imageLinks"> <input
						type="hidden" name="imageID" id="imageID">
					<%--    <div id="status"></div>--%>
					<input class="button" id="startapp" type="hidden" 
						value="Generate your photoAlbum">

				</form>
			</div>

			<br> <br> <br>

			<div  class="container" >
				<form  class="example"  method="post" target="_blank" action="/search" style="margin:auto;max-width:300px">
					<input type="hidden" name="userID1" id="userID1">
					<input id="hello" type="hidden" name="Label" class="form-control"
						placeholder="Search Labels">
					<button id="startapp1" style="display:none"  name="save" class="btn btn-info"
						value="save"><i style="display:none" id= "search" class="fa fa-search"></i></button>
				</form>
			</div>
			
		</div>
	</div>
	



</body>
</html>