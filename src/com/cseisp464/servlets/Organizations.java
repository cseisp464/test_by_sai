package com.cseisp464.servlets;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Organizations {
	private String organization_name = "Default_ORG_NAME";
	private String organization_address="Default_ORG_ADDRESS";
	private String uname;
	private JDBCHelper db;
	
	public Organizations(){
		
	}
	
	public Organizations(String name){
		setOrganization_name(name);
	}
	
	public void addOrg(String org_name, String org_addr, String username) throws IOException, NoSuchAlgorithmException{
			
			organization_name = org_name;
			organization_address = org_addr;
			uname = username;
			
			// List to hold the user info 
			ArrayList<Object> param =  new ArrayList<Object>();
			param.add(organization_name);
			param.add(organization_address);
			param.add(uname);
			
			String query_string = "INSERT INTO organizations values (default, ?, ?, ?)";
			
			connectDB();
			
			int result = db.updateDB(query_string, param);
			
			if(result>0){
				System.out.println("Successfully added an organization");
			}else{
				System.out.println("oops! something went wrong");
			}
			
			closeDB();
			
	}

	public String getOrganization_name() {
		return organization_name;
	}

	public void setOrganization_name(String organization_name) {
		this.organization_name = organization_name;
	}

	private void connectDB(){
		// Testing Database Connection using the JDBC Helper class
		db = new JDBCHelper("cse.unl.edu", "spalusa", "spalusa", "Test@464");
	}
	
	private void closeDB(){
		db.closeDBConnection();
	}
	
	public String getOrgName(String username) throws IOException, NoSuchAlgorithmException, SQLException{
		
		// List to hold the username 
		ArrayList<Object> param =  new ArrayList<Object>();
		// Adding the username to the list
		param.add(username);
		// Composing the query to check if the user exists
		String query_string = "SELECT * FROM organizations" +  " WHERE user_id = ? ";
		
		connectDB();
		
		ResultSet rs1 = db.queryDB(query_string, param);
		// Moving the ResultSet cursor to first row
		rs1.next();
		
		// Comparing the passwords : Encode the entered password along with the stored salt value to calculate the hash. 
		// After calculating the hash, compare it with the hashed password stored in the database USERS table. 
		// If both of hashes match then the user is an authenticated user
		
		String name = rs1.getString("name");
		
		closeDB();
		
		return name;
	}
	
}
