package com.cseisp464.servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class UpdateBookingHistoryServlet
 */
@WebServlet("/UpdateBookingHistoryServlet")
public class UpdateBookingHistoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateBookingHistoryServlet() {
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
		
		System.out.println("In Update Booking History Servlet");
		
		long acc_number = Long.parseLong(request.getParameter("account_number"));
		
		HttpSession session = request.getSession();
		String username = (String)session.getAttribute("username");
		int plane_number = Integer.parseInt((String)session.getAttribute("plane_number"));
		int booking_id;
		
		List<ShoppingCart> sc = (List<ShoppingCart>) session.getAttribute("cart");
		System.out.println(sc.size());
		
		try {
			Bookings b = new Bookings(); 

			for (Iterator<ShoppingCart> iter = sc.iterator(); iter.hasNext(); ) {
				 ShoppingCart element = iter.next();
				 int flight_id= Integer.parseInt(element.getFlight_id());
				 System.out.println("flight id: " + flight_id );
				 int confirmed_number_of_seats = element.getNumberOfTickets();
				 int ticket_cost= element.getTotal_cost();
				 booking_id = b.addingBookingDetails(confirmed_number_of_seats, acc_number, username, ticket_cost);
				 b.addEntriesInBookingFlightsTable(booking_id, flight_id);													   
				} 
		}
			 catch (SQLException e) {
				e.printStackTrace();
			}	
		 session.removeAttribute("cart");
		 
		 response.getWriter().write("success");
	}

}
