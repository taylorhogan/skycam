// TODO
// Compass Rose
// Stop for Top
// Cable Hole

// Everything is in mm

smidge = 0.2;
outsideDiameter = 120;
capThickness = 3.0;
capHeight = 2*capThickness;
cameraHoleDiameter=51;
supportHeight = 23;
cameraScrewHoleDiameter= 6.2;
cameraDepth=23;
baseHeight = 120;
airHoleSize=5;
cordHoleDiameter=10;
usbCHeight=7;
usbCWidth=13;
domeHoleFromOutside = 4.5;
overhangWidth=10;
domeThickness = 3.0;
overhangHeight = capHeight+capThickness + domeThickness;
grommetLength = capThickness*4;
usbHoleFromBot = 20;





module overhang ()
{
    difference ()
    {
        difference ()
        {
            cylinder (h = overhangHeight, d = outsideDiameter+capThickness, center = false, $fn=128);
            translate ([0,0, capThickness])
            {
              cylinder (h = overhangHeight, d = outsideDiameter, center=false, $fn=128);
            }
        }
        cylinder (h = capHeight, d = outsideDiameter-overhangWidth-capThickness*2, center = false, $fn=128);
    }
}

module cap ()
{
    difference() 
    {
        difference ()
        {
            cylinder (h = capHeight, d = outsideDiameter, center = false, $fn=128);
            translate ([0,0, capThickness])
            {
            cylinder (h = capHeight, d = outsideDiameter-capThickness, center=false, $fn=128);
            }
        }
        translate ([0,0, -capThickness])
        {         
            cylinder (h = capHeight, d = cameraHoleDiameter, center=false, $fn=128);
        }
    }
}

module cameraSupport ()
{
    difference() 
    {
        difference ()
        {
            cylinder (h = supportHeight + capThickness, d = outsideDiameter-capThickness-smidge, center = false, $fn=128);
            translate ([0,0, capThickness])
            {
                cylinder (h = supportHeight, d = outsideDiameter-capThickness-smidge-capThickness, center=false, $fn=128);
            }
        }
        translate ([0,0, -capThickness])
        {         
            cylinder (h = capHeight, d = cameraScrewHoleDiameter, center=false, $fn=128);
        }
    }
}
module base()
{
     difference ()
        {
            cylinder (h = baseHeight, d = outsideDiameter, center = false, $fn=128);
            translate ([0,0, capThickness])
            {
            cylinder (h = baseHeight, d = outsideDiameter-capThickness, center=false, $fn=128);
            }
        }
}

module usbHole ()
{
    translate ([-outsideDiameter/2,-usbCWidth/2,usbHoleFromBot])
    {
        rotate([0,90,0])
        {
            cube([usbCHeight, usbCWidth, grommetLength],false);
            translate([usbCHeight/2,0,0])
            {
                cylinder(h= grommetLength, d=usbCHeight, center=false,$fn=128);
            }
            translate([usbCHeight/2,usbCWidth,0])
            {
                cylinder(h= grommetLength, d=usbCHeight, center=false,$fn=128);
            }
            
        
        }
    }
}


module cordHole()
{
    translate ([-outsideDiameter/2,0,usbHoleFromBot-usbCHeight/2])
    {
        rotate([0,90,0])
        {
            cylinder(h= grommetLength, d = 5, center=false, $fn=128);
        }
    }
}

module airholePattern()
{
    for ( i = [0 : 45 : 360])
    {
        dx = cos (i) * outsideDiameter/2 * .75;
        dy = sin (i) * outsideDiameter/2 * .75;
        
        translate([dx, dy, -5])
        {            
            cylinder(h= capThickness*10, r = airHoleSize/2, center=false,$fn=128);
        }
    }
}


module p1()
{
    difference ()
    {
        cap();
        airholePattern ();
    }
}
module p2 ()
{
    difference ()
    {
        difference ()
        {
            cameraSupport();
            airholePattern();
        }
        translate([outsideDiameter/2 * .75,0,0]) cube([10,20,100],center=true);
    }
}


module gromett()
{


    difference()
    {
        difference ()
        {
            usbHole();
            cordHole();        
        }
    
        translate ([-outsideDiameter*2,0,usbHoleFromBot])
        {
            rotate([0,90,0])
            {
                 cube([usbCHeight, .5, grommetLength*100],false);                   
            }
    }
    
    }
}

module testUsbHole()
{
    difference ()
    {
        translate ([-outsideDiameter/2, -50,0])
        {
        cube([capThickness,50,20], false);
        }
        usbHole();
    }
}


module handle ()
{
    difference ()
    {
        union ()
        {
            cube ([75, 12, 6]);
            translate ([75-12/2, 12/2,0]) cylinder(h= 8, d = 10, center=false,$fn=128);
        }
        translate ([75-12/2, 12/2,0])
        {
            cylinder(h= 20, d = 3, center=true,$fn=128);
        }
    }
}
module p3()
{
    
    difference ()
    {
        base();
        usbHole();
    }
}





p3();
translate([0,0,160]) {p2();}
translate([0,0,260])rotate ([0, 180, 0]) {p1();}
translate ([0, 0, 300]) rotate ([0, 180, 0]) {overhang();}

translate ([150, 0, 0]) gromett();
