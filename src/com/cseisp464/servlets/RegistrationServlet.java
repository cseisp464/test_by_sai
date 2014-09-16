package com.cseisp464.servlets;

import java.io.IOException;
import java.io.PrintWriter;

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
		String passwd2 = request.getParameter("password2");
		
		Users newUser = new Users();
		
		if(!newUser.checkUser(uname)){
			newUser.addUser(fname,lname,email,uname,passwd1,passwd2);
			out.println("<h1>Hello " +fname+" "+ lname+ "</h1>");
			// redirect to login page
		}else{
			//out.println("Username is already taken");
			request.setAttribute("username_error", "Username is already taken");
			RequestDispatcher rd = request.getRequestDispatcher("signup.jsp") ;
			rd.include(request, response);
		}

		out.println("</html></body>");
		
		//out.println("Default directory is: " + System.getProperty("user.dir"));
		
	}

}
