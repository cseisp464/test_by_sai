package com.cseisp464.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		out.println("<html><body>");
		
		String uname = request.getParameter("username");
		String passwd1 = request.getParameter("password1");
		
		Users newUser = new Users(this.getServletContext().getRealPath("/"));
		
		if(!newUser.checkIfUserExists(uname)){
			// User not present, so redirect the user to registration page
			response.sendRedirect("signup.jsp");
			
			//request.setAttribute("username_error", "Username not found in our records! Please Sign up.");
			//RequestDispatcher rd = request.getRequestDispatcher("login.jsp") ;
			//rd.include(request, response);
			
		}else{
			// User exists, so verify password
			try {
				if(newUser.authenticateUser(uname,passwd1)){
					response.sendRedirect("flightSearchQuery.jsp");
				}
				else{
					request.setAttribute("password_error", "Incorrect password! Try again.");
					RequestDispatcher rd = request.getRequestDispatcher("login.jsp") ;
					rd.include(request, response);
				}
			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}

		out.println("</html></body>");
	}

}
