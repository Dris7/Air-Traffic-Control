package ShortPath;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;

import me.driss.Point;

public class Airport {
	
	private Point location;
	private String name;
	private static ArrayList<Airport> airports;
	
	public Airport(String name,Point location) {
		
		this.name=name;
		this.location=location;
		
	}

	public Point getLocation() {
		return location;
	}

	public void setLocation(Point location) {
		this.location = location;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	
	
	public static ArrayList<Airport> getAirports() {
		try {
		      airports=new ArrayList<>();
		        BufferedReader reader = new BufferedReader(new FileReader("C:\\Users\\driss\\eclipse-workspace\\Project1\\src\\main\\webapp\\data\\dataAirport.txt"));
		        String line = null;
		        while ((line = reader.readLine()) != null) {
		            String[] parts = line.split(" ");
		            
		            if (parts.length == 3) {
		            	
		                String name = parts[0];
		                int x = Integer.parseInt(parts[1]);
		                int y = Integer.parseInt(parts[2]);
		                //System.out.println(name+"("+x+","+y+")");
		                airports.add(new Airport(name ,new Point(x,y)));
		            }
		        }
		    
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		
		
		return airports;
	}
	
	
	public static ArrayList<Point> getpoints(ArrayList<Airport> airs){
		ArrayList<Point> pts=new ArrayList<>();
		
		for (Airport a:airs) {
			
			pts.add(a.getLocation());
			
		}
		return pts;
		
	}
	public static ArrayList<String> getNames(ArrayList<Airport> airs){
		ArrayList<String> pts=new ArrayList<>();
		
		for (Airport a:airs) {
			
			pts.add(a.getName());
			
		}
		return pts;
		
	}
	
	
	

}
