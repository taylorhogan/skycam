inchesToMM = 25.4;

plugOuter = 1.380 * inchesToMM;
plugLength = 1 * inchesToMM;

capOuter = 2.125 * inchesToMM;
capLength = .330 * inchesToMM;
smidge =.015;

screwHoleDiameter = (smidge +.270) * inchesToMM;
boltHoleDiameter = (smidge + .375) * inchesToMM;

boltHeight = 1 * inchesToMM;
screwLength = (plugLength+capLength);

botToBoltLength = capLength;

module cap ()
{
    cylinder (h = capLength, d = capOuter, $fn = 256);
}

module plug ()
{
    cylinder (h = plugLength+capLength, d = plugOuter, $fn = 256);
}

module screwHole ()
{
    color ("red")
    {
        cylinder (h = screwLength, d = screwHoleDiameter, $fn=256);
    }
}

module boltHole ()
{
    color ("green")
    {
        cylinder (h = boltHeight, d = boltHoleDiameter, $fn=256);
    }
}

module positive ()
{
    plug();
    cap();
}

module negative ()
{
    screwHole();
    translate ([0,0,botToBoltLength])
    {
        boltHole();
    }
}

module thing ()
{
    difference()
    {
        color("black", .5)  positive();
        negative();
    }
}
thing();