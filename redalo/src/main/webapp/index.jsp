<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%
	if(session.getAttribute("name")== null){
		response.sendRedirect("login.jsp");
	}
	Class.forName("com.mysql.cj.jdbc.Driver");
	session.getAttribute("email");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/users?useSSL=false","root","");
	
	String sql ="SELECT id, env_id,R_Name,R_email, file_name, env_status, SentOn from user INNER JOIN recipient ON user.uemail= recipient.S_email AND user.uemail =? ";
	PreparedStatement pst = con.prepareStatement(sql,
            ResultSet.TYPE_SCROLL_SENSITIVE, 
        ResultSet.CONCUR_UPDATABLE);
	pst.setString(1,(String) session.getAttribute("email"));
	ResultSet rs = pst.executeQuery();
	
	String sql_ ="SELECT * from user";
	PreparedStatement pst_ = con.prepareStatement(sql_,
            ResultSet.TYPE_SCROLL_SENSITIVE, 
        ResultSet.CONCUR_UPDATABLE);
	ResultSet rs2 = pst_.executeQuery();
	
	int usersCount = 0;
	int docsCount = 0;
	
	if (rs.last()) {
	  docsCount = rs.getRow();
	  rs.beforeFirst();
	}
	if (rs2.last()) {
	  usersCount = rs2.getRow();
	  rs2.beforeFirst();
	}
	
	String role = (String) session.getAttribute("role");
	if(role == null){
		role = "";
	}
