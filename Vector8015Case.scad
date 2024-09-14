// OpenSCAD 2019.05
// Vector 8015 proto-board support structure
//
// Joe Haas, KE0FF, Circa Jan, 2024
// This support frame is for the Vector P/N 8015 pad-per-hole prototype PCB which is available from any distributor of
//		Vector products (such as mouser.com or digikey.com).  It provides a stable base using the 8 mounting holes
//		along the PCB periphery.  In addition, 4 optional internal support hole locations are provided if additional
//		support is desired.  A template output option is available to aid in the location and drilling of these 4 holes
//		in the Vector board (optional).  The 4 holes are modeled to fall on existing PCB pad locations, which aids in
//		drilling (or marking of the boss locations, on the bottom side of the PCB, should only unilateral support be
//		required).
//
//	Holes sized to accept banana jacks are placed on the "front panel" of the support frame to allow for the placement
//		of switches or jacks as might be required for a given application.
//
// Rev-2a, 9/13/2024
//	Updated template model
//	moved main and template into modules
//	Added flag variable for optional bosses
//
// Rev-2, 4/06/2024
//	Added 4 internal bosses for protoboard
//	Added dedge chams
//	Added corner and lattice bracing
//	Added "btip()" and "btip_wash" reducing hardware to support 1/4" front panel jacks/switches
//
//----------------------------------------------------------------------------------------------------------------------
// User defined parameters.  Modify these to suit a particular application
// NOTE: All data in this file is in mm
//----------------------------------------------------------------------------------------------------------------------
// parametric variables:

pcbx = 6*25.4;
pcby = 4*25.4;
width = pcbx+2;
depth = pcby+35;
height = 10;
fpht = 30;
ght = 8;
gx = 20;
gy = gx;
gthk = 2;
wall = 3;
fpwall = 4;
cham = 1;
optboss = 1;			// set to "0" to disable optional PCB bosses, "1" to enable

////////////////////////////////////////////////////////////////////////////////
// un-comment to render each part (!! only one part at a time !!).

//template();		// PCB hole placement template
main();				// main base model
//btip();			// 1/4" reducer adapter for front-panel
//btip_wash();		// 1/4" washer companion for the reducer adapter

////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// Composite (debug) plot.  Places all elements in an
//	assembly orientation if no 3D parts are enabled (above)


//
//
//**************************************************
				//****************\\
				//    modules     \\
				//    follow      \\
				//****************\\
//**************************************************

module template(){
	// hole template
	difference(){
		translate([0,0,4]) cube([pcbx,pcby,0.6]);
		pcb(pplot=1);
	}
}

module main(){
	// main case
	difference(){
		case();
		// pot/banana holes
		translate([20,20+fpwall,20]) rotate([90,0,0]) pot(diff=0);
		translate([50,20+fpwall,20]) rotate([90,0,0]) pot(diff=1);
		translate([80,20+fpwall,20]) rotate([90,0,0]) pot(diff=1);
		translate([80+(.75*25.4),20+fpwall,20]) rotate([90,0,0]) pot(diff=1);
		translate([80+(2*.75*25.4),20+fpwall,20]) rotate([90,0,0]) pot(diff=1);
		translate([80+(3*.75*25.4),20+fpwall,20]) rotate([90,0,0]) pot(diff=1);
	}
}

//
//
///////////////
// Main case

module case(){
	translate([wall-2,33,wall-.1]) pcb(option=optboss);
	// stiffeners
	translate([wall-0.01,(depth/3)-8,.01]) cube([width-(2*wall)+.1,gthk,ght]);
	translate([wall-0.01,2*depth/3,.01]) cube([width-(2*wall)+.1,gthk,ght]);

	translate([width/3,wall-.01,.01]) cube([gthk,depth-(2*wall)+.1,ght]);
	translate([2*width/3,wall-.01,.01]) cube([gthk,depth-(2*wall)+.1,ght]);
	// cross-x, 0
	translate([wall-0.01,.5*gthk,2]) rotate([0,0,45]) cube([gthk+2,gthk+2,ght-2]);
	translate([(width/3)+(gthk/2),.5*gthk,2]) rotate([0,0,45]) cube([gthk+2,gthk+2,ght-2]);
	translate([(2*width/3)+(gthk/2),.5*gthk,2]) rotate([0,0,45]) cube([gthk+2,gthk+2,ght-2]);
	translate([width-(1.5*gthk),.5*gthk,2]) rotate([0,0,45]) cube([gthk+2,gthk+2,ght-2]);
	// cross-x, 1
	translate([wall-0.01,(depth/3)-9.8,2]) rotate([0,0,45]) cube([gthk+2,gthk+2,ght-2]);
	translate([(width/3)+(gthk/2),(depth/3)-11,2]) rotate([0,0,45]) cube([gthk+4,gthk+4,ght-2]);
	translate([(2*width/3)+(gthk/2),(depth/3)-11,2]) rotate([0,0,45]) cube([gthk+4,gthk+4,ght-2]);
	translate([width-(1.5*gthk),(depth/3)-9.8,2]) rotate([0,0,45]) cube([gthk+2,gthk+2,ght-2]);
	// cross-x, 2
	translate([wall-0.01,(2*depth/3)-gthk,2]) rotate([0,0,45]) cube([gthk+2,gthk+2,ght-2]);
	translate([(width/3)+(gthk/2),(2*depth/3)-gthk-1.2,2]) rotate([0,0,45]) cube([gthk+4,gthk+4,ght-2]);
	translate([(2*width/3)+(gthk/2),(2*depth/3)-gthk-1.2,2]) rotate([0,0,45]) cube([gthk+4,gthk+4,ght-2]);
	translate([width-(1.5*gthk),(2*depth/3)-gthk,2]) rotate([0,0,45]) cube([gthk+2,gthk+2,ght-2]);
	// cross-x, 3
	translate([wall-0.01,depth-(3*gthk),2]) rotate([0,0,45]) cube([gthk+2,gthk+2,ght-2]);
	translate([(width/3)+(gthk/2),depth-(3*gthk),2]) rotate([0,0,45]) cube([gthk+2,gthk+2,ght-2]);
	translate([(2*width/3)+(gthk/2),depth-(3*gthk),2]) rotate([0,0,45]) cube([gthk+2,gthk+2,ght-2]);
	translate([width-(1.5*gthk),depth-(3*gthk),2]) rotate([0,0,45]) cube([gthk+2,gthk+2,ght-2]);

