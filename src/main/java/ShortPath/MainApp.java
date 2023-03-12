package ShortPath;

import java.io.IOException;
import java.util.*;

public class MainApp {

	/*
	 * Video Reference: https://youtu.be/BuvKtCh0SKk
	 */
	
	public static void main(String[] args) {
		ArrayList<Airport> positions=null;
		
		Graph graph=new Graph();
		
			
		
			try {
				positions=graph.getShortestPath("Cambridge","Sundy");
				positions=graph.getShortestPath("colombia","Riad");
				
			} catch (Throwable e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(positions==null )return ;
			for(Airport air:positions) {
				
				System.out.println(air.getName()+":"+air.getLocation().x+","+air.getLocation().y);
				
			}
	
	}

}
