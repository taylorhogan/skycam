// lukeroberto213@gmail.com


inches = 25.4;
smidge = 0.1875 * inches; // manufacturing gap
thickness = .50 * inches;
baseThickness = 10/64*inches;
lHeight = 1.75 * inches;
lWidth = 3.1875 * inches;
lLength = 4.1875 * inches;
holeSep = 1.5 * inches;
holeDiameter = 0.28125 * inches; //9/32
holeFromTop = 1.5 * inches;
drillLength = 2 * inches;
reliefWidth = 1 * inches;
reliefDepth = 0.25 * inches;
smallHoleEdgeOffset = 28.0/64.0 * inches;
smallHoleDiameter = 0.1 * inches;

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

module drillY(x, y, z, diameter, l)
{
    
    {
         color("red",1.0)      
        {
            translate([x, l/2, z])
            rotate([90,0,0])
            {                         
                cylinder(h=l,d=diameter, center=true,$fn=128);
            }
        }
    }
}

module dovetailX (x, y, z, diameter, l)
{

}



module drawReliefsForOverhang ()
{
    color("red", 1.0) 
    {
        translate ([0 - smidge, 0 - smidge, lWidth/2-holeSep/2 - reliefWidth/2])
        {
            cube ([reliefDepth, lHeight+smidge+smidge, reliefWidth]);
        }
        translate ([0 - smidge, 0 - smidge, lWidth/2 + holeSep/2 - reliefWidth/2])
        {
            cube ([reliefDepth, lHeight+smidge+smidge, reliefWidth]);
        }
    }
}

module drawReliefsForBase ()
{
    color("red", 1.0) 
    {
        translate ([0 + thickness+smidge, baseThickness, lWidth/2-holeSep/2 - reliefWidth/2])
        {
            cube ([lLength, thickness+smidge ,reliefWidth]);
        }
        translate ([0 + thickness+smidge, baseThickness, lWidth/2+holeSep/2 - reliefWidth/2])
        {
            cube ([lLength, thickness+smidge ,reliefWidth]);
        }
       
    }
}


module drawBase ()
{
    translate([0,0,0])  
    {
        difference ()
        {
            color ("black", 0.5) cube([lLength, thickness, lWidth]);
            union ()
            {
                color("red",1.0) drillY(1*inches, 0, smallHoleEdgeOffset, smallHoleDiameter, drillLength);
                color("red",1.0) drillY(1*inches, 0, lWidth-smallHoleEdgeOffset, smallHoleDiameter, drillLength);
                color("red",1.0) drillY(4*inches, 0, smallHoleEdgeOffset, smallHoleDiameter, drillLength);
                color("red",1.0) drillY(4*inches, 0, lWidth-smallHoleEdgeOffset, smallHoleDiameter, drillLength);
                drawReliefsForBase ();
            }
        }
    }
}






module drawOverhang ()
{
    
    translate([0,0,0])
    {
        difference()
        {
            color ("black", 1.0) cube([thickness, lHeight, lWidth]);
            union()
            {          
                drillX (0, holeFromTop, lWidth/2 - holeSep/2, holeDiameter, drillLength);
                drillX (0, holeFromTop, lWidth/2 + holeSep/2, holeDiameter, drillLength);     
                drawReliefsForOverhang();
            }
        }
    
    }
}

module geminiBracket ()
{
    drawBase ();
    drawOverhang ();
}

geminiBracket ();

module pipe ()
{
    difference ()
    {
        cylinder(r = 12*inches, h = 12*inches);
        cylinder(r = 11.5*inches, h = 13*inches);
    }
}
//pipe ();

intersection ()
{
    pipe();
    
    drillX (0, 0, 6*inches, 4*inches, 200*inches);

}