	// signature
	translate([(width/2)-17,(depth/2)+50,wall-.1]) linear_extrude(1.3) text("VECTOR", size=6);
	translate([(width/2)-9,(depth/2)+40,wall-.1]) linear_extrude(1.3) text("8015", size=6);

	translate([(width/2)-10.5,depth/2,wall-.1]) linear_extrude(1.3) text("JHAAS", size=6);
	translate([(width/2)-21,(depth/2)-10,wall-.1]) linear_extrude(1.3) text("MkII 4/06/24", size=6);
	// hogouts
	difference(){
		union(){
			cube([width,depth,height]);
			cube([width,fpwall,fpht]);
		}
		// main hog-out
		translate([wall,fpwall,wall]) cube([width-(2*wall),depth-(fpwall+wall),height]);
		// side chams
		translate([-cham,-.01,-.01]) rotate([0,45,0]) cube([sqrt(2)*cham,depth+10,sqrt(2)*cham]);
		translate([width-cham,-.01,-.01]) rotate([0,45,0]) cube([sqrt(2)*cham,depth+10,sqrt(2)*cham]);
		translate([-cham,-.01,fpht-.01]) rotate([0,45,0]) cube([sqrt(2)*cham,depth+10,sqrt(2)*cham]);
		translate([width-cham,-.01,fpht-.01]) rotate([0,45,0]) cube([sqrt(2)*cham,depth+10,sqrt(2)*cham]);
		// F/B chams
		translate([-cham,-.01,-cham]) rotate([45,0,0]) cube([width+10,sqrt(2)*cham,sqrt(2)*cham]);
		translate([-cham,-.01,fpht-cham]) rotate([45,0,0]) cube([width+10,sqrt(2)*cham,sqrt(2)*cham]);
		translate([-cham,fpwall-.01,fpht-cham]) rotate([45,0,0]) cube([width+10,sqrt(2)*cham,sqrt(2)*cham]);
		translate([-cham,depth,-cham]) rotate([45,0,0]) cube([width+10,sqrt(2)*cham,sqrt(2)*cham]);
		// vertical chams
		translate([0,0,0]) rotate([0,0,45]) cube([sqrt(2)*cham,sqrt(2)*cham,3*fpht], center=true);
		translate([width,0,0]) rotate([0,0,45]) cube([sqrt(2)*cham,sqrt(2)*cham,3*fpht], center=true);
		translate([0,depth,0]) rotate([0,0,45]) cube([sqrt(2)*cham,sqrt(2)*cham,3*fpht], center=true);
		translate([width,depth,0]) rotate([0,0,45]) cube([sqrt(2)*cham,sqrt(2)*cham,3*fpht], center=true);
		translate([0,fpwall,fpht+height]) rotate([0,0,45]) cube([sqrt(2)*cham,sqrt(2)*cham,2*fpht], center=true);
		translate([width,fpwall,fpht+height]) rotate([0,0,45]) cube([sqrt(2)*cham,sqrt(2)*cham,2*fpht], center=true);
	}
}

////////////
// PCB model -- Vector P/N: 8015
h1x = 2.4;
h1y = 25.4;
h2x = h1x;
h2y = h1y+51;
h3x = h1x+147.4;
h3y = h1y;
h4x = h3x;
h4y = h2y;

h5x = 24.2;
h5y = 2.4;
h6x = h5x;
h6y = h5y+96.6;
h7x = h5x+104.1;
h7y = 2.4;
h8x = h7x;
h8y = h7y+96.6;

bossdia = 6.5;
screwdia = 1.5+.4;

