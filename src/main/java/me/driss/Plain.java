package me.driss;



import java.util.*;
import java.util.concurrent.Executors;
import java.util.concurrent.PriorityBlockingQueue;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;

import jakarta.servlet.http.HttpSession;

public class Plain extends TimerTask {
	

	Timer timer ;
	private double x;
	private double y;
	private String name;
	private int passangers;
	private double speed=2;
    private Point target;
	private double  height;
	private double width;
	private ArrayList<Point> path;
    private boolean alive=true; 
	private int count=1;
	public int getNextStationIndex() {
		return count;
	}
	public Plain( String name) {
		super();
	
		this.name = name;
	
	}
	public void setPath(ArrayList<Point> path) {
		
		this.path=path;

        this.x=path.get(0).x;
        this.y=path.get(0).y;
      
        this.setTarget(path.get(1));
 
	}
	
	public PriorityBlockingQueue<Point> toQueue(ArrayList<Point> pts){
		PriorityBlockingQueue<Point> queue=new PriorityBlockingQueue<>();
		for(Point p: pts) {
			
			queue.add(p);
			
		}
	     
		return queue;
	}

	public Point getTarget() {
		return target;
	}
	public void setTarget(Point target) {
		this.target = target;
	}
	public double getX() {
		return x;
	}
	public void setX(double x) {
		this.x = x;
	}
	public double getY() {
		return y;
	}
	public void setY(double y) {
		this.y = y;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPassangers() {
		return passangers;
	}
	public void setPassangers(int passangers) {
		this.passangers = passangers;
	}
	public double getHeight() {
		return height;
	}
	public void setHeight(double height) {
		this.height = height;
	}
	public double getWidth() {
		return width;
	}
	public void setWidth(double width) {
		this.width = width;
	}
	@Override
	public void run() {
		
		movePlain();
		
	
		}
	public void start() {
	  
		timer =new Timer();
		timer.schedule(this,0,100);
		
	}
	public void cancell() {
		timer.cancel();
		this.alive=false;
		
	}
	
	
	public void movePlain() {
		
	
	
		//implementation goes here
		
		double deltaX = this.target.x - this.x;
		double deltaY = this.target.y - this.y;
		
		double angle = Math.atan2( deltaY, deltaX );
		 
		this.x += speed * Math.cos( angle );
		this.y += speed * Math.sin( angle );
   
	System.out.println(this.name+" ("+this.x+","+this.y+")\n");
		if(isArrived(target)) {
			System.out.println((count)+" stop  station!!!!!!!");
			count++;
			if(timer!=null&&count==path.size()) {
				cancell();
			}
			else {
			this.setTarget(path.get(count));
			}
			
			
		}
		
	
		
	}
	
	
	public boolean isArrived( Point b) {
		
		
		if(Math.abs(this.x-b.x)<speed&&Math.abs(this.y-b.y)<speed)
			return true;
			
		
		
		return false;
	}
    public void setSpeed(double speed) {
    	
    	
    	this.speed=speed;
    }
public double getSpeed() {
    	
    	
    	return this.speed;
    }
//public void movePlain() {
//		
//		ArrayList<Point> track=new ArrayList<>();
//		
//		//implementation goes here
//		
//		double deltaX = target.x - this.x;
//		double deltaY = target.y - this.y;
//		
//		double angle = Math.atan2( deltaY, deltaX );
//		while(Math.pow(this.x-target.x,2)>4&&Math.pow(this.y-target.y,2)>4) {
//		this.x += speed * Math.cos( angle );
//		this.y += speed * Math.sin( angle );
//		track.add(new Point(this.x,this.y));
//		}
//		session.setAttribute(name+"xy",track);
//		
//		
//		
//	}
public boolean isAlive() {
	return alive;
}
public void setAlive(boolean alive) {
	this.alive = alive;
}

	

}