%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Redal - DocuSign | Dashboard</title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.jsp">
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fas fa-signature"></i>
                </div>
                <div class="sidebar-brand-text mx-3">DocuSign</div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item active">
                <a class="nav-link" href="index.jsp">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>Dashboard</span></a>
            </li>

        </ul>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Sidebar Toggle (Topbar) -->
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>

                    <!-- Topbar Search -->
                    <form
                        class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
                        <div class="input-group">
                            <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..."
                                aria-label="Search" aria-describedby="basic-addon2">
                            <div class="input-group-append">
                                <button class="btn btn-primary" type="button">
                                    <i class="fas fa-search fa-sm"></i>
                                </button>
                            </div>
                        </div>
                    </form>

                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">

                        <!-- Nav Item - Search Dropdown (Visible Only XS) -->
                        <li class="nav-item dropdown no-arrow d-sm-none">
                            <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-search fa-fw"></i>
                            </a>
                            <!-- Dropdown - Messages -->
                            <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
                                aria-labelledby="searchDropdown">
                                <form class="form-inline mr-auto w-100 navbar-search">
                                    <div class="input-group">
                                        <input type="text" class="form-control bg-light border-0 small"
                                            placeholder="Search for..." aria-label="Search"
                                            aria-describedby="basic-addon2">
                                        <div class="input-group-append">
                                            <button class="btn btn-primary" type="button">
                                                <i class="fas fa-search fa-sm"></i>
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </li>

                        <!-- Nav Item - Alerts -->
                        <li class="nav-item dropdown no-arrow mx-1">
                            <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-bell fa-fw"></i>
                                <!-- Counter - Alerts -->
                                <span class="badge badge-danger badge-counter">2+</span>
                            </a>
                            <!-- Dropdown - Alerts -->
                            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="alertsDropdown">
                                <h6 class="dropdown-header">
                                    Alerts Center
                                </h6>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-primary">
                                            <i class="fas fa-file-alt text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">August 12, 2022</div>
                                        New document to sign
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-primary">
                                            <i class="fas fa-thin fa-user"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">August 20, 2022</div>
                                        New user joined
                                    </div>
                                </a>
                    
                    
                                <a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
                            </div>
                        </li>

                        <div class="topbar-divider d-none d-sm-block"></div>

                        <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small"><%=session.getAttribute("name") %> <% if(role.equals("Admin")){ %> (Admin)<%} %></span>
                                <img class="img-profile rounded-circle"
                                    src="img/undraw_profile.svg">
                            </a>
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="userDropdown">
                               
                                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Logout
                                </a>
                            </div>
                        </li>

                    </ul>

                </nav>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
                    
                    </div>

                    <!-- Content Row -->
                    <div class="row">
						<% if(role.equals("Admin")){ %> 
                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-primary shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                                Users</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800"><%=usersCount %></div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-user fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                                Documents</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800"><%=docsCount %></div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
						<%} %>
                       

                       





                    <!-- Content Row -->
                    <div class="row">



                        <div class="col-xl-10 col-md-6 col-mb-4">

                            <!-- Illustrations -->
                            <div class="card shadow md-6 mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">DocuSign</h6>
                                </div>
                                <div class="card-body">
                                    <div class="text-center">
                                        <img class="img-fluid px-3 px-sm-4 mt-3 mb-4" style="width: 25rem;"
                                            src="img/docusign.png" alt="...">
                                    </div>
                                    <p> <a target="_blank" rel="nofollow" href="https://www.docusign.com/">DocuSign</a> offers a free electronic signature tool for electronically signing documents on practically any device. 
										Add an electronic signature to a document for free. Sign forms, contracts, and agreements in minutes, 
										using a computer, tablet or mobile phone.
									</p>
                                </div>
                            </div>
					
                            <!-- Approach -->
                            <div class="card shadow md-6 mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">DataBase</h6>
                                </div>
								
                                <div class="card-body">
								<div>
								  <div class="btn-group">
									  <a href="#" class="btn btn-outline-primary" data-toggle="modal" data-target="#addDocumentModal">Add document</a>
									</div>
								</div>
                                    <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <% if(role.equals("Admin")){ %> <th>#</th><% } %>
                                            <th>Envolope Id</th>
                                            <th>Recipient Name</th>
                                            <th>Recipient Email</th>
                                            <th>File Name</th>
                                            <th>Envelope Status</th>
											<th>Sent On</th>
                                        </tr>
                                    </thead>
                                    <tbody>
									<% while(rs.next()){ %>
                                        <tr><% if(role.equals("Admin")){ %> 
											<td>
												<a data-toggle="modal" data-target="#deleteModal" data-id="<%= rs.getString(1) %>" class="btn btn-outline-danger btn-rounded btn-sm" role="button" aria-disabled="true">&times;</a>
											</td>
											<% } %>
                                            <td><%= rs.getString(2) %></td>
                                            <td><%= rs.getString(3) %></td>
                                            <td><%= rs.getString(4) %></td>
                                            <td><%= rs.getString(5) %></td>
                                            <td><%= rs.getString(6) %></td>
											<td><%= rs.getString(7) %></td>
                                        </tr>
									<% } %>
									 <%
									  rs.close();
									 %>
                                    </tbody>
                                </table>
                            </div>
                                </div>
                            </div>
						</div>
                       
                    </div>

                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>Copyright &copy; Redal 2022</span>
                    </div>
                </div>
            </footer>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">X</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="Logout">Logout</a>
                </div>
            </div>
        </div>
    </div>
	
	 <!-- Delete Modal-->
    <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Delete Document</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">X</span>
                    </button>
                </div>
                <div class="modal-body">You are sure you want to delete this document ?</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a id="deleteBtn" class="btn btn-danger" href="">Delete</a>
                </div>
            </div>
        </div>
    </div>
	
	<!-- Add document Modal -->
	<div class="modal fade" id="addDocumentModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Sign Document</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">X—</span>
                    </button>
                </div>
                <div class="modal-body">
				<form class="user" method="post" action="UploadDoc" id="test-form" enctype="multipart/form-data">
					
					<div class="form-group">
						<input type="text" class="form-control form-control-user" id="signerName" name="signerName"
								placeholder="Recipient Name">
					</div>
					<div class="form-group">
						<input type="email" class="form-control form-control-user" id="signerEmail" name="signerEmail"
							placeholder="Recipient Email Address">
					</div>
					<div class="form-group">
						<input type="password" class="form-control form-control-user"
								id="senderPass" name="senderPass" placeholder="Docusign Password">
					</div>
					<div class="form-group">
						<input class="form-control-file" type="file" id="formFile" name="formFile">
					</div>
					
					
					<div class="form-group form-button" >
								<input type="submit" name="Submit" id="Submit"
									class="btn btn-primary btn-block" value="Submit" />
					</div>
					<hr>
                                
                    </form>
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

    <!-- Page level plugins -->
    <script src="vendor/chart.js/Chart.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="js/demo/chart-area-demo.js"></script>
    <script src="js/demo/chart-pie-demo.js"></script>
	<!-- Page level plugins -->
    <script src="vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="js/demo/datatables-demo.js"></script>
	
	<script>
	$('#deleteModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget); // Button that triggered the modal
	  var documentId = button.data('id');
		console.log('<###', documentId);	  // Extract info from data-* attributes
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var btn = $('#deleteBtn');
	  btn.attr('href', 'deleteDoc?id=' + documentId);
	})
	</script>
</body>

</html>