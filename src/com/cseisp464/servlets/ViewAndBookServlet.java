package com.cseisp464.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ViewAndBookServlet
 */
@WebServlet("/ViewAndBookServlet")
public class ViewAndBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewAndBookServlet() {
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
		
		
		// Check for session obj, if null then redirect to login page
		
		// Retrieving the Plane ID form the POST data.
		int number_of_seats_requested = Integer.parseInt(request.getParameter("number_of_seats"));
		String plane_number = request.getParameter("plane_number");
		
		System.out.println("seats: " + number_of_seats_requested);
		System.out.println("plane no. " + plane_number);

		// Session
		HttpSession session = request.getSession();
		
		int cost_per_ticket = Integer.parseInt((String)session.getAttribute("cost"));
		int total_cost = 0;
		
		// Get the ticket class from the stored session attributes
		String ticket_class = (String)session.getAttribute("ticket_class");
		// Verify the number of seats by getting the flights bean from the session
		List<Flights> l =(ArrayList<Flights>) session.getAttribute("flightsBean");
		
		Flights flight_information_object = null;
		
		// Iterate through the list of flight beans to find the plane with the above obtained plane number
		for(int i=0;i<l.size();i++){ 
			
			if(l.get(i).getPlane_number().equals(plane_number)){
				// Now check for the availability of tickets
				switch (ticket_class) {
				case "Economy":
					if(l.get(i).getEconomy_available() >= number_of_seats_requested){
						total_cost = number_of_seats_requested * cost_per_ticket;
						System.out.println("Total Cost Economy: " + total_cost);
					}else{
						// redirect to error page or search results page
					}
					break;
				case "Business":
					if(l.get(i).getBusinessclass_available() >= number_of_seats_requested){
						total_cost = (number_of_seats_requested * cost_per_ticket) + 200;
						System.out.println("Total Cost BC: " + total_cost);
					}else{
						// redirect to error page or search results page
					}									
					break;
				case "First":
					if(l.get(i).getFirstclass_available() >= number_of_seats_requested){
						total_cost = (number_of_seats_requested * cost_per_ticket) + 100;
						System.out.println("Total Cost FC: " + total_cost);
					}else{
						// redirect to error page or search results page
					}											
					break;
				default:
					break;
				}
				
				flight_information_object = l.get(i);
				break;
			}
			
			
		}
		
	// pass the number of seats and total cost to the transaction page
	session.setAttribute("flight_information_object", flight_information_object);
	session.setAttribute("total_cost", total_cost);
	session.setAttribute("confirmed_number_of_seats", number_of_seats_requested);
	RequestDispatcher rd = request.getRequestDispatcher("transaction.jsp") ;
	rd.include(request, response);	
		
	}

}
