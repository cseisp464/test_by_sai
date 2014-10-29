/**
 * 
 */
package com.cseisp464.servlets;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import org.xml.sax.InputSource;

/**
 * @author Saichand
 *
 */
public class Users {
	private String fname,lname,email,uname,passwd,hash;
	private final String path_to_properties_file;
	private JDBCHelper db;
	
	public Users(String path){
		// Storing the path to the properties file
		path_to_properties_file = path+"\\WEB-INF\\classes\\users.properties";		
	}
	
	public void addUser(String firstname, String lastname, String emailAddress, String username, String password) throws IOException, NoSuchAlgorithmException{
		
		fname = firstname;
		lname = lastname;
		email = emailAddress;
		uname = username;
		passwd = password;
		
		String salt = getSalt();
		
		// List to hold the user info 
		ArrayList<Object> param =  new ArrayList<Object>();
		param.add(fname);
		param.add(lname);
		param.add(email);
		param.add(computeHash(passwd, salt));
		param.add(salt);
		param.add(uname);
		
		String query_string = "INSERT INTO USERS values (default, ?, ?, ?, ?, ?, ?)";
		
		connectDB();
		
		int result = db.updateDB(query_string, param);
		
		if(result>0){
			System.out.println("Successfully added a user");
		}else{
			System.out.println("oops! something went wrong");
		}
		
		closeDB();
		
	}
	
	/***
	 * This function checks if username or email already exists in the USERS table.
	 * If checking for username then the column_name should be exactly the name of the 'username' column in the USERS table 
	 * and the value will be the retrieved user name from the POST data of the form
	 * If checking for email then the column_name should be exactly the name of the 'email' column in the USERS table 
	 * and the value will be the retrieved email from the POST data of the form
	 * @param column_name
	 * @param value
	 * @return
	 * @throws IOException
	 * @throws SQLException
	 */
	public boolean checkIfValueExists(String column_name, String value) throws IOException, SQLException{
		
		boolean status = false;
		
		// List to hold the username 
		ArrayList<Object> param =  new ArrayList<Object>();
		// Adding the username to the list
		param.add(value);
		// Composing the query to check if the user exists
		String query_string = "SELECT * FROM USERS" + " WHERE " + column_name + " = ? ";
		
		connectDB();
		
		ResultSet rs1 = db.queryDB(query_string, param);

		// Checking if record exists
		if(rs1.next()){
			status = true;
		}
		
		closeDB();
		return status;
		
	}
	
	public boolean authenticateUser(String username, String entered_password) throws IOException, NoSuchAlgorithmException, SQLException{
		
		// List to hold the username 
		ArrayList<Object> param =  new ArrayList<Object>();
		// Adding the username to the list
		param.add(username);
		// Composing the query to check if the user exists
		String query_string = "SELECT * FROM USERS" +  " WHERE username = ? ";
		
		connectDB();
		
		ResultSet rs1 = db.queryDB(query_string, param);
		// Moving the ResultSet cursor to first row
		rs1.next();
		
		// Comparing the passwords : Encode the entered password along with the stored salt value to calculate the hash. 
		// After calculating the hash, compare it with the hashed password stored in the database USERS table. 
		// If both of hashes match then the user is an authenticated user
		
		String stored_salt = rs1.getString("salt");
		String stored_password = rs1.getString("password");
		
		String calculated_hash = computeHash(entered_password, stored_salt);
		
		if(stored_password.equals(calculated_hash)){
			return true;
		}else{
			return false;
		}
	}
	
	private String getSalt() throws NoSuchAlgorithmException{
		
		// Using a SecureRandom generator to generate salt for more protected password hashing
		SecureRandom sr = SecureRandom.getInstance("SHA1PRNG");
		// Create array for salt
		byte[] salt = new byte[16];
		// Get a random salt
		sr.nextBytes(salt);
		// Converting to string and Storing the salt
		return salt.toString();
	}
	
	private String computeHash(String password, String salt) throws NoSuchAlgorithmException{
		// Create MessageDigest instance for SHA-256
	    MessageDigest md = MessageDigest.getInstance("SHA-256");
	    // Add password bytes to digest
        md.update(salt.getBytes());
        //Get the hash's bytes 
        byte[] bytes = md.digest(password.getBytes());
        // This bytes[] has bytes in decimal format;
        // Convert it to hexadecimal format
        StringBuilder sb = new StringBuilder();
        for(int i=0; i< bytes.length ;i++)
        {
            sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
        }
        // Get complete hashed password in hex format
        return sb.toString();
	}
	
	private void connectDB(){
		// Testing Database Connection using the JDBC Helper class
		db = new JDBCHelper("cse.unl.edu", "spalusa", "spalusa", "Test@464");
	}
	
	private void closeDB(){
		db.closeDBConnection();
	}
	
	
}
