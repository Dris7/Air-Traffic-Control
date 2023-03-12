package me.driss;


public class Point implements Comparable<Point> {

	public double x;
	public double y;
	
	public Point(double x,double y) {
		this.x=x;
		this.y=y;
		
	}
	
	
	public double distance(Point p) {
		
		
		return Math.sqrt(Math.pow(p.x-this.x,2)+Math.pow(p.y-this.y,2));
		
	}




	@Override
	public int compareTo(Point o) {
		// TODO Auto-generated method stub
		return 0;
	}
	
}
