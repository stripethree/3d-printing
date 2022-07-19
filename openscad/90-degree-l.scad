insideRadius=15;
outsideRadius=20;
lengthOfArm=50;

difference() {
    union() {
        cylinder (lengthOfArm,outsideRadius,outsideRadius);
        rotate([0,90,0])
            cylinder (lengthOfArm*2,outsideRadius,outsideRadius);
        sphere(r=outsideRadius);
    }

    cylinder (lengthOfArm+1,insideRadius,insideRadius);
    rotate([0,90,0])
        cylinder (lengthOfArm*2+1,insideRadius,insideRadius);
    sphere(r=insideRadius);
}