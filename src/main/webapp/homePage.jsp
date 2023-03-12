<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import ="java.util.*,me.driss.*"
    %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>Document</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    
    <div class="container">
    </div>
    <script >
    
    var image = new Image();
    image.src = 'plain.svg';

    function createCanvas(width, height, set2dTransform = true) {
      const ratio = Math.ceil(window.devicePixelRatio);
      const canvas = document.createElement('canvas');
      let div=document.querySelector(".container");
      canvas.setAttribute("id","canvas");
      canvas.setAttribute("style",`background-image: url(world.svg);
      background-position: center;
      background-size: auto;
      background-repeat: no-repeat;"id="canvas"`);
      div.appendChild(canvas);
      canvas.width = width * ratio;
      canvas.height = height * ratio;
      canvas.style.width = `${width}px`;
      canvas.style.height = `${height}px`;
      if (set2dTransform) {
        canvas.getContext('2d').setTransform(ratio, 0, 0, ratio, 0, 0);
      }
      return canvas;
    }
    let isHoveredAir=false;
    let whoHoveredAir='';
    var airx;
    var airy;
    let fogs=[];
    let fog = {x: 0, y: 0, temperature: "", pressure: ""};
    let fx,fy;
    let isPlainInFog=false;
    let whosPlainInFog;
    let color=false;
  
  //const canvas =document.querySelector("#canvas");
  const canvas=createCanvas(window.innerWidth,window.innerHeight,true);
  const cnx =canvas.getContext("2d");
  let width=canvas.width;
  let height=canvas.height;
  let isHovered=false; 
  let whoHovered;
  let isHoveredFrog=false;  

  class Point {
      
      constructor(x,y){

         this.x=x;
         this.y=y;
      }



     }
  class Airport{
      position=new Point(0,0);
      constructor(name,position){

          this.name =name ;
          this.position.x=position.x;
          this.position.y=position.y;
          
                this.pistes = Math.floor(Math.random() * 5) + 1; // random number of runways between 1 and 5
        	    this.places_au_sol = Math.floor(Math.random() * 50) + 50; // random number of parking spots between 50 and 100
        	    this.attente_au_sol = Math.floor(Math.random() * 30) + 15; // random ground waiting time in minutes between 15 and 45
        	    this.acces_aux_pistes = Math.floor(Math.random() * 10) + 5; // random time to access the runways in minutes between 5 and 15
        	    this.duree_atterissage_decollage = Math.floor(Math.random() * 10) + 5; // random landing and takeoff time in minutes between 5 and 15
        	    this.anti_collision = Math.floor(Math.random() * 10) + 1; // random anti-collision time in minutes between 1 and 10
        	    this.boucle_attente = Math.floor(Math.random() * 15) + 5; // random holding loop time in minutes between 5 and 20
        	  
      }



      }


  let airoprts=[new Airport("madrid",new Point (570, 306)),
      new Airport("casablance",new Point (568, 335)),
      new Airport("colombia",new Point (403, 423)),
      new Airport("newYork",new Point(331, 315)),
      new Airport("Riad",new Point (701, 357)),
      new Airport("Sundy",new Point (924, 491)),
      new Airport("Tokyo",new Point (972, 323)),
      new Airport("Cambridge",new Point (288, 193)),
      new Airport("Pretoria",new Point (646, 519))
              ];

 
  function blinkDot(plain) {
	
	
	  var radius = 3;
	  
	  
	 
	   
	    cnx.beginPath();
	    cnx.arc(plain.point.x, plain.point.y, radius, 0, 2 * Math.PI);
	    if (color) {
	      cnx.fillStyle = "red";
	    } else {
	      cnx.fillStyle = "blue";
	    }
	    cnx.fill();
	    cnx.closePath();
	   
	}

  
  
  function drawAirport(airoprt){

      cnx.fillStyle="red";
      cnx.beginPath();
      cnx.arc(airoprt.position.x,airoprt.position.y,10,0,Math.PI*2);
      
      cnx.fill();
     
      
      cnx.font = '18px Arial';
      cnx.fillText(airoprt.name,airoprt.position.x-3,airoprt.position.y-13);
      
      if(isHoveredAir==true&&whoHoveredAir==airoprt.name){
    	  cnx.beginPath();
		    cnx.rect(airx,airy, 190, 100);
		    cnx.fillStyle = '#d0d0d0';
		    
		    cnx.fill();
		    cnx.closePath();

		    drawAiroportInfo(airoprt);
      }
      if(isHoveredFrog){
    	  //console.log(fx+","+fy);
    	  drawFog(new Point(fx,fy));
    	  
    	
    	  
      }
      
     
  }

  function drawAirports(){

      airoprts.forEach((air)=>drawAirport(air));


  }
  drawAirports();

     

        
        
        
      

     class Plain {
    	
       point=new Point(0,0);
       target=new Point(100,100);  
       prePoint=new Point(0,0);
       h=30;
       w=30;
       index=1;
      constructor(name){
       this.name=name;
       this.path=[];
       this.points=[];
       this.p=[];
       this.fog=false;
    
     

      }
    }
     
