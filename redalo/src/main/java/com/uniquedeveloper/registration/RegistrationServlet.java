package com.uniquedeveloper.registration;


import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Servlet implementation class RegistrationServlet
 */

@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public static String getMd5(String input)
    {
        try {
 
            // Static getInstance method is called with hashing MD5
            MessageDigest md = MessageDigest.getInstance("MD5");
 
            // digest() method is called to calculate message digest
            // of an input digest() return array of byte
            byte[] messageDigest = md.digest(input.getBytes());
 
            // Convert byte array into signum representation
            BigInteger no = new BigInteger(1, messageDigest);
 
            // Convert message digest into hex value
            String hashtext = no.toString(16);
            while (hashtext.length() < 32) {
                hashtext = "0" + hashtext;
            }
            return hashtext;
        }
 
        // For specifying wrong message digest algorithms
        catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
	
    	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
    			throws ServletException, IOException {
    		
    		String uname = request.getParameter("name");
    		String uemail = request.getParameter("email");
    		String upwd = request.getParameter("pass");
    		String Reupwd = request.getParameter("re_pass");
    		String umobile = request.getParameter("contact");
			String role = request.getParameter("role");
    		RequestDispatcher dispatcher = null ;
    		Connection con = null;
    		
    		if(uname == null || uname.equals("")) {
    			request.setAttribute("status","InvalidName");
    			dispatcher = request.getRequestDispatcher("registration.jsp");
    			dispatcher.forward(request, response);
    		}
    		if(uemail == null || uemail.equals("")) {
    			request.setAttribute("status","InvalidEmail");
    			dispatcher = request.getRequestDispatcher("registration.jsp");
    			dispatcher.forward(request, response);
    		}
    		if(upwd == null || upwd.equals("")) {
    			request.setAttribute("status","InvalidPassword");
    			dispatcher = request.getRequestDispatcher("login.jsp");
    			dispatcher.forward(request, response);
    		}
    		else if(!upwd.equals(Reupwd)) {
    			request.setAttribute("status","InvalidConfirmation");
    			dispatcher = request.getRequestDispatcher("registration.jsp");
    			dispatcher.forward(request, response);
    		}
    		if(umobile == null || umobile.equals("")) {
    			request.setAttribute("status","InvalidMobile");
    			dispatcher = request.getRequestDispatcher("registration.jsp");
    			dispatcher.forward(request, response);
    		}
    		
    		else if(umobile.length()>10) {
    			request.setAttribute("status","InvalidMobileLength");
    			dispatcher = request.getRequestDispatcher("registration.jsp");
    			dispatcher.forward(request, response);
	
    		}
    		
    		try {
    			Class.forName("com.mysql.cj.jdbc.Driver");
    			 con = DriverManager.getConnection("jdbc:mysql://localhost:3306/users?useSSL=false","root","");
    			PreparedStatement pst = con.prepareStatement("insert into user(uname,upwd,uemail,umobile,role) values(?,?,?,?,?) ") ;
    			pst.setString(1, uname);
    			pst.setString(2, getMd5(upwd));
    			pst.setString(3, uemail);
    			pst.setString(4, umobile);
				pst.setString(5, role);
    			
    			int rowCount = pst.executeUpdate();
    			dispatcher = request.getRequestDispatcher("registration.jsp");
    			if(rowCount > 0) {
    				request.setAttribute("status", "success");
    			}else {
    				request.setAttribute("status", "fail");
    			} 
    			dispatcher.forward(request, response);
    		}catch(Exception e) {
    			e.printStackTrace();
    		}finally {
    			try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
    		}
    		
    	}

}
