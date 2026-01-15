// Project Hanoji: Prototype v2 Concept Model
// Description: V-shape ergonomic leverless controller concept

// --- Parameters ---

// View Mode: Select "3D" or "BLUEPRINT" (2D Drawing)
view_mode = "BLUEPRINT";

// 1. Angles
tenting_angle = 15;      // Z-axis rotation (Tenting) [degree]
opening_angle = 30;      // Opening angle for V-shape (Total) [degree]
half_opening_angle = opening_angle / 2;

// 2. Dimensions
split_distance = 50;     // Distance between left and right units at center [mm]
plate_thickness = 5;     // Top plate thickness [mm]
case_height_min = 20;    // Minimum height of the case (front) [mm]

// 3. Button Config
btn_size_action = 24;    // Action button diameter [mm]
btn_size_thumb = 30;     // Thumb/Jump button diameter [mm]
btn_rim = 2;             // Rim size for hole cutout

// --- Modules ---

module button_hole(d) {
    color("DimGray")
    cylinder(h=plate_thickness + 2, d=d, center=true);
}

module button_cap(d) {
    color("Crimson")
    translate([0, 0, plate_thickness/2 + 1])
    cylinder(h=5, d=d-2, center=false);
}

// Left Hand Layout Module
module left_hand_layout() {
    // Left Hand: Movement (Left, Down, Right)
    translate([-40, 50, 0]) { button_hole(btn_size_action); button_cap(btn_size_action); } // Left
    translate([-10, 40, 0]) { button_hole(btn_size_action); button_cap(btn_size_action); } // Down
    translate([ 20, 50, 0]) { button_hole(btn_size_action); button_cap(btn_size_action); } // Right

    // Thumb: Up (Left side up)
    translate([ 30, -10, 0]) { button_hole(btn_size_thumb); button_cap(btn_size_thumb); }
}

// Right Hand Layout Module
module right_hand_layout() {
    // Right Hand: 8 Action Buttons (Vewlix/Noir style)

    // Row 1 (Bottom: Kicks)
    translate([-40, 40, 0]) { button_hole(btn_size_action); button_cap(btn_size_action); } // K1
    translate([-10, 40, 0]) { button_hole(btn_size_action); button_cap(btn_size_action); } // K2
    translate([ 20, 40, 0]) { button_hole(btn_size_action); button_cap(btn_size_action); } // K3
    translate([ 50, 40, 0]) { button_hole(btn_size_action); button_cap(btn_size_action); } // K4

    // Row 2 (Top: Punches)
    translate([-40, 70, 0]) { button_hole(btn_size_action); button_cap(btn_size_action); } // P1
    translate([-10, 75, 0]) { button_hole(btn_size_action); button_cap(btn_size_action); } // P2
    translate([ 20, 75, 0]) { button_hole(btn_size_action); button_cap(btn_size_action); } // P3
    translate([ 50, 70, 0]) { button_hole(btn_size_action); button_cap(btn_size_action); } // P4

    // Thumb: Up (Right side up - optional or Jump)
    translate([-30, -10, 0]) { button_hole(btn_size_thumb); button_cap(btn_size_thumb); }
}


module unit_base_shape() {
    color("LightGrey")
    hull() {
        translate([-60, -30, -case_height_min]) cube([130, 140, 2]); // Bottom plate area
        translate([-60, -30, 0]) cube([130, 140, plate_thickness]);   // Top plate area
    }

    // Palm Rest Area (Simplified)
    color("Silver")
    translate([-60, -100, -case_height_min])
    cube([130, 70, case_height_min + plate_thickness]);
}


module full_assembly() {

    // LEFT UNIT
    translate([-(split_distance/2), 0, 0])
    rotate([0, 0, half_opening_angle]) // Open V-shape
    translate([-60, 0, 0]) // Shift pivot point
    rotate([0, tenting_angle, 0])
    translate([60, 0, 0]) // Shift back
    {
        difference() {
            unit_base_shape();
            translate([0,0,-1]) left_hand_layout();
        }
        left_hand_layout();
    }

    // RIGHT UNIT
    translate([(split_distance/2), 0, 0])
    rotate([0, 0, -half_opening_angle]) // Open V-shape
    translate([60, 0, 0]) // Shift pivot
    rotate([0, -tenting_angle, 0]) // Tenting: Right side goes UP
    translate([-60, 0, 0]) // Shift back
    {
        difference() {
            unit_base_shape();
            translate([0,0,-1]) right_hand_layout();
        }
        right_hand_layout();
    }

    // Connecting Plate (Base) - Simplified representation
    color("Black")
    translate([0, -50, -case_height_min - 2])
    cube([100, 50, 2], center=true);

}

// --- Render Logic ---

$fn = 60; // Smoothness

if (view_mode == "3D") {
    full_assembly();
} else if (view_mode == "BLUEPRINT") {

    // 1. TOP VIEW (Plane XY)
    translate([0, 200, 0]) {
        color("Black") text("TOP VIEW", size=10, halign="center");
        projection(cut=false) full_assembly();
    }

    // 2. FRONT VIEW (Looking from -Y)
    translate([0, 0, 0]) {
        color("Black") text("FRONT VIEW", size=10, halign="center");
        // Rotate so Front faces Up (Z)
        projection(cut=false) rotate([90, 0, 0]) full_assembly();
    }

    // 3. SIDE VIEW (Looking from +X, Right side)
    translate([250, 0, 0]) {
        color("Black") text("SIDE VIEW", size=10, halign="center");
        // Rotate so Right faces Up (Z)
        projection(cut=false) rotate([0, -90, 0]) full_assembly();
    }
}