function drawPlains(airplains){
        
        airplains.forEach(plain=>drawPlain(plain));

     }
   
     
  

  function drawPlain(plain){
	       if(typeof plain.path[plain.index]==="undefined")return
	    	   if(plain.fog){
	    		   
	    		   cnx.save();
		     cnx.beginPath();
		     cnx.translate(plain.point.x,plain.point.y);
		     cnx.rotate(getAngle(plain.point,plain.target));
		     cnx.drawImage(image,-plain.w/2,-plain.h/2);
		    
		     cnx.translate(0,0);
		     cnx.closePath();
		      
		     cnx.restore();
		     if(isHovered==true && whoHovered==plain.name){
		     drawRectangle(plain);
		     drawPlanePath( plain);
		     
	    	   }
		     blinkDot(plain) ;	
             
		     }
	    	   else{
	    		   cnx.save();
	  		     cnx.beginPath();
	  		     cnx.translate(plain.point.x,plain.point.y);
	  		     cnx.rotate(getAngle(plain.point,plain.target));
	  		     cnx.drawImage(image,-plain.w/2,-plain.h/2);
	  		    
	  		     cnx.translate(0,0);
	  		     cnx.closePath();
	  		      
	  		     cnx.restore();
	  		     if(isHovered==true && whoHovered==plain.name){
	  		     drawRectangle(plain);
	  		     drawPlanePath( plain);
	  	    	   }
	    		   
	    	   }
  }

 // let plains =[new Plain("p1","blue"),new Plain("p2","brown"),new Plain("p3","gray"),new Plain("p4","blue"),new Plain("p5","blue")];
