package com.cseisp464.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		out.println("<html><body>");
		
		// Handle form data correctly		
		String fname = request.getParameter("firstname");
		String lname = request.getParameter("lastname");
		String email = request.getParameter("email");
		String uname = request.getParameter("username");
		String passwd1 = request.getParameter("password1");
		
		Users newUser = new Users(this.getServletContext().getRealPath("/"));
		
		// Check if the username exists
		if(!newUser.checkIfUserExists(uname)){ // If the username does not exist then add the user info and redirect the user to login page
			
			try {
				newUser.addUser(fname,lname,email,uname,passwd1);
			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			response.sendRedirect("login.jsp");
		}else{ // If the username exists then ask the user to sign up using a different username
			request.setAttribute("username_error", "Username is already taken! Please choose a new one");
			RequestDispatcher rd = request.getRequestDispatcher("signup.jsp") ;
			rd.include(request, response);
		}
		
	}

}
