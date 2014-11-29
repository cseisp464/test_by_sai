package com.cseisp464.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class UpdateCartServlet
 */
@WebServlet("/UpdateCartServlet")
public class UpdateCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateCartServlet() {
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
		
		
		// This servlet updates the total cost and toal number of seats changed by the user. 
		// Edit Cart button functionality
		
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		// Retrieving Data from the Ajax Post Call
		String plane_number = request.getParameter("plane_number");
		String flight_number = request.getParameter("flight_number");
		String ticket_class = request.getParameter("ticket_class");
		int old_number_of_seats = Integer.parseInt(request.getParameter("old_number_of_seats"));
		int new_number_of_seats = Integer.parseInt(request.getParameter("new_number_of_seats"));
		int old_total_ticket_cost = Integer.parseInt(request.getParameter("old_total_ticket_cost"));
		
		int per_ticket_cost = old_total_ticket_cost / old_number_of_seats ;
		
		int new_total_cost = per_ticket_cost*new_number_of_seats;
		
		
		System.out.println("flight no. " + flight_number);
		System.out.println("plane no. " + plane_number);
		System.out.println("Ticket class. " + ticket_class);
		System.out.println("old ticket no. " + old_number_of_seats);
		System.out.println("new ticket no. " + new_number_of_seats);
		System.out.println("old cost no. " + old_total_ticket_cost);
		
		out.write("updated cart");
		
		
		HttpSession session = request.getSession();		
		List<ShoppingCart> sc = (List<ShoppingCart>) session.getAttribute("cart");
		
		
		for (Iterator<ShoppingCart> iter = sc.iterator(); iter.hasNext(); ) {
			 ShoppingCart element = iter.next();			 
			 if(element.getFlight_id().equals(flight_number) && element.getTotal_cost() == old_total_ticket_cost){
				 element.setTotal_cost(new_total_cost);
				 element.setNumberOfTickets(new_number_of_seats);
			 }												   
		} 
		
		//RequestDispatcher rd = request.getRequestDispatcher("shoppingCart.jsp") ;
		//rd.include(request, response);
		
	}

}
