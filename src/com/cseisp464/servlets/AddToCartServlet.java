package com.cseisp464.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class AddToCartServlet
 */
@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddToCartServlet() {
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
		
		//out.println("<html><body>");
		
		// Retrieving Data from the Ajax Post Call
		String plane_number = request.getParameter("plane_number");
		String flight_number = request.getParameter("flight_number");
		String ticket_class = request.getParameter("ticket_class");
		String source = request.getParameter("source");
		String destination = request.getParameter("destination");
		String deptTime = request.getParameter("deptTime");
		String arrTime = request.getParameter("arrTime");
		String operator = request.getParameter("operator");
		String duration = request.getParameter("duration");
		
		int number_of_seats_requested = Integer.parseInt(request.getParameter("number_of_seats"));
		
		// Session
		HttpSession session = request.getSession();
		
		int cost_per_ticket = Integer.parseInt((String)session.getAttribute("cost"));
		int total_cost = 0;

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
		
		ShoppingCart sc = new ShoppingCart();
		sc.setFlight_class(ticket_class);
		sc.setFlight_id(flight_number);
		sc.setPlane_number(plane_number);
		sc.setNumberOfTickets(number_of_seats_requested);
		sc.setTotal_cost(total_cost);
		sc.setDeparture_time(deptTime);
		sc.setArrival_time(arrTime);
		sc.setSource(source);
		sc.setDestination(destination);
		sc.setOperator(operator);
		sc.setDuration(duration);
		
		if(session.getAttribute("cart")==null) {
			List<ShoppingCart> cart= new ArrayList();
			cart.add(sc);
			session.setAttribute("cart", cart);
			System.out.println("cart is null");
		}
		else {
			
			List<ShoppingCart> newcart = (List<ShoppingCart>) session.getAttribute("cart");
			newcart.add(sc);
			session.setAttribute("cart", newcart);
			System.out.println("cart != null");
		}
		
		out.write("Flight successfully added to cart");   
		
		System.out.println("seats: " + number_of_seats_requested);
		System.out.println("plane no. " + plane_number);

		
	}

}
