package me.driss;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Random;

import com.google.gson.Gson;

import ShortPath.Airport;
import ShortPath.Graph;
@WebServlet("/update")
/**
 * Servlet implementation class Updater
 */
public class Updater extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Updater() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    int i=0;
    private ArrayList<Plain> plains;

    private ArrayList<Airport> po1;
    private ArrayList<Airport> po2;
    private ArrayList<Airport> po3;
    private  Graph graph;
    private ArrayList<Point> fogs;
    private String who;
    private int speed;
    private ArrayList<String> airs;
    private ArrayList<ArrayList<Airport>> pos;
    
	@Override
	public void init() throws ServletException {
	    plains=new ArrayList<>();
		
		
		airs=Airport.getNames(Airport.getAirports());
		System.out.println(airs);
		
		 pos=new ArrayList<>();
		  graph=new Graph();
		  Random rn=new Random();
		for(int i=1;i<=9;i++) {
			
			plains.add(new Plain("p"+i));
			try {
				int r1=rn.nextInt(airs.size());
				
				int r2=rn.nextInt(airs.size());
				do {
					r1=rn.nextInt(airs.size());
					r2=rn.nextInt(airs.size());
				}while(r1==r2);
				
				pos.add(graph.getShortestPath(airs.get(r1),airs.get(r2) ));
			} catch (Throwable e) {
				
				e.printStackTrace();
				
			}
			
		}
		for(int i=0;i<plains.size();i++) {
			
			
			try {
				startTravel(plains.get(i),Airport.getpoints(pos.get(i)));
			} catch (Throwable e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		 fogs =new ArrayList<>();
		 for(int i=0;i<3;i++) {
			 Point p =new Point(Math.floor(Math.random() * (1000 - 200 + 1) + 200),Math.floor(Math.random() * (500 - 200 + 1) + 200));
			fogs.add(p);		 }

		super.init();
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String speed;
		
		    speed =request.getParameter("speed");
		
		who=request.getParameter("name");
		System.out.println(speed+","+who);
		if(speed!=null&& who!=null) {
			
			chnageSpeed(who,Double.parseDouble(speed));
		    	
		}
		 for(int i=0;i<plains.size();i++) {
			 
			  if(!plains.get(i).isAlive()) {
				  
//				  try {
//					  
//					this.setSettings(i);
//					
//				} catch (Throwable e) {}
				  plains.get(i).setAlive(true);
			  }
			 
		 }
		plains.forEach(p->{System.out.println("speed of "+p.getName()+"="+p.getSpeed());});
		ArrayList<Plane> points=new ArrayList<>();
		for(int i=0;i<plains.size();i++) {
			points.add(new Plane(new Point(plains.get(i).getX(),plains.get(i).getY()),plains.get(i).getTarget(),plains.get(i).getNextStationIndex(),Airport.getNames(pos.get(i)),Airport.getpoints(pos.get(i)),fogs));	
			
			
		}
        
		
		String coordP1 = new Gson().toJson(points);
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		out.print(coordP1);
		out.flush();
	}
	private void chnageSpeed(String who2, double speed2) {

      for(Plain p:plains) {
    	  
    	  if(who2.equals(p.getName())) {
    		  
    		  p.setSpeed(speed2);
    		  break;
    	  }
    	  
    	  
      }
		
		
	}
	private void setSettings(int i) throws Throwable {
		Random rn =new Random();
		int r1=rn.nextInt(airs.size());
		
		int r2=rn.nextInt(airs.size());
		do {
			r1=rn.nextInt(airs.size());
			r2=rn.nextInt(airs.size());
		}while(r1==r2);
		pos.set(i, graph.getShortestPath(airs.get(r1),airs.get(r2)));
		startTravel(plains.get(i),Airport.getpoints(pos.get(i)));
	}
	private void startTravel(Plain p,ArrayList<Point> path) {
		
		p.setPath(path);
		
		p.start();
		
		
	} 

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		doGet(request, response);
	}

}
