package ShortPath;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;
public class Graph {
   
	
	private ArrayList<Airport []> edges;
	private ArrayList<Airport> airports;
	private ArrayList<Node<String>> nodes;
	 public Graph() {
		 edges = new ArrayList<>();
			airports=Airport.getAirports();
			nodes=new ArrayList<>();
			getEdges();
		 
			
	 }
	
	public   void getEdges()   {
		
		try {
	     
	        BufferedReader reader = new BufferedReader(new FileReader("C:\\Users\\driss\\eclipse-workspace\\Project1\\src\\main\\webapp\\data\\dataGraph.txt"));
	        String line = null;
	        while ((line = reader.readLine()) != null) {
	            String[] parts = line.split(" ");
	            
	            if (parts.length == 2) {
	            	
	                String air1 = parts[0];
	                String air2 = parts[1];
	               Airport a1=this.getAirportByName(air1);
	               Airport a2=this.getAirportByName(air2);
	               if(a1!=null&&a2!=null) {
	            	   Airport [] airs= {a1,a2};
	            	   //System.out.println(a2+","+a1);
	                edges.add(airs);
	            }
	            }
	        }
	        reader.close();
		}catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
	    
	
	
	

}
	
	public  Airport getAirportByName(String name) {
		
		
		
		for(Airport air:airports) {
			
			if(air.getName().equals(name))return air;
			
			
			
			
		}
		return null;
	}
	
	
	public void createNode() {
		
//		for(Airport air:airports) {
//			Node<String> node=new Node<String>(air.getName());
//			//System.out.println(node.getName()+":"+node);
//		  nodes.add(node);
//			
//		}
		for (Iterator<Airport> it = airports.iterator(); it.hasNext(); ) {
			   Airport air = it.next();
			   Node<String> node = new Node<String>(air.getName());
			   nodes.add(node);
			}
		
		
	}
	public void start() {
		
		//this.nodesString();
		
		 if(this.edges.isEmpty()) {System.out.println("edges empty");}
		for(Airport [] air: edges) {
			//System.out.println(air[0]+","+air[1]);
		 process(air[0],air[1]);
			
			
		}
		
	}
	public void process(Airport a1,Airport a2) {
		
		Node<String> nodea1=getNode(a1);
		Node<String> nodea2=getNode(a2);
		//System.out.println(nodea1.getName()+"+"+nodea2.getName());
		if(nodea1!=null&&nodea2!=null) {
			int weight=(int)a1.getLocation().distance(a2.getLocation());
			//System.out.println(weight);
			nodea1.addAdjacentNode(nodea2,weight);
			 
			
			//System.out.println(nodea1+"+"+nodea2);
		}
		
		
		
		
		
	}
	public Node<String> getNode(Airport a){
		   if(this.nodes.isEmpty()) {System.out.println("nodes empty");}
		for(Node<String> node:nodes) {
			
			if(node.getName().equals(a.getName()))return node;
			
		}
		return null;
		
	}
	
	
	public  ArrayList<Airport>  getShortestPath(String source,String target) throws Throwable {
		if(airports.isEmpty())airports=Airport.getAirports();
		if(edges.isEmpty())this.getEdges();
		createNode();
		start();	
// for(Airport[] a:this.edges) {
//			 
//			 System.out.println(a[0].getName()+"+"+a[1]);
//		
//		 }
		Airport s,t;
		s=this.getAirportByName(source);
		t=this.getAirportByName(target);
		if(s==null&&t==null) {
			
			throw new Throwable("error source or target not found");
		
		}
		
		Dijkstra<String> dijkstra = new Dijkstra<>(this);
		
		//System.out.println(nodea1.a
		Node<String> nodesource=this.getNode(s);
		 System.out.println(nodesource);
		Node<String> nodetarget=this.getNode(t);
		System.out.println(nodetarget);
		
		if(nodesource!=null&&nodetarget!=null) {
			
			dijkstra.calculateShortestPath(nodesource);
			ArrayList<Airport> airs= dijkstra.printPaths(List.of(nodetarget));
			airs.add(t);
			initialze();
			return airs; 
		}
		return null;
	
	}
	public void initialze() {
	edges.clear();
	 airports.clear();
	 nodes.clear();
		
		
	}


	
	
}
