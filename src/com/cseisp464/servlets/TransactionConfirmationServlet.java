package com.cseisp464.servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class TransactionConfirmationServlet
 */
@WebServlet("/TransactionConfirmationServlet")
public class TransactionConfirmationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TransactionConfirmationServlet() {
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
		
		// Retrieving the form POST data
		String name = request.getParameter("account_holder_name");
		long routing_number = Long.parseLong(request.getParameter("routing_number"));
		long acc_number = Long.parseLong(request.getParameter("account_number"));
		double new_balance;
		
		String error_message="";
		boolean success_flag = true; // This flag is used to check if transaction is a success or not
		
		HttpSession session = request.getSession();
		double ticket_cost = (Integer)session.getAttribute("total_cost");
		int confirmed_number_of_seats = (Integer)session.getAttribute("confirmed_number_of_seats");
		String username = (String)session.getAttribute("username");
		int flight_id = Integer.parseInt((String)session.getAttribute("flight_number"));
		int plane_number = Integer.parseInt((String)session.getAttribute("plane_number"));
		int booking_id;
		
		System.out.println("Ticket cost: "+ ticket_cost);
		
		Transactions t = new Transactions();
		try {
			if(t.validateBankDetails(acc_number, routing_number, ticket_cost)){ // validated
				
				// check if routing number is valid one or not
				if(t.getRouting_number() != routing_number){
					error_message = error_message + "Routing Number is Wrong <br/>";
					success_flag = false;
				}			
				// check if there is enough balance to buy a ticket
				if(t.getBalance() < ticket_cost){
					error_message = error_message + "Insufficient Balance <br/>";
					success_flag = false;
				}
				
				// If the flag is true it means that there were no errors in routing no and balance
				// hence add the booking details to the booking history
				// and update the balance in the accounts table
				if(success_flag){
					error_message = null;
					
					// Addding Booking Details
					Bookings b = new Bookings(); 
					booking_id = b.addingBookingDetails(confirmed_number_of_seats, acc_number, username, ticket_cost);
					b.addEntriesInBookingFlightsTable(booking_id, flight_id);
					
					System.out.println("old balance: "+ t.getBalance());
					
					//updating the balance in the accounts
					new_balance = t.getBalance() - ticket_cost;
					System.out.println("Updated Balance = " + new_balance);
					t.updateBalance(new_balance,t.getAccount_number());

				}
				
			}else{ // not validated
				error_message = "The Account Number entered is not valid! Please try again.";
			}
			
			request.setAttribute("error_message", error_message);
			RequestDispatcher rd = request.getRequestDispatcher("transactionConfirmation.jsp") ;
			rd.include(request, response);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

}
