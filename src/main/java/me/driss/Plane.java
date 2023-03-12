package me.driss;
import java.util.*;
public class Plane {
	Point source;
	Point target; 
	int nsa=0;
	ArrayList<String> path;
	ArrayList<Point> points;
	ArrayList<Point> fogs;
	public Plane(Point source, Point target,int nsa,ArrayList<String> path,ArrayList<Point> points,ArrayList<Point> fogs) {
		super();
		this.source = source;
		this.target = target;
		this.path=path;
		this.nsa=nsa;
		this.fogs=fogs;
		this.points=points;
	
	}
	

}
