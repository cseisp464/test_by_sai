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
import java.util.Properties;

import org.xml.sax.InputSource;

/**
 * @author Saichand
 *
 */
public class Users {
	private String fname,lname,email,uname,passwd1,passwd2;
	private final String path_to_properties_file;
	
	public Users(String path){
		
		path_to_properties_file = path+"\\WEB-INF\\classes\\users.properties";
		System.out.println(path_to_properties_file);
	}
	
	public void addUser(String firstname, String lastname, String emailAddress, String username, String password1, String password2) throws IOException{
		
		fname = firstname;
		lname = lastname;
		email = emailAddress;
		uname = username;
		passwd1 = password1;
		passwd2 = password2;
		
		Properties userProperty = new Properties();
		String key = uname;
		String value = fname+","+lname+","+email+","+passwd1+","+passwd2;
		userProperty.setProperty(key,value);
		//File file = new File("user.properties");
		File file = new File(path_to_properties_file);
		//path_to_properties_file
		FileOutputStream fileOut = new FileOutputStream(file,true);
		userProperty.store(fileOut, null);
		fileOut.close();
	}
	
	public boolean checkUser(String username) throws IOException{
		
		Properties p = new Properties();
		InputStream is = null;
		boolean status = false;
		System.out.println("HELLO WORLD" +path_to_properties_file);
		is = new FileInputStream(path_to_properties_file);
		p.load(is);
		status = p.containsKey(username);
		is.close();
		return status;
		
	}
	
	public boolean authenticateUser(String username, String passwd) throws IOException{
		
		Properties p = new Properties();
		InputStream is = null;
		is = new FileInputStream(path_to_properties_file);
		p.load(is);
		String[] values = p.getProperty(username).split(",");
		if(values[4].equals(passwd)){
			is.close();
			return true;
		}
		else{
			is.close();
			return false;
		}
	}
	
}
