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
import java.util.Properties;

import org.xml.sax.InputSource;

/**
 * @author Saichand
 *
 */
public class Users {
	private String fname,lname,email,uname,passwd,hash;
	private final String path_to_properties_file;
	
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
		
		Properties userProperty = new Properties();
		String key = uname;
		String salt = getSalt();
		String value = fname+","+lname+","+email+","+ computeHash(passwd, salt)+","+salt;
		// set the property value, and write it into a properties file
		userProperty.setProperty(key,value);
		File file = new File(path_to_properties_file);
		FileOutputStream fileOut = new FileOutputStream(file,true);
		// writing into the properties file and saving to disk
		userProperty.store(fileOut, null);
		fileOut.close();
	}
	
	public boolean checkIfUserExists(String username) throws IOException{
		
		Properties p = new Properties();
		InputStream is = null;
		boolean status = false;
		
		File f = new File(path_to_properties_file);
		// create the properties file if it doesn't exist.
		if(!f.exists()){
			f.createNewFile();
		}
				
		is = new FileInputStream(f);
		
		// load the properties file
		p.load(is);
		// check for the keys in the properties file against the username
		status = p.containsKey(username);
		is.close();
		return status;
		
	}
	
	public boolean authenticateUser(String username, String passwd) throws IOException, NoSuchAlgorithmException{
		
		Properties p = new Properties();
		InputStream is = null;
		is = new FileInputStream(path_to_properties_file);
		// load the properties file
		p.load(is);
		// splitting the values of a key(username) separated by comma into a string array
		String[] values = p.getProperty(username).split(",");
		
		// Comparing the passwords : Encode the entered password along with the stored salt value (values[4]) to calculate the hash. 
     	// After calculating the hash, compare it with the hash stored in the properties file (values[3]). 
     	// If both of hashes match then the user is an authenticated user
		
        String calulatedHash = computeHash(passwd, values[4]);
        
        //closing the properties file input stream
        is.close();
        			
		if(calulatedHash.equals(values[3])){
			return true;
		}
		else{
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
	
}
