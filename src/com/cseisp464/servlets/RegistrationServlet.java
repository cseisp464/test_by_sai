package com.cseisp464.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class RegistrationServlet
 */
@WebServlet("/RegistrationServlet")
public class RegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegistrationServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(false);
		if(session == null){
			response.sendRedirect("signup.jsp");
		}
 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		out.println("<html><body>");
		
		// Retrieving the user's info form the POST data.
		String fname = request.getParameter("firstname");
		String lname = request.getParameter("lastname");
		String email = request.getParameter("email");
		String uname = request.getParameter("username");
		String passwd1 = request.getParameter("password1");
		String org_name = request.getParameter("org_name");
		String org_addr = request.getParameter("org_addr");
		
		
		// Creating an instance of the user class with project's root path as the parameter to the constructor
		Users newUser = new Users(this.getServletContext().getRealPath("/"),fname,lname); 
		
		Organizations newOrg = new Organizations(org_name);
		
		// Check if the username exists
		try {
			if(!newUser.checkIfValueExists("username", uname) && !newUser.checkIfValueExists("email", email)){ // If the username does not exist then add the user info and redirect the user to login page
				
				try {
					newUser.addUser(fname,lname,email,uname,passwd1);
					newOrg.addOrg(org_name, org_addr, uname);
				} catch (NoSuchAlgorithmException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				Clients client = new Clients(newUser,newOrg);
				HttpSession session = request.getSession();
				session.setAttribute("client", client);
				RequestDispatcher rd = request.getRequestDispatcher("login.jsp") ;
				rd.include(request, response);
			}else{ 
				if(newUser.checkIfValueExists("username", uname)){
					// If the username exists then ask the user to sign up using a different username
					request.setAttribute("username_error", "Username is already taken! Please choose a new one");
					
				}
				if(newUser.checkIfValueExists("email", email)){
					// If the email exists then ask the user to sign up using a different email or ask him if he/she forgot password
					request.setAttribute("email_error", "Email is already registered! Please try logging in");
					
				}
				RequestDispatcher rd = request.getRequestDispatcher("signup.jsp") ;
				rd.include(request, response);
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
