<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>test</title>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js"
	crossorigin="anonymous"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link
	href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic"
	rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/index-styles.css" rel="stylesheet" />
<!-- for icons -->
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<script src="scripts.js"></script>
<!-- for recipient fields -->
<link rel="stylesheet"
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js">
						    </script>
</head>


<body>
<nav
		class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top"
		id="mainNav">
		<div class="container">
				<a class="navbar-brand" href="#page-top">SIGN DOCUMENT</a>
				<!-- find suitable name for top navbar/entire app lol -->
				<button
					class="navbar-toggler text-uppercase font-weight-bold bg-primary text-white rounded"
					type="button" data-bs-toggle="collapse"
					data-bs-target="#navbarResponsive" aria-controls="navbarResponsive"
					aria-expanded="false" aria-label="Toggle navigation">
					Menu <i class="fas fa-bars"></i>
				</button>
				<div class="collapse navbar-collapse" id="navbarResponsive">
					<ul class="navbar-nav ms-auto">
						<li class="nav-item mx-0 mx-lg-1"><a
							class="nav-link py-3 px-0 px-lg-3 rounded" href="index.jsp">Home</a></li>
						<li class="nav-item mx-0 mx-lg-1"><a
							class="nav-link py-3 px-0 px-lg-3 rounded" href="Logout">Logout</a></li>
					</ul>

				</div>
			</div>
		</nav>

	
<form method="post" action="test3" class="register-form" id="test-form" enctype="multipart/form-data" style="padding-top: 200px">
				<div class="col-md-6" style="display: inline-grid" >
				  
				  <label for="formFile" class="form-label">File input </label>
				  	<input class="form-control" type="file" id="formFile" name ="formFile" style="width: fit-content">
				  	
				  <label for="signerEmail"><iclass="zmdi zmdi-account material-icons-name"></i></label>Recipient Email 
				  	<input type="text" name="signerEmail" id="signerEmail"placeholder="pat@email.com" required="required" />
				  	
				  <label for="signerName"><iclass="zmdi zmdi-account material-icons-name"></i></label>Recipient Name 
				  	<input type="text" name="signerName" id="signerName" placeholder="Name" required="required" />
				  	
				  <label for="senderPass"><iclass="zmdi zmdi-account material-icons-name"></i></label>DocuSign Password
				  	<input type="password" name="senderPass" id="senderPass" placeholder="Sender Password" required="required" />
				  </div>	
					<div class="form-group form-button" style="padding: 20px">
								<input type="submit" name="Submit" id="Submit"
									class="form-submit" value="Submit" />
					</div>
	</form>
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	<script type="text/javascript">
 var status = document.getElementById("status").value;
 if(status == "success"){
	 swal("Congrats","Envelope Sent Successfully","sucess"); 
 }
 else 
	 {
	 swal("fail", "Try Again");
	 }
 </script>
</body>
</html>