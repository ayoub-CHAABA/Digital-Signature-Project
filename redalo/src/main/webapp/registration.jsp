<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Redal - DocuSign | Register</title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body class="bg-gradient-primary">
<input type="hidden" id="status"
		value="<%= request.getAttribute("status") %>">
    <div class="container">

        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                    <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">Create an Account!</h1>
                            </div>
                            <form class="user" method="post" action="register">
                                <div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <input type="text" class="form-control form-control-user" id="name" name="name"
                                            placeholder="Name">
                                    </div>
                                    <div class="col-sm-6">
                                        <input type="text" class="form-control form-control-user" id="contact" name="contact"
                                            placeholder="Contact no">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <input type="email" class="form-control form-control-user" id="email" name="email"
                                        placeholder="Email Address">
                                </div>
                                <div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <input type="password" class="form-control form-control-user"
                                            id="pass" name="pass" placeholder="Password">
                                    </div>
                                    <div class="col-sm-6">
                                        <input type="password" class="form-control form-control-user"
                                            id="re_pass" name="re_pass" placeholder="Repeat Password">
                                    </div>
                                </div>
								<div class="form-group">
								  <label for="sel1">Role</label>
								  <select class="form-control" id="role" name="role">
									<option value="User">User</option>
									<option value="Admin">Admin</option>
								  </select>
								</div>
                              
								<div class="form-group form-button" >
											<input type="submit"
												class="btn btn-primary btn-block" value="Register Account" />
										</div>
                                <hr>
                                
                            </form>
                            <hr>
                            <div class="text-center">
                                <a class="small" href="forgotPassword.jsp">Forgot Password?</a>
                            </div>
                            <div class="text-center">
                                <a class="small" href="login.jsp">Already have an account? Login!</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>
	
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script type="text/javascript">
	 var status = document.getElementById("status").value;
	 if(status == "success"){
		 swal("Congrats","Account Created Succesfully","sucess");
		 
	 }
	 if(status == "InvalidName"){
		 swal("Oops","Please Enter valid Name","error");
		 
	 }
	 if(status == "InvalidEmail"){
		 swal("Oops","Please Enter valid Email","error");
		 
	 }
	 if(status == "InvalidPassword"){
		 swal("Oops","Please Enter valid Password","error");
		 
	 }
	 if(status == "InvalidConfirmation"){
		 swal("Oops","Passwords do not match ","error");
		 
	 }
	 if(status == "InvalidMobile"){
		 swal("Oops","Please Enter valid Mobile","error");
		 
	 }
	 if(status == "InvalidMobileLength"){
		 swal("Oops","Length should not be greater than 10","success");
		 
	 }
	</script>

</body>

</html>