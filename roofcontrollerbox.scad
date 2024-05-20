inchesToMM = 25.4;

boxInnerX = 3*inchesToMM;
boxInnerY = 3.5*inchesToMM;
boxInnerZ = 2*inchesToMM;
ds = 1;


plateX = 55;
plateY = 115;
stopY = 26;
thickness=6;
stopT =4;
stopH=11;
hole1Y=70;
hole2Y=hole1Y+40;
hole1D=2.3;
hole2D=2.75;

module plate ()
{
    
    cube ([plateX, plateY,thickness]);
    translate ([0, stopY, 0])
    {
        cube ([plateX, stopT,stopH+thickness]);
    }
    cube ([stopT, stopY,stopH+thickness]);
    translate([plateX-stopT, 0,0])
    {
        cube ([stopT, stopY,stopH+thickness]);
    }
    
    
}

module platedrills ()
{
    x = (plateX-40)/2;
    translate ([x + hole1D/2, 80, -thickness * 4])
    {
       color("red") cylinder(100,d=hole1D,$fn=100);
    }
    translate ([x+40 + hole1D/2, 80, -thickness * 4])
    {
        color("red") cylinder(100,d=hole1D,$fn=100);
    }
    translate([plateX-6, 50, 4.75+thickness])
    {
        rotate([90,0,0]) 
        {       
            {
            color("green") cylinder(100,d=hole2D,$fn=100);
            }
        }
    }
    translate([plateX-28, 50, 4.75+thickness])
    {
        rotate([90,0,0]) 
        {       
            {
            color("green") cylinder(100,d=hole2D,$fn=100);
            }
        }
    }
}

module ebox ()
{
    difference()
    {
        color ("black", 1.0) cube ([boxInnerX+ds, boxInnerY+ds,boxInnerZ],center=true);
        {
            translate ([0,0,ds])
            cube ([boxInnerX, boxInnerY,boxInnerZ], center=true);
        }
    }
}


difference()
{
    plate();
    platedrills();
}
//plate();
//ebox();