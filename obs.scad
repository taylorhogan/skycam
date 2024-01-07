// lukeroberto213@gmail.com


inches = 25.4;
width = 10 * 12;
length = 20 *12;
height = 7 * 12;
wallThickness = 3.5 + 0.5 + 0.75;
cPierSize = 30;
cPierHight = 12;
cPierOffSetX = 10;
cPierOffSetZ = 6;
OTAODiameter = 26;
OTAThickness = 1;
OTALength = 29.7;
mountLength = 42.7;
mountWidth = 12;
mountThickness = 2;

insideWidth = 10*12;
insideLength = 12*12;
floorThickness = 1;

scopePierAboveFloor =12;
scopePierX = 36;
scopePierY = 36;
scopePierZ = 4*12+scopePierAboveFloor;


angleFromNorth=20;
latitude=41.5;
wedgeX = 2;


module floor ()
{
    cube([insideWidth, insideLength, floorThickness]);
}
module scopePier()
{
    
   cube([scopePierX, scopePierY, scopePierZ]);
}
    

module centerMarker()
{
     cylinder(h = 7*12, r = 1, center=false,$fn=128);
}


module drillX(x, y, z, diameter, l)
{
    translate([0,y, z])
    {     
        {  
            rotate([0,90,0])
            {                         
                cylinder(h=l,d=diameter, center=true,$fn=128);
            }
        }
    }
}


module drawWedge ()
{

}

module drawOTA ()
{
    difference ()
        {
            cylinder( d = OTAODiameter, OTALength, center=true);
            
            
        }
}





module drawFrame ()
{
    color ("black", 1.0)
    {
        translate([0,0,0])
        {
            difference()
            {     
                cube ([width + (wallThickness * 2), height, length + (wallThickness * 2)]);
                translate ([wallThickness, 0, wallThickness])
                {
                    cube ([width , height * 2, length ]);
                }       
            
            }   
        }
    }
}





module walls ()
{
    difference ()
    {
         cube ([insideWidth + wallThickness, insideLength + wallThickness, 7*12]);
         cube ([insideWidth , insideLength , 7*12]);
    }
   
    
}
module mount()
{
    cube([6, 42, 12]);
}
module metalPier()
{
    cylinder(d=24,h=12,center=true);
}
scopeDisplacementX = cos(latitude)*mountLength + wedgeX;
echo (scopeDisplacementX);

dx = sin (angleFromNorth) * scopeDisplacementX;
dy = cos (angleFromNorth) * scopeDisplacementX;
echo(dx, dy);

centerX = insideWidth/2;
centerY= insideLength/2;

color("yellow") floor();
color("green") translate ([centerX, centerY, 1]) centerMarker();



pierCenterX = centerX-dx;
pierCenterY = centerY-dy;
echo (pierCenterX, pierCenterY);
color("green") translate ([pierCenterX, pierCenterY, 1]) centerMarker();
//translate([pierCenterX, pierCenterY, scopePierAboveFloor])text(size=2,"center");

color ("red") translate ([48.4-scopePierX/2, 40-scopePierY/2,-scopePierZ+scopePierAboveFloor]) scopePier();
color ("red") translate ([centerX-dx-scopePierX/2, centerY-dy-scopePierY/2,-scopePierZ+scopePierAboveFloor]) scopePier();

color("orange") translate ([pierCenterX, pierCenterY, scopePierAboveFloor+12/2]) metalPier();


color("white") translate ([pierCenterX, pierCenterY+2+6,scopePierAboveFloor+12+13])rotate([latitude,0,-20]) mount();
//color("black",0.5) translate ([centerX, centerY, 12+13.5+28.3+OTALength]) drawOTA();

color("black",0.5) translate ([centerX, centerY+15, 12+13.5+28.3+10]) rotate([270,0,0]) drawOTA();

color("black",0.5) translate ([centerX, centerY-10, 12+13.5+28.3+10+10+5]) rotate([135+90+10,0,-20]) drawOTA();
color("brown", 0.4) walls();

