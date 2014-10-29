package com.cseisp464.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class PrintingServlet
 */
@WebServlet("/PrintingServlet")
public class PrintingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PrintingServlet() {
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
		out.println("<html><body><center>");
		out.print("<h2>Print Copy</h2>");
		// get form data
		String fn = request.getParameter("firstname");
		String ln = request.getParameter("lastname");
		String age = request.getParameter("age");
		String gender = request.getParameter("gender");
		
		// get session data for print
		HttpSession session = request.getSession();
		out.print("<strong>Name:</strong>");
		out.print(fn);
		out.print(ln);
		out.print("<br><br>");
		out.print("<strong>Age:</strong>");
		out.println(age);
		out.print("<br><br>");
		out.print("<strong>Gender:</strong>");
		out.println(gender);
		out.print("<br><br>");
		out.print("<strong>Flight No.:</strong>");
		out.println(session.getAttribute("flight_number"));
		out.print("<br><br>");
		out.print("<strong>Plane No.:</strong>");
		out.println(session.getAttribute("plane_number"));
		out.print("<br><br>");
		out.print("<strong>Source:</strong>");
		out.println(session.getAttribute("source"));
		out.print("<br><br>");
		out.print("<strong>Destination:</strong>");
		out.println(session.getAttribute("destination"));
		out.print("<br><br>");
		out.print("<strong>Departure Time:</strong>");
		out.println(session.getAttribute("deptTime"));
		out.print("<br><br>");
		out.print("<strong>Arrival Time:</strong>");
		out.println(session.getAttribute("arrTime"));
		out.print("<br><br>");
		out.print("<strong>Total Stops:</strong>");
		out.println(session.getAttribute("stops"));
		out.print("<br><br>");
		out.print("<strong>Total Duration:</strong>");
		out.println(session.getAttribute("duration"));
		out.print("<br><br>");
		out.print("<strong>Total No. of Seats:</strong>");
		out.println(session.getAttribute("confirmed_number_of_seats"));
		out.print("<br><br>");
		out.print("<strong>Total Cost:</strong>");
		out.println("$"+session.getAttribute("total_cost"));
		out.print("<br><br>");
		
		out.println("</center></html></body>");
	}

}