module pcb(board=false, bht=10, pplot=0, option=1){
	if(board){
		translate([0,0,bht]) difference(){
			cube([pcbx,pcby,1.6]);
			translate([h1x,h1y,0]) cylinder(r=2.4/2, h = 5, center=true, $fn=16);
			translate([h2x,h2y,0]) cylinder(r=2.4/2, h = 5, center=true, $fn=16);
			translate([h3x,h3y,0]) cylinder(r=2.4/2, h = 5, center=true, $fn=16);
			translate([h4x,h4y,0]) cylinder(r=2.4/2, h = 5, center=true, $fn=16);
	
			translate([h5x,h5y,0]) cylinder(r=2.4/2, h = 5, center=true, $fn=16);
			translate([h6x,h6y,0]) cylinder(r=2.4/2, h = 5, center=true, $fn=16);
			translate([h7x,h7y,0]) cylinder(r=2.4/2, h = 5, center=true, $fn=16);
			translate([h8x,h8y,0]) cylinder(r=2.4/2, h = 5, center=true, $fn=16);
			}
	}
	translate([h1x,h1y,0]) boss(pilot=pplot);
	translate([h2x,h2y,0]) boss(pilot=pplot);
	translate([h3x,h3y,0]) boss(pilot=pplot);
	translate([h4x,h4y,0]) boss(pilot=pplot);

	translate([h5x,h5y,0]) boss(pilot=pplot);
	translate([h6x,h6y,0]) boss(pilot=pplot);
	translate([h7x,h7y,0]) boss(pilot=pplot);
	translate([h8x,h8y,0]) boss(pilot=pplot);

	if(option==1){
		// opt bosses
		translate([h1x+35.6,h1y+(.1*25.4/2),0]) boss(skirt=1,pilot=pplot);
		translate([h2x+35.6,h2y-(.1*25.4/2),0]) boss(skirt=1,pilot=pplot);
		translate([h3x-35.6,h1y+(.1*25.4/2),0]) boss(skirt=1,pilot=pplot);
		translate([h4x-35.6,h2y-(.1*25.4/2),0]) boss(skirt=1,pilot=pplot);
	}
}


////////////
// mtg boss
module boss(bbht=12, skirt=0, pilot=0){
	if(pilot==1){
		cylinder(r=screwdia, h = 3*bbht, center=true, $fn=16);
	}else{
		difference(){
			union(){
				cylinder(r=bossdia/2, h = bbht, $fn=32);
				if(skirt){
					cylinder(r1=7, r2=3, h=5, $fn=32);
				}
			}
			cylinder(r=screwdia/2, h = 3*bbht, center=true, $fn=16);
		}
	}
}

////////////
// 10T pot
module pot(diff=false){
	if(diff){
		cylinder(r=10.8/2, h=2+19.8, $fn=32);
		cylinder(r=9.7/2, h=20+19.8, $fn=32);
	}else{
		cylinder(r=10.8/2, h=2+19.8, $fn=32);
		cylinder(r=9.6/2, h=7.3+19.8, $fn=32);
		cylinder(r=6.3/2, h=19+19.8, $fn=32);
		cylinder(r=22.2/2, h=19.8, $fn=64);
	}
}


////////////
// banana/tip jack adapter

module btip(){
	difference(){
		union(){
			cylinder(r=(9.7/2)-.1, h=fpwall+1, $fn=32);
			cylinder(r=15/2, h=1.5, $fn=64);
		}
		translate([0,0,-.1]) cylinder(r=(6.4/2)+.1, h=fpwall+10, $fn=16);
	}
}

////////////
// banana/tip jack washer

module btip_wash(){
	difference(){
		union(){
			cylinder(r=15/2, h=1.5, $fn=64);
		}
		translate([0,0,-.1]) cylinder(r=(6.4/2)+.1, h=fpwall+10, $fn=16);
	}
}

/////////////////////////////////////
// generic countersink

module cs(screw=4){
	if(screw == 2){
		translate([0,0,.6]) cylinder(r1=4.57/2, r2=2.18/2, h=1.5, $fn=32, center = true);	// #2 countersinks
	}else{
		translate([0,0,.78]) cylinder(r1=6.02/2, r2=2.84/2, h=2, $fn=32, center = true);	// #4 countersinks
	}
}

/////////////////////
// generic pilot hole

module pilot(diameter=2){
  union(){
	rotate([90,0,0]) cylinder(d=diameter, h=10, $fn=32, center=true);
  }
}

/////////////////////////
// debug artifacts
//
// X-rulers
//#translate([-.69,0,0]) cube([0.01,30,50]);	// ruler
//#translate([175.41,0,0]) cube([0.01,30,50]);	// inside main void ruler 1
//#translate([1.67,0,0]) cube([0.01,30,50]);	// inside main void ruler 2
//#translate([175.34,0,0]) cube([0.01,30,50]);	// outside shroud ruler 2
// Y-rulers
//#translate([0,23.81,0]) cube([180,0.01,50]);	// ruler
//#translate([0,22.36 ,0]) cube([180,0.01,50]);	// ruler
// Z-rulers
//#translate([0,0,0]) cube([10,40,.01]);	// ruler
//#translate([0,0,2.04]) cube([9,40,.01]);	// ruler

// EOF
