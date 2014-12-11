package com.cseisp464.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.User;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
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
			response.sendRedirect("login.jsp");
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
		
		// Retrieving the username and password form the POST data.
		String uname = request.getParameter("username");
		String passwd1 = request.getParameter("password1");
		String remember_me = request.getParameter("rememberMe");
		Users u = null;
		Organizations o=null;
		
		// Session
		HttpSession session = request.getSession();
		session.setMaxInactiveInterval(900);
		session.setAttribute("username", uname);
		
		// Handling bad form data in order to avoid Null Pointer Exception
		if(remember_me == null){
			remember_me = "off";
		}
		
		System.out.println(remember_me);
		
		// Creating an instance of the user class with project's root path as the parameter to the constructor
		Users newUser = new Users(this.getServletContext().getRealPath("/"));
		Organizations org = new Organizations();
		
		try {
			u = new Users(this.getServletContext().getRealPath("/"),newUser.getFullName(uname)[0],newUser.getFullName(uname)[1]);
			o = new Organizations(org.getOrgName(uname));
		} catch (NoSuchAlgorithmException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} 
		
		Clients client = new Clients(u,o);
		
		// Check if the username exists
		try {
			if(!newUser.checkIfValueExists("username", uname)){
				// User not present, so redirect the user to registration page
				response.sendRedirect("signup.jsp");
				
			}else{
				// Setting cookie
				if(remember_me.equals("on")){
					Cookie c = new Cookie("username",uname);
					// Setting cookie's age to one day - 24 hours
					c.setMaxAge(24*60*60); 
					response.addCookie(c);
				}
					
				
				// User exists, so verify password
				try {
					if(newUser.authenticateUser(uname,passwd1)){
						
						session.setAttribute("client", client);
						RequestDispatcher rd = request.getRequestDispatcher("flightSearchQuery.jsp") ;
						rd.include(request, response);
					}
					else{ // Incorrect password, so send an error message
						request.setAttribute("password_error", "Incorrect password! Try again.");
						RequestDispatcher rd = request.getRequestDispatcher("login.jsp") ;
						rd.include(request, response);
					}
				} catch (NoSuchAlgorithmException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		out.println("</html></body>");
	}

}
