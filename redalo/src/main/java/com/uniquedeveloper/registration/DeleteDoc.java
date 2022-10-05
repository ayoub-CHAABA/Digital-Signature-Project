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

@WebServlet("/deleteDoc")
public class DeleteDoc extends HttpServlet {
	private static final long serialVersionUID = 1L;

	

	
    	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
    			throws ServletException, IOException {
    		RequestDispatcher dispatcher = null ;
    		Connection con = null;
    		String docId = request.getParameter("id");
    		
    		try {
    			Class.forName("com.mysql.cj.jdbc.Driver");
    			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/users?useSSL=false","root","");
    			PreparedStatement pst = con.prepareStatement("delete from recipient where id=?") ;
    			pst.setString(1, docId);
    			
    			int rowCount = pst.executeUpdate();
				
    			dispatcher = request.getRequestDispatcher("index.jsp");
    			
    			dispatcher.forward(request, response);
    		}catch(Exception e) {
    			e.printStackTrace();
    		}finally {
    			try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
    		}
    		
    	}

}
