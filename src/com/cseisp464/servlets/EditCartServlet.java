package com.cseisp464.servlets;

import java.io.IOException;
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
 * Servlet implementation class EditCartServlet
 */
@WebServlet("/EditCartServlet")
public class EditCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditCartServlet() {
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
		
		String flight_number = request.getParameter("flight_number");
		int total_cost = Integer.parseInt(request.getParameter("total_cost"));
		System.out.println("flight no. " + flight_number);
		
		HttpSession session = request.getSession();		
		List<ShoppingCart> sc = (List<ShoppingCart>) session.getAttribute("cart");
		
		
		for (Iterator<ShoppingCart> iter = sc.iterator(); iter.hasNext(); ) {
			 ShoppingCart element = iter.next();			 
			 if(element.getFlight_id().equals(flight_number) && element.getTotal_cost()==total_cost ){
				 iter.remove();
			 }												   
		} 
		
		RequestDispatcher rd = request.getRequestDispatcher("shoppingCart.jsp") ;
		rd.include(request, response);
		
	}

}