let plains=[new Plain("p1"),new Plain("p2"),new Plain("p3"),new Plain("p4"),new Plain("p5"),new Plain("p6"),new Plain("p7"),new Plain("p8"),new Plain("p9")];


 
  function movePlain(){
       
        
    setInterval(()=>{
     
     fetch("http://localhost:8080/Project1/update")
     .then(response=>response.json())
     .then(point=>{
       
		      point.forEach((p,i)=>{
		        plains[i].point.x=p.source.x; 
		          plains[i].point.y=p.source.y; 
		          plains[i].target.x=p.target.x; 
		          plains[i].target.y=p.target.y;  
		          plains[i].index=p.nsa;
		          plains[i].path=p.path;
		          plains[i].points=p.points;
		          fogs=p.fogs;
          
      });
    
		      color = !color;
			  
     })
     .catch(err=>err.message)
    
     cnx.clearRect(0,0,width,height);
     drawAirports();
     if(fogs.length!=0)
         fogs.forEach(p=>{createFog(p)});
     drawPlains(plains);
     slowFog();
    },100);}
 
  function isMouseOverRectangle(mouseX, mouseY,plain) {
	  // The x and y coordinates are the center of the rectangle
	  // so we need to calculate the top-left corner
	  let rectLeft = plain.point.x - plain.w / 2;
	  let rectTop = plain.point.y - plain.h / 2;
	  let rectRight = rectLeft + plain.w-5;
	  let rectBottom = rectTop + plain.h-5;
	  
	  // Check if the mouse is inside the bounds of the rectangle
	  if (mouseX >= rectLeft && mouseX <= rectRight && mouseY >= rectTop && mouseY <= rectBottom) {
	    return true;  // The mouse is over the rectangle
	  } else {
	    return false;  // The mouse is not over the rectangle
	  }
	}
  function isMouseOverRectangleAir(mouseX, mouseY,air) {
	  // The x and y coordinates are the center of the rectangle
	  // so we need to calculate the top-left corner
	  
	  
	  // Check if the mouse is inside the bounds of the rectangle
	  if (mouseX >= air.position.x-10 && mouseX <= air.position.x +30 && mouseY >= air.position.y-10 && mouseY <= air.position.y+25) {
	    return true;  // The mouse is over the rectangle
	  } else {
	    return false;  // The mouse is not over the rectangle
	  }
	}


	canvas.addEventListener('mousemove', (event) => {
	  // Get the mouse position
	  const mouseX = event.offsetX;
	  const mouseY = event.offsetY;
	  for(let fog of fogs){
	  if (event.x > fog.x - 50 && event.x < fog.x + 50 && event.y > fog.y - 50 && event.y < fog.y + 50) {
          // show information table
          fx = event.x;
          fy = event.y;
          //alert(fx+","+fy);
          isHoveredFrog=true;
          break;
      } else {
       
    	  isHoveredFrog=false;
    	
      }
	  }
	  // Loop through all of the rectangles
	  for (let rect of plains) {
		
	    // Check if the mouse is over the rectangle
	    if (isMouseOverRectangle(mouseX, mouseY, rect)) {
	      // The mouse is over the rectangle, so display the details
	      isHovered=true;
	      whoHovered=rect.name;
	     
	      break;  // No need to check the other rectangles
	    }
	  }
	});
	canvas.addEventListener('click', (event) => {
		 if(isHovered){
			 isHovered=false;
			  
			  
		 }
		 if(isHoveredAir){
			 isHoveredAir=false;
		 }
		 //airport click
		  const mouseX = event.offsetX;
	  const mouseY = event.offsetY;
         
	  // Loop through all of the rectangles
	  for (let rect of airoprts) {
		
	    // Check if the mouse is over the rectangle
	    if (isMouseOverRectangleAir(mouseX, mouseY,rect)) {
	      // The mouse is over the rectangle, so display the details
	      isHoveredAir=true;
	      whoHoveredAir=rect.name;
	      
	      airx=mouseX;
	      airy=mouseY;
	      
	      
	      break;  // No need to check the other rectangles
	    }
	  }
		 
		});

	function slowFog(){
		for(let plain of plains){
			for(let fog of fogs){
				
		if (plain.point.x > fog.x - 50 && plain.point.x < fog.x + 50 && plain.point.y > fog.y - 50 && plain.point.y < fog.y + 50) {
	          // show information table
	          plain.fog=true;
	          let s=.5;
	          fetch("http://localhost:8080/Project1/update?speed="+s+"&name="+plain.name)
	          .then(response => response.text())
	          .then(data => {
	            // handle the response here
	          })
	          .catch(error => {
	            console.log('Error:', error);
	          });
	          
	          break;
	          
	      } else {
	    	   plain.fog=false;
	    	  let s=2;
	    	  
	          fetch("http://localhost:8080/Project1/update?speed="+s+"&name="+plain.name)
	          .then(response => response.text())
	          .then(data => {
	            // handle the response here
	          })
	          .catch(error => {
	            console.log('Error:', error);
	          });
	    	
	      }
		}
			}
	}

	function drawRectangle(plain) {
	 
	    cnx.beginPath();
	    cnx.rect(plain.point.x+plain.w/2, plain.point.y+plain.h/2, 170, 70);
	    cnx.fillStyle = '#d0d0d0';
	    
	    cnx.fill();
	    cnx.closePath();

	    cnx.beginPath();
	    cnx.font="10px Arial";
	  cnx.fillStyle = 'black';
	  let nextair=plain.path[plain.index];
	  cnx.fillText(`next airport : `+plain.path[plain.index],plain.point.x+5+plain.w/2, plain.point.y+10+plain.h/2);
	    cnx.closePath();
	    cnx.beginPath();
	    cnx.font="10px Arial";
	  cnx.fillStyle = 'black';
	
	  cnx.fillText(`distance left next airport : `+ calculateDistance(plain.point,plain.points[plain.index])+` Km`,plain.point.x+5+plain.w/2, plain.point.y+20+plain.h/2);
	    cnx.closePath();
	    cnx.beginPath();
	    cnx.font="10px Arial";
	  cnx.fillStyle = 'black';
	     let s=Math.floor(Math.random() * (300 - 250 + 1)) + 250;
	     if(calculateDistance(plain.point,plain.points[plain.index])<10)
	    	 s=50;
	     
	  cnx.fillText(`Speed: `+s+` Km`,plain.point.x+5+plain.w/2, plain.point.y+30+plain.h/2);
	    cnx.closePath();
	    cnx.beginPath();
	    cnx.font="10px Arial";
	  cnx.fillStyle = 'black';
	     let c=Math.floor(Math.random() * (25 - 20 + 1)) + 20;
	     
	     
	  cnx.fillText(`weather: `+c+` C`,plain.point.x+5+plain.w/2, plain.point.y+40+plain.h/2);
	    cnx.closePath();
	    cnx.beginPath();
	    cnx.font="10px Arial";
	  cnx.fillStyle = 'black';
	    
	  cnx.fillText(`destination: `+plain.path[plain.path.length-1],plain.point.x+5+plain.w/2, plain.point.y+50+plain.h/2);
	    cnx.closePath();
	   
	}
	function calculateDistance( a, b){
		
		return parseInt(Math.sqrt(Math.pow(a.x-b.x,2)+Math.pow(a.y-b.y,2)));
		
	}
	
	function displayText(x, y, city){
		  cnx.font = "bold 17px tahoma";
		  cnx.fillStyle = "#1C1C1C";
		  cnx.fillText(city, x, y);
		}
	
	function displayText2(x, y, text){
		  cnx.font = "11px tahoma";
		  cnx.fillStyle = "#000";
		  cnx.fillText(text, x, y);
		}
	
	function drawAiroportInfo(airport){
	   
	    displayText(airx+10,airy+15, airport.name);
	    displayText2(airx+5,airy+29, "Pistes: " + airport.pistes);
	    displayText2(airx+5,airy+39, "Places au sol: " + airport.places_au_sol + " UT");
	    displayText2(airx+5,airy+49, "Attente au sol: " + airport.attente_au_sol + " UT");
	    displayText2(airx+5,airy+59, "Accès aux pistes: " + airport.acces_aux_pistes + " UT");
	    displayText2(airx+5,airy+69, "Durée atter/décol: " + airport.duree_atterissage_decollage + " UT");
	    displayText2(airx+5,airy+79, "Anti-collision(inter att./décol.): " + airport.anti_collision + " UT");
	    displayText2(airx+5,airy+89, "Boucle d'attente: " + airport.boucle_attente + " UT");
	}
	
	
	
  function getAngle(source,target){
	  
	  
	    deltaX = target.x - source.x;
	    deltaY = target.y - source.y;
	   
	    angle = Math.atan2( deltaY, deltaX );
	   
	   
	   return (Math.PI-(Math.PI/2-angle));
	   
	 }
  function findInsertionIndex(point, pathArray) {
	    for (let i = 0; i < pathArray.length - 1; i++) {
	        let pathPoint = pathArray[i];
	        let nextPathPoint = pathArray[i + 1];
	        if (isPointOnPath(point, [pathPoint, nextPathPoint])) {
	            return i ;
	        }
	    }
	    return pathArray.length-1;
	}

  function isPointOnPath(point, pathArray) {
	    return pathArray.some(function(pathPoint, index) {
	        if (index === pathArray.length - 1) {
	            return false;
	        }
	        let nextPathPoint = pathArray[index + 1];
	        let minX = Math.min(pathPoint.x, nextPathPoint.x);
	        let maxX = Math.max(pathPoint.x, nextPathPoint.x);
	        let minY = Math.min(pathPoint.y, nextPathPoint.y);
	        let maxY = Math.max(pathPoint.y, nextPathPoint.y);

	        return point.x >= minX && point.x <= maxX && point.y >= minY && point.y <= maxY;
	    });
	}

  function drawPlanePath( plain) {
    
	   if(plain.index>1){
		   plain.prePoint=plain.points[plain.index-2];   
		   cnx.beginPath();
			  cnx.setLineDash([5, 5]); // set the line dash pattern
			  cnx.strokeStyle = "blue";// set the stroke color
			  cnx.lineWidth = 2;
			  cnx.moveTo(plain.points[0].x, plain.points[0].y);
			  plain.points.forEach((point,index)=>{
				  if(index<plain.index)
			    cnx.lineTo(point.x, point.y);
				  else{
					  cnx.lineTo(plain.point.x, plain.point.y); 
				  }
			  });
			  
			  cnx.stroke();
	   }
	   else{
		   
		    
		   cnx.beginPath();
			  cnx.setLineDash([5, 5]); // set the line dash pattern
			  cnx.strokeStyle = "blue";// set the stroke color
			  cnx.lineWidth = 2;
			  cnx.moveTo(plain.points[0].x, plain.points[0].y);
			

			    cnx.lineTo(plain.point.x, plain.point.y);
				  
				  
			 
			  
			  cnx.stroke();
	 
	   }
	  
	  

	}
 

  let infoTable = {x: 0, y: 0, visibility: false};
  function drawFog(point){
	  cnx.fillStyle = "#d0d0d0";
	  cnx.fillRect(point.x, point.y, 150, 75);
	  cnx.fillStyle = "black";
	  cnx.font = "14px Arial";
	  cnx.fillText("Temperature: " + fog.temperature + "°C", point.x + 10, point.y + 20);
	  cnx.fillText("Pressure: " + fog.pressure + "hPa", point.x + 10, point.y + 40);

  }
  
  function createFog(point) {
     
      fog.temperature =Math.round( Math.random() * 10 + 10); // random temperature between 20 and 30
      fog.pressure = Math.round(Math.random() * 100 + 1013); // random pressure between 1013 and 1113
    
      let fogGradient = cnx.createRadialGradient(point.x, point.y, 0, point.x, point.y, 50);
      fogGradient.addColorStop(0, "rgba(0, 255, 255, 0.5)");
      fogGradient.addColorStop(1, "rgba(0, 255, 255, 0)");
      cnx.fillStyle = fogGradient;
      cnx.fillRect(point.x - 50, point.y - 50, 100, 100);
     

     
  }
 


  movePlain();
  



    </script>
</body>
</html>