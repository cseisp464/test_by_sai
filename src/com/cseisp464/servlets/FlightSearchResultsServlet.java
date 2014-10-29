package com.cseisp464.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class FlightSearchResultsServlet
 */
@WebServlet("/FlightSearchResultsServlet")
public class FlightSearchResultsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FlightSearchResultsServlet() {
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
		
		// Retrieving the Plane ID form the POST data.
		String flight_number = request.getParameter("flight_number");
		String plane_number = request.getParameter("plane_number");
		String stops = request.getParameter("stops");
		String cost = request.getParameter("cost");
		String duration = request.getParameter("duration");
		String deptTime = request.getParameter("deptTime");
		String arrTime = request.getParameter("arrTime");
		
		// Session
		HttpSession session = request.getSession();
		session.setAttribute("flight_number", flight_number);
		session.setAttribute("plane_number", plane_number);
		session.setAttribute("stops", stops);
		session.setAttribute("cost", cost);
		session.setAttribute("duration", duration);
		session.setAttribute("deptTime", deptTime);
		session.setAttribute("arrTime", arrTime);
		
		// Testing Database Connection using the JDBC Helper class
		JDBCHelper db = new JDBCHelper("cse.unl.edu", "cse464", "spalusa", "Test@464");
		
		// Query for Plane details
		ResultSet rs_planeDetails = getResults(flight_number, db);
		
		RequestDispatcher rd = request.getRequestDispatcher("viewAndBook.jsp") ;
		rd.include(request, response);
		
		//out.println("Plane : " + planeId);
		//out.println("<br>");

		out.println("</html></body>");
	}
	
	private ResultSet getResults(String planeId, JDBCHelper db) {
		// TODO Auto-generated method stub
		ArrayList<Object> param =  new ArrayList<Object>();
		param.add(planeId);
		
		String query_string = "SELECT * FROM planes"
				+ " WHERE id = ? ";
		ResultSet rs1 = db.queryDB(query_string, param);
		
		try {
			System.out.println(rs1.getStatement());
			if (rs1 != null){
				while (rs1.next()){
					System.out.println(rs1.getString("plane_number") + " " + rs1.getString("first_class_capacity") + " " + rs1.getString("business_capacity") + " " + rs1.getString("economy_capacity"));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs1;
		
	}

}
