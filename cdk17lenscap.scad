inchesToMM = 25.4;

capInner= 5.3 * inchesToMM;
capLength = 1.3 * inchesToMM;
thickness = .05 * inchesToMM;
capOuter = capInner+thickness;


module capO ()
{
    cylinder (h = capLength, d = capOuter, $fn = 128);
}
module capI ()
{
    cylinder (h = capLength, d = capInner, $fn = 128);
}




module thing ()
{
    difference()
    {
        capO();
        translate([0,0,thickness])
        capI();
    }
}
thing();