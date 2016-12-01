/* ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 ///                                                                                                                                                            ///
 ///                                                                      Flappy Bird.t                                                                         ///
 ///                                                                      A Turing Game                                                                         ///
 ///                                                                                                                                                            ///
 ///                                                                Made By Gr. 10 Students:                                                                    ///
 ///                                                        Anthony Chen, Tiger Dong, and Charlie Zhao                                                          ///
 ///                                                                      With Help By:                                                                         ///
 ///                                                                       Keith Cheng                                                                          ///
 ///                                                                                                                                                            ///
 ///                                                 Project Started Feb. 7th, 2014; Completed Feb. 10th, 2014                                                  ///
 ///                                                                                                                                                            ///
 ///                                                                                                                                                            ///
 ///                                                                                                                                                            ///
 //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// */

var key : array char of boolean
var mousex, mousey, mouseclick : int

var title : int := Pic.FileNew ("title.jpg")
var background : int := Pic.FileNew ("background.jpg")
var credits_title : int := Pic.FileNew ("credits_title.jpg")

var title_font : int := Font.New ("Impact:25:bold")
var score_font : int := Font.New ("Palatino:20:bold")
var credit_font : int := Font.New ("Helvetica:35:bold")
var credit_font2 : int := Font.New ("Helvetica:25:bold")
var credit_font3 : int := Font.New ("Arial:14:bold")
var font : int := Font.New ("Palatino:15")
var font2 : int := Font.New ("Palatino:14:bold")

var credit_size : int := 4

var option1_x1 : int := 103
var option2_x1 : int := 279

var option1_y1 : int := 155
var option2_y1 : int := 155

var margin : int := 5
var margin2 : int := 13
var margin3 : int := 16

var bird_x : int := 125
var bird_y : int := 275
var bird_size : int := 3
var bird_x2 : int := bird_x + bird_size * 17
var bird_y2 : int := bird_y + bird_size * 11
var bird_colour : int := 1
var bird_speed : int := 20

var colour2 : int := 0
var colour_bird_border : int := 19
var colour_bird_orange : int := 42
var colour_bird_yellow : int := 43
var colour_bird_light_yellow : int := 68
var colour_bird_white : int := 0
var colour_bird_grey : int := 29
var colour_bird_red : int := 41
var colour_polygon : int := 48
var colour_button_orange := 42

var pause_margin : int := 2
var pause_margin2 : int := 3
var pause_margin3 : int := 5
var pause_size : int := 30
var pause_x1 : int := 10
var pause_y1 : int := 505

var ready_x : int := 215
var ready_y : int := 250
var ready_size : int := 3
var colour_ready_border : int := 19
var colour_ready_white : int := 0
var colour_ready_red : int := 40

var polygonx : array 1 .. 4 of int := init (0, 10, 24, 14)
var polygony : array 1 .. 4 of int := init (81, 92, 92, 81)

var pipe : array 1 .. 5 of int
var pipe_distance : int := 275
var pipe_gap : int := 200
var btopx, btopy, bbottomx, bbottomy, toppipey : array 1 .. 8 of int
var pipecounter, pipecounter2, pipecounter3, pipecounter4 : int := 1
var pipe_speed : int := -3
var pipeground : int := 100

var performance : string
var performancex : int := 80
var performance_flash : int
var colour_performance : int := 43
var colour_best_performance : int := 43
var best_performance : string := "NONE"

var score, scorecounting, best_score, waiting, death_height, mouse_hover : int := 0

var time_elapsed, bird_velocity : real

var player_ready, exit_to_menu, exit_to_game, mouseclicked, new_score : boolean := false
var super_bird : boolean := false
var super_bird_unlocked : boolean := false

var bird_hover_up : boolean := true
var max_hover_height : int := 295
var min_hover_height : int := 270

var MAX_JUMP : real := 8.3
var ACCEL : real := 0.9

const MAX_EGGS := 7
var easter_egg : array 0 .. MAX_EGGS of int
var easter_eggs : boolean := true
var egg_current : int := 0
var egg_toggle : int := 0
var easter_egg_toggled : boolean := false
var random_egg : int := 0

var dly : int := 15

%Setting some basic numbers

for pipeset : 1 .. 8
    btopx (pipeset) := 645
    btopy (pipeset) := 200
    bbottomx (pipeset) := 650
    bbottomy (pipeset) := 167
    toppipey (pipeset) := 300
end for

for piperandint : 1 .. 8
    randint (bbottomy (piperandint), 110, 350)
    btopy (piperandint) := bbottomy (piperandint) + 33
    toppipey (piperandint) := bbottomy (piperandint) + 200
end for

for EGGS : 0 .. MAX_EGGS
    easter_egg (EGGS) := EGGS
end for

time_elapsed := 0
bird_velocity := 0

setscreen ("graphics: 450, 550, offscreenonly, nobuttonbar")

procedure bird_colour_setter

    if bird_colour = 1 or bird_colour = 2 then
	colour_bird_orange := 42
	colour_bird_yellow := 43
	colour_bird_light_yellow := 68
    elsif bird_colour = 3 then
	colour_bird_orange := 41
	colour_bird_yellow := 42
	colour_bird_light_yellow := 43
    elsif bird_colour = 4 then
	colour_bird_orange := 55
	colour_bird_yellow := 54
	colour_bird_light_yellow := 53
    elsif bird_colour = 5 then
	colour_bird_orange := 34
	colour_bird_yellow := 35
	colour_bird_light_yellow := 36
    elsif bird_colour = 6 then
	colour_bird_orange := 27
	colour_bird_yellow := 29
	colour_bird_light_yellow := 0
    elsif bird_colour = 7 then
	colour_bird_orange := 65
	colour_bird_yellow := 66
	colour_bird_light_yellow := 68
    elsif bird_colour = 8 then
	colour_bird_orange := 2
	colour_bird_yellow := 48
	colour_bird_light_yellow := 46
    elsif bird_colour = 9 then
	colour_bird_orange := 79
	colour_bird_yellow := 78
	colour_bird_light_yellow := 77
    elsif bird_colour = 10 then
	colour_bird_orange := 20
	colour_bird_yellow := 21
	colour_bird_light_yellow := 22
    end if

end bird_colour_setter

procedure easter_egg_reset

    bird_size := 3
    bird_y := 275
    bird_y2 := bird_y + bird_size * 11
    pipe_speed := -3
    ACCEL := 0.9
    MAX_JUMP := 8.3
    super_bird := false

end easter_egg_reset

procedure easter_egg_setter

    if egg_current = 0 then %default
	bird_size := 3
	easter_egg_toggled := false
    elsif egg_current = 1 then %derp
	bird_size := -3
    elsif egg_current = 2 then %midget
	bird_size := 2
	MAX_JUMP := 9.5
    elsif egg_current = 3 then %giant
	bird_size := 10
    elsif egg_current = 4 then %reverse gravity
	bird_size := -3
    elsif egg_current = 5 then %rainbow
    elsif egg_current = 6 then %midget derp
	bird_size := -2
	MAX_JUMP := 9.5
    elsif egg_current = 7 then %super bird
	pipe_speed := -10
	super_bird := true
    end if

    bird_x2 := bird_x + bird_size * 17
    bird_y2 := bird_y + bird_size * 11

end easter_egg_setter

procedure easter_egg_toggler

    if easter_eggs = true then

	if mouseclicked = false then
	    if mouseclick = 1 and player_ready = false then
		if mousex > bird_x and mousex < bird_x2 and mousey > bird_y and mousey < bird_y2 then
		    egg_toggle += 1
		    mouseclicked := true
		    easter_egg_toggled := true
		    easter_egg_reset
		elsif bird_size < 0 and mousex < bird_x and mousex > bird_x2 and mousey < bird_y and mousey > bird_y2 then
		    egg_toggle += 1
		    mouseclicked := true
		    easter_egg_toggled := true
		    easter_egg_reset
		end if
		bird_y2 := bird_y + bird_size * 11
	    end if
	end if

	if mouseclick not= 1 then
	    mouseclicked := false
	end if

	if egg_toggle > MAX_EGGS then
	    egg_toggle := 0
	end if
	egg_current := easter_egg (egg_toggle)
	easter_egg_setter

    end if

end easter_egg_toggler

procedure reset

    bird_x := 125
    bird_y := 275
    bird_x2 := bird_x + bird_size * 17
    bird_y2 := bird_y + bird_size * 11
    player_ready := false
    new_score := false
    easter_egg_reset
    pipe_speed := -3
    score := 0
    for EGGS : 0 .. MAX_EGGS
	easter_egg (EGGS) := EGGS
    end for
    egg_toggle := 0
    egg_current := 0
    easter_egg_toggler
    easter_egg_toggled := false

    randint (bird_colour, 1, 10)
    bird_colour_setter

    polygonx (1) := 0
    polygonx (2) := 10
    polygonx (3) := 24
    polygonx (4) := 14

    pipecounter := 1
    pipecounter2 := 1
    pipecounter3 := 1
    pipecounter4 := 1

    for pipeset : 1 .. 8
	btopx (pipeset) := 645
	btopy (pipeset) := 200
	bbottomx (pipeset) := 650
	bbottomy (pipeset) := 167
	toppipey (pipeset) := 300
    end for

    for piperandint : 1 .. 4
	randint (bbottomy (piperandint), 110, 350)
	btopy (piperandint) := bbottomy (piperandint) + 33
	toppipey (piperandint) := bbottomy (piperandint) + 200
    end for

end reset

procedure rainbow_bird

    if egg_current = 5 then
	randint (colour_bird_orange, 32, 55)
	randint (colour_bird_yellow, 32, 55)
	randint (colour_bird_light_yellow, 32, 55)
    else
	bird_colour_setter
    end if

end rainbow_bird

procedure draw_background

    Pic.Draw (background, 0, 0, picCopy)

end draw_background

procedure draw_ground

    drawfillbox (0, 0, maxx, 100, 67)
    drawfillbox (0, 75, maxx, 78, 66)

    drawfillbox (0, 78, maxx, 81, 119)
    drawfillbox (0, 81, maxx, 94, 46)

    drawfillbox (0, 94, maxx, 97, 68)
    drawfillbox (0, 97, maxx, 100, 16)

    for j : 1 .. 50
	Draw.FillPolygon (polygonx, polygony, 4, colour_polygon)
	for i : 1 .. 4
	    polygonx (i) += 25
	end for
    end for
    Draw.FillPolygon (polygonx, polygony, 4, colour_polygon)

    for i : 1 .. 4
	polygonx (i) -= 1250
    end for

    for i : 1 .. 4
	polygonx (i) += pipe_speed
    end for

    if polygonx (1) <= -450 then
	polygonx (1) := 0
	polygonx (2) := 10
	polygonx (3) := 24
	polygonx (4) := 14
    end if

end draw_ground

procedure draw_ground2

    drawfillbox (0, 0, maxx, 100, 67)
    drawfillbox (0, 75, maxx, 78, 66)

    drawfillbox (0, 78, maxx, 81, 119)
    drawfillbox (0, 81, maxx, 94, 46)

    drawfillbox (0, 94, maxx, 97, 68)
    drawfillbox (0, 97, maxx, 100, 16)

    for j : 1 .. 50
	Draw.FillPolygon (polygonx, polygony, 4, colour_polygon)
	for i : 1 .. 4
	    polygonx (i) += 25
	end for
    end for
    Draw.FillPolygon (polygonx, polygony, 4, colour_polygon)

    for i : 1 .. 4
	polygonx (i) -= 1250
    end for

end draw_ground2

procedure draw_bird

    rainbow_bird

    %orange
    drawfillbox (bird_x + bird_size * 5, bird_y + bird_size, bird_x + bird_size * 10, bird_y + bird_size * 2, colour_bird_orange)  %orange, bottom
    drawfillbox (bird_x + bird_size * 3, bird_y + bird_size * 2, bird_x + bird_size * 9, bird_y + bird_size * 3, colour_bird_orange)  %orange, middle
    drawfillbox (bird_x + bird_size * 5, bird_y + bird_size * 3, bird_x + bird_size * 8, bird_y + bird_size * 4, colour_bird_orange)  %orange, top
    drawfillbox (bird_x + bird_size * 6, bird_y + bird_size * 7, bird_x + bird_size * 7, bird_y + bird_size * 10, colour_bird_yellow)  %yellow, left
    drawfillbox (bird_x + bird_size * 7, bird_y + bird_size * 4, bird_x + bird_size * 8, bird_y + bird_size * 10, colour_bird_yellow)  %yellow, middle
    drawfillbox (bird_x + bird_size * 8, bird_y + bird_size * 4, bird_x + bird_size * 9, bird_y + bird_size * 7, colour_bird_yellow)  %yellow, right
    drawfillbox (bird_x + bird_size * 6, bird_y + bird_size * 4, bird_x + bird_size * 8, bird_y + bird_size * 5, colour_bird_yellow)  %bottom
    drawfillbox (bird_x + bird_size * 9, bird_y + bird_size * 5, bird_x + bird_size * 10, bird_y + bird_size * 6, colour_bird_yellow)  %right
    drawfillbox (bird_x + bird_size * 5, bird_y + bird_size * 8, bird_x + bird_size * 6, bird_y + bird_size * 9, colour_bird_yellow)  %top

    %yellow top
    drawfillbox (bird_x + bird_size * 6, bird_y + bird_size * 10, bird_x + bird_size * 9, bird_y + bird_size * 11, colour_bird_light_yellow) %light yellow, top
    drawfillbox (bird_x + bird_size * 4, bird_y + bird_size * 9, bird_x + bird_size * 5, bird_y + bird_size * 10, colour_bird_light_yellow) %left
    drawfillbox (bird_x + bird_size * 5, bird_y + bird_size * 9, bird_x + bird_size * 6, bird_y + bird_size * 10, colour_bird_light_yellow) %right

    %wing
    drawfillbox (bird_x + bird_size * 1, bird_y + bird_size * 5, bird_x + bird_size * 2, bird_y + bird_size * 6, colour_bird_yellow) %left
    drawfillbox (bird_x + bird_size * 2, bird_y + bird_size * 4, bird_x + bird_size * 5, bird_y + bird_size * 5, colour_bird_yellow) %middle
    drawfillbox (bird_x + bird_size * 5, bird_y + bird_size * 5, bird_x + bird_size * 6, bird_y + bird_size * 6, colour_bird_yellow) %right
    %light yellow
    drawfillbox (bird_x + bird_size * 2, bird_y + bird_size * 5, bird_x + bird_size * 5, bird_y + bird_size * 6, colour_bird_light_yellow) %light yellow, wing, bottom
    drawfillbox (bird_x + bird_size, bird_y + bird_size * 6, bird_x + bird_size * 7, bird_y + bird_size * 7, colour_bird_light_yellow) %light yellow, wing, middle
    drawfillbox (bird_x + bird_size, bird_y + bird_size * 7, bird_x + bird_size * 6, bird_y + bird_size * 8, colour_bird_light_yellow) %light yellow, wing, top

    %eye white
    drawfillbox (bird_x + bird_size * 10, bird_y + bird_size * 7, bird_x + bird_size * 11, bird_y + bird_size * 11, colour_bird_white) %white, eye, left
    drawfillbox (bird_x + bird_size * 11, bird_y + bird_size * 6, bird_x + bird_size * 12, bird_y + bird_size * 11, colour_bird_white) %white, eye, middle
    drawfillbox (bird_x + bird_size * 13, bird_y + bird_size * 6, bird_x + bird_size * 14, bird_y + bird_size * 9, colour_bird_white) %white, eye, right
    drawfillbox (bird_x + bird_size * 12, bird_y + bird_size * 6, bird_x + bird_size * 13, bird_y + bird_size * 7, colour_bird_white) %bottom
    drawfillbox (bird_x + bird_size * 12, bird_y + bird_size * 9, bird_x + bird_size * 13, bird_y + bird_size * 10, colour_bird_white) %top
    drawfillbox (bird_x + bird_size * 9, bird_y + bird_size * 9, bird_x + bird_size * 10, bird_y + bird_size * 10, colour_bird_white) %left
    %eye grey
    drawfillbox (bird_x + bird_size * 9, bird_y + bird_size * 8, bird_x + bird_size * 10, bird_y + bird_size * 9, colour_bird_grey) %top
    drawfillbox (bird_x + bird_size * 9, bird_y + bird_size * 7, bird_x + bird_size * 10, bird_y + bird_size * 8, colour_bird_grey) %middle
    drawfillbox (bird_x + bird_size * 10, bird_y + bird_size * 6, bird_x + bird_size * 11, bird_y + bird_size * 7, colour_bird_grey) %bottom
    %lips
    drawfillbox (bird_x + bird_size * 16, bird_y + bird_size * 4, bird_x + bird_size * 10, bird_y + bird_size * 5, colour_bird_red) %light yellow, top
    drawfillbox (bird_x + bird_size * 15, bird_y + bird_size * 2, bird_x + bird_size * 10, bird_y + bird_size * 3, colour_bird_red) %light yellow, top
    drawfillbox (bird_x + bird_size * 9, bird_y + bird_size * 3, bird_x + bird_size * 10, bird_y + bird_size * 4, colour_bird_red) %left
    %border
    drawfillbox (bird_x, bird_y + bird_size * 5, bird_x + bird_size, bird_y + bird_size * 8, colour_bird_border) %left wing
    drawfillbox (bird_x + bird_size, bird_y + bird_size * 4, bird_x + bird_size * 2, bird_y + bird_size * 5, colour_bird_border)
    drawfillbox (bird_x + bird_size * 2, bird_y + bird_size * 3, bird_x + bird_size * 3, bird_y + bird_size * 4, colour_bird_border)
    drawfillbox (bird_x + bird_size * 2, bird_y + bird_size * 2, bird_x + bird_size * 3, bird_y + bird_size * 3, colour_bird_border)
    drawfillbox (bird_x + bird_size * 3, bird_y + bird_size * 1, bird_x + bird_size * 4, bird_y + bird_size * 2, colour_bird_border)
    drawfillbox (bird_x + bird_size * 4, bird_y + bird_size * 1, bird_x + bird_size * 5, bird_y + bird_size * 2, colour_bird_border)
    drawfillbox (bird_x + bird_size * 5, bird_y, bird_x + bird_size * 10, bird_y + bird_size, colour_bird_border) %bottom line
    drawfillbox (bird_x + bird_size * 10, bird_y + bird_size, bird_x + bird_size * 15, bird_y + bird_size * 2, colour_bird_border) %bottom lip
    drawfillbox (bird_x + bird_size * 15, bird_y + bird_size * 2, bird_x + bird_size * 16, bird_y + bird_size * 3, colour_bird_border)
    drawfillbox (bird_x + bird_size * 16, bird_y + bird_size * 3, bird_x + bird_size * 10, bird_y + bird_size * 4, colour_bird_border) %middle lip
    drawfillbox (bird_x + bird_size * 9, bird_y + bird_size * 2, bird_x + bird_size * 10, bird_y + bird_size * 3, colour_bird_border)
    drawfillbox (bird_x + bird_size * 8, bird_y + bird_size * 3, bird_x + bird_size * 9, bird_y + bird_size * 4, colour_bird_border)
    drawfillbox (bird_x + bird_size * 9, bird_y + bird_size * 4, bird_x + bird_size * 10, bird_y + bird_size * 5, colour_bird_border)
    drawfillbox (bird_x + bird_size * 16, bird_y + bird_size * 5, bird_x + bird_size * 10, bird_y + bird_size * 6, colour_bird_border) %top lip
    drawfillbox (bird_x + bird_size * 16, bird_y + bird_size * 4, bird_x2, bird_y + bird_size * 5, colour_bird_border)
    drawfillbox (bird_x + bird_size * 14, bird_y + bird_size * 6, bird_x + bird_size * 15, bird_y + bird_size * 9, colour_bird_border) %right eye
    drawfillbox (bird_x + bird_size * 13, bird_y + bird_size * 9, bird_x + bird_size * 14, bird_y + bird_size * 10, colour_bird_border)
    drawfillbox (bird_x + bird_size * 12, bird_y + bird_size * 8, bird_x + bird_size * 13, bird_y + bird_size * 9, colour_bird_border) %upper eye
    drawfillbox (bird_x + bird_size * 12, bird_y + bird_size * 7, bird_x + bird_size * 13, bird_y + bird_size * 8, colour_bird_border) %lower eye
    drawfillbox (bird_x + bird_size * 12, bird_y + bird_size * 10, bird_x + bird_size * 13, bird_y + bird_size * 11, colour_bird_border)
    drawfillbox (bird_x + bird_size * 12, bird_y2, bird_x + bird_size * 6, bird_y + bird_size * 12, colour_bird_border) %top line
    drawfillbox (bird_x + bird_size * 9, bird_y + bird_size * 10, bird_x + bird_size * 10, bird_y + bird_size * 11, colour_bird_border)
    drawfillbox (bird_x + bird_size * 8, bird_y + bird_size * 10, bird_x + bird_size * 9, bird_y + bird_size * 7, colour_bird_border) %left eye
    drawfillbox (bird_x + bird_size * 9, bird_y + bird_size * 6, bird_x + bird_size * 10, bird_y + bird_size * 7, colour_bird_border)
    drawfillbox (bird_x + bird_size * 5, bird_y + bird_size * 10, bird_x + bird_size * 6, bird_y + bird_size * 11, colour_bird_border)
    drawfillbox (bird_x + bird_size * 4, bird_y + bird_size * 10, bird_x + bird_size * 5, bird_y + bird_size * 11, colour_bird_border)
    drawfillbox (bird_x + bird_size * 3, bird_y + bird_size * 9, bird_x + bird_size * 4, bird_y + bird_size * 10, colour_bird_border)
    drawfillbox (bird_x + bird_size, bird_y + bird_size * 8, bird_x + bird_size * 5, bird_y + bird_size * 9, colour_bird_border) %top wing
    drawfillbox (bird_x + bird_size * 5, bird_y + bird_size * 7, bird_x + bird_size * 6, bird_y + bird_size * 8, colour_bird_border)
    drawfillbox (bird_x + bird_size * 6, bird_y + bird_size * 6, bird_x + bird_size * 7, bird_y + bird_size * 7, colour_bird_border)
    drawfillbox (bird_x + bird_size * 6, bird_y + bird_size * 5, bird_x + bird_size * 7, bird_y + bird_size * 6, colour_bird_border)
    drawfillbox (bird_x + bird_size * 5, bird_y + bird_size * 4, bird_x + bird_size * 6, bird_y + bird_size * 5, colour_bird_border)
    drawfillbox (bird_x + bird_size * 4, bird_y + bird_size * 3, bird_x + bird_size * 5, bird_y + bird_size * 4, colour_bird_border)
    drawfillbox (bird_x + bird_size * 3, bird_y + bird_size * 3, bird_x + bird_size * 4, bird_y + bird_size * 4, colour_bird_border)

end draw_bird

procedure draw_bird2

    rainbow_bird

    %orange
    drawfillbox (bird_x + bird_size * 5, bird_y + bird_size, bird_x + bird_size * 10, bird_y + bird_size * 2, colour_bird_orange) %orange, bottom
    drawfillbox (bird_x + bird_size * 3, bird_y + bird_size * 2, bird_x + bird_size * 9, bird_y + bird_size * 3, colour_bird_orange) %orange, middle
    drawfillbox (bird_x + bird_size * 5, bird_y + bird_size * 3, bird_x + bird_size * 8, bird_y + bird_size * 4, colour_bird_orange) %orange, top
    %yellow
    drawfillbox (bird_x + bird_size * 1, bird_y + bird_size * 4, bird_x + bird_size * 2, bird_y + bird_size * 5, colour_bird_yellow) %wing, left
    drawfillbox (bird_x + bird_size * 5, bird_y + bird_size * 4, bird_x + bird_size * 6, bird_y + bird_size * 5, colour_bird_yellow) %wing, right
    drawfillbox (bird_x + bird_size * 6, bird_y + bird_size * 6, bird_x + bird_size * 7, bird_y + bird_size * 10, colour_bird_yellow) %yellow, left
    drawfillbox (bird_x + bird_size * 7, bird_y + bird_size * 4, bird_x + bird_size * 8, bird_y + bird_size * 10, colour_bird_yellow) %yellow, middle
    drawfillbox (bird_x + bird_size * 8, bird_y + bird_size * 4, bird_x + bird_size * 9, bird_y + bird_size * 7, colour_bird_yellow) %yellow, right
    drawfillbox (bird_x + bird_size * 6, bird_y + bird_size * 4, bird_x + bird_size * 8, bird_y + bird_size * 5, colour_bird_yellow) %bottom
    drawfillbox (bird_x + bird_size * 9, bird_y + bird_size * 5, bird_x + bird_size * 10, bird_y + bird_size * 6, colour_bird_yellow) %right
    drawfillbox (bird_x + bird_size * 4, bird_y + bird_size * 8, bird_x + bird_size * 6, bird_y + bird_size * 9, colour_bird_yellow) %left, top
    drawfillbox (bird_x + bird_size * 2, bird_y + bird_size * 7, bird_x + bird_size * 6, bird_y + bird_size * 8, colour_bird_yellow) %left, bottom
    %wing
    drawfillbox (bird_x + bird_size * 1, bird_y + bird_size * 5, bird_x + bird_size * 2, bird_y + bird_size * 6, colour_bird_yellow) %left
    drawfillbox (bird_x + bird_size * 2, bird_y + bird_size * 4, bird_x + bird_size * 5, bird_y + bird_size * 5, colour_bird_yellow) %middle
    drawfillbox (bird_x + bird_size * 5, bird_y + bird_size * 5, bird_x + bird_size * 6, bird_y + bird_size * 6, colour_bird_yellow) %right
    %light yellow
    drawfillbox (bird_x + bird_size * 2, bird_y + bird_size * 4, bird_x + bird_size * 5, bird_y + bird_size * 5, colour_bird_light_yellow) %light yellow, wing, bottom
    drawfillbox (bird_x + bird_size, bird_y + bird_size * 5, bird_x + bird_size * 7, bird_y + bird_size * 6, colour_bird_light_yellow) %light yellow, wing, middle
    drawfillbox (bird_x + bird_size * 6, bird_y + bird_size * 10, bird_x + bird_size * 9, bird_y + bird_size * 11, colour_bird_light_yellow) %light yellow, top
    drawfillbox (bird_x + bird_size * 4, bird_y + bird_size * 9, bird_x + bird_size * 6, bird_y + bird_size * 10, colour_bird_light_yellow) %2 pixels diagonal from latter
    drawfillbox (bird_x + bird_size * 3, bird_y + bird_size * 8, bird_x + bird_size * 4, bird_y + bird_size * 9, colour_bird_light_yellow) %single pixel diagonal from latter
    %eye white
    drawfillbox (bird_x + bird_size * 10, bird_y + bird_size * 7, bird_x + bird_size * 11, bird_y + bird_size * 11, colour_bird_white) %white, eye, left
    drawfillbox (bird_x + bird_size * 11, bird_y + bird_size * 6, bird_x + bird_size * 12, bird_y + bird_size * 11, colour_bird_white) %white, eye, middle
    drawfillbox (bird_x + bird_size * 13, bird_y + bird_size * 6, bird_x + bird_size * 14, bird_y + bird_size * 9, colour_bird_white) %white, eye, right
    drawfillbox (bird_x + bird_size * 12, bird_y + bird_size * 6, bird_x + bird_size * 13, bird_y + bird_size * 7, colour_bird_white) %bottom
    drawfillbox (bird_x + bird_size * 12, bird_y + bird_size * 9, bird_x + bird_size * 13, bird_y + bird_size * 10, colour_bird_white) %top
    drawfillbox (bird_x + bird_size * 9, bird_y + bird_size * 9, bird_x + bird_size * 10, bird_y + bird_size * 10, colour_bird_white) %left
    %eye grey
    drawfillbox (bird_x + bird_size * 9, bird_y + bird_size * 7, bird_x + bird_size * 10, bird_y + bird_size * 9, colour_bird_grey) %top
    drawfillbox (bird_x + bird_size * 10, bird_y + bird_size * 6, bird_x + bird_size * 11, bird_y + bird_size * 7, colour_bird_grey) %bottom
    %lips
    drawfillbox (bird_x + bird_size * 16, bird_y + bird_size * 4, bird_x + bird_size * 10, bird_y + bird_size * 5, colour_bird_red) %top
    drawfillbox (bird_x + bird_size * 15, bird_y + bird_size * 2, bird_x + bird_size * 10, bird_y + bird_size * 3, colour_bird_red) %bottom
    drawfillbox (bird_x + bird_size * 9, bird_y + bird_size * 3, bird_x + bird_size * 10, bird_y + bird_size * 4, colour_bird_red) %middle left
    %border
    drawfillbox (bird_x, bird_y + bird_size * 4, bird_x + bird_size, bird_y + bird_size * 6, colour_bird_border) %left wing
    drawfillbox (bird_x + bird_size, bird_y + bird_size * 6, bird_x + bird_size * 6, bird_y + bird_size * 7, colour_bird_border) %top wing
    drawfillbox (bird_x + bird_size * 6, bird_y + bird_size * 4, bird_x + bird_size * 7, bird_y + bird_size * 6, colour_bird_border) %right wing
    drawfillbox (bird_x + bird_size * 1, bird_y + bird_size * 3, bird_x + bird_size * 6, bird_y + bird_size * 4, colour_bird_border) %bottom wing
    drawfillbox (bird_x + bird_size * 2, bird_y + bird_size * 2, bird_x + bird_size * 3, bird_y + bird_size * 3, colour_bird_border) %pixel directly under bottom wing
    drawfillbox (bird_x + bird_size * 3, bird_y + bird_size * 1, bird_x + bird_size * 5, bird_y + bird_size * 2, colour_bird_border) %2 pixel line left of bottom line
    drawfillbox (bird_x + bird_size * 5, bird_y, bird_x + bird_size * 10, bird_y + bird_size, colour_bird_border) %bottom line
    drawfillbox (bird_x + bird_size * 10, bird_y + bird_size, bird_x + bird_size * 15, bird_y + bird_size * 2, colour_bird_border) %bottom lip
    drawfillbox (bird_x + bird_size * 15, bird_y + bird_size * 2, bird_x + bird_size * 16, bird_y + bird_size * 3, colour_bird_border)
    drawfillbox (bird_x + bird_size * 16, bird_y + bird_size * 3, bird_x + bird_size * 10, bird_y + bird_size * 4, colour_bird_border) %middle lip
    drawfillbox (bird_x + bird_size * 9, bird_y + bird_size * 2, bird_x + bird_size * 10, bird_y + bird_size * 3, colour_bird_border)
    drawfillbox (bird_x + bird_size * 8, bird_y + bird_size * 3, bird_x + bird_size * 9, bird_y + bird_size * 4, colour_bird_border)
    drawfillbox (bird_x + bird_size * 9, bird_y + bird_size * 4, bird_x + bird_size * 10, bird_y + bird_size * 5, colour_bird_border)
    drawfillbox (bird_x + bird_size * 16, bird_y + bird_size * 5, bird_x + bird_size * 10, bird_y + bird_size * 6, colour_bird_border) %top lip
    drawfillbox (bird_x + bird_size * 16, bird_y + bird_size * 4, bird_x2, bird_y + bird_size * 5, colour_bird_border)
    drawfillbox (bird_x + bird_size * 14, bird_y + bird_size * 6, bird_x + bird_size * 15, bird_y + bird_size * 9, colour_bird_border) %right eye
    drawfillbox (bird_x + bird_size * 13, bird_y + bird_size * 9, bird_x + bird_size * 14, bird_y + bird_size * 10, colour_bird_border)
    drawfillbox (bird_x + bird_size * 12, bird_y + bird_size * 7, bird_x + bird_size * 13, bird_y + bird_size * 9, colour_bird_border) %pupil
    drawfillbox (bird_x + bird_size * 12, bird_y + bird_size * 10, bird_x + bird_size * 13, bird_y + bird_size * 11, colour_bird_border)
    drawfillbox (bird_x + bird_size * 12, bird_y2, bird_x + bird_size * 6, bird_y + bird_size * 12, colour_bird_border) %top line
    drawfillbox (bird_x + bird_size * 9, bird_y + bird_size * 10, bird_x + bird_size * 10, bird_y + bird_size * 11, colour_bird_border)
    drawfillbox (bird_x + bird_size * 8, bird_y + bird_size * 10, bird_x + bird_size * 9, bird_y + bird_size * 7, colour_bird_border) %left eye
    drawfillbox (bird_x + bird_size * 9, bird_y + bird_size * 6, bird_x + bird_size * 10, bird_y + bird_size * 7, colour_bird_border)
    drawfillbox (bird_x + bird_size * 4, bird_y + bird_size * 10, bird_x + bird_size * 6, bird_y + bird_size * 11, colour_bird_border)
    drawfillbox (bird_x + bird_size * 3, bird_y + bird_size * 9, bird_x + bird_size * 4, bird_y + bird_size * 10, colour_bird_border)
    drawfillbox (bird_x + bird_size, bird_y + bird_size * 7, bird_x + bird_size * 2, bird_y + bird_size * 8, colour_bird_border) %pixel directly above top wing
    drawfillbox (bird_x + bird_size * 2, bird_y + bird_size * 8, bird_x + bird_size * 3, bird_y + bird_size * 9, colour_bird_border) %pixel diagonal from latter

end draw_bird2

procedure draw_bird3

    rainbow_bird

    %orange
    drawfillbox (bird_x + bird_size * 5, bird_y + bird_size, bird_x + bird_size * 10, bird_y + bird_size * 2, colour_bird_orange) %orange, bottom
    drawfillbox (bird_x + bird_size * 5, bird_y + bird_size * 2, bird_x + bird_size * 9, bird_y + bird_size * 3, colour_bird_orange) %orange, middle
    drawfillbox (bird_x + bird_size * 5, bird_y + bird_size * 3, bird_x + bird_size * 8, bird_y + bird_size * 4, colour_bird_orange) %orange, top
    %yellow
    drawfillbox (bird_x + bird_size * 1, bird_y + bird_size * 4, bird_x + bird_size * 2, bird_y + bird_size * 5, colour_bird_yellow) %wing, left
    drawfillbox (bird_x + bird_size * 5, bird_y + bird_size * 4, bird_x + bird_size * 6, bird_y + bird_size * 5, colour_bird_yellow) %wing, right
    drawfillbox (bird_x + bird_size * 3, bird_y + bird_size * 2, bird_x + bird_size * 4, bird_y + bird_size * 3, colour_bird_yellow) %wing, middle bottom
    drawfillbox (bird_x + bird_size * 6, bird_y + bird_size * 6, bird_x + bird_size * 7, bird_y + bird_size * 10, colour_bird_yellow) %yellow, left
    drawfillbox (bird_x + bird_size * 7, bird_y + bird_size * 4, bird_x + bird_size * 8, bird_y + bird_size * 10, colour_bird_yellow) %yellow, middle
    drawfillbox (bird_x + bird_size * 8, bird_y + bird_size * 4, bird_x + bird_size * 9, bird_y + bird_size * 7, colour_bird_yellow) %yellow, right
    drawfillbox (bird_x + bird_size * 6, bird_y + bird_size * 4, bird_x + bird_size * 8, bird_y + bird_size * 5, colour_bird_yellow) %bottom
    drawfillbox (bird_x + bird_size * 9, bird_y + bird_size * 5, bird_x + bird_size * 10, bird_y + bird_size * 6, colour_bird_yellow) %right
    drawfillbox (bird_x + bird_size * 4, bird_y + bird_size * 8, bird_x + bird_size * 6, bird_y + bird_size * 9, colour_bird_yellow) %left, top
    drawfillbox (bird_x + bird_size * 2, bird_y + bird_size * 6, bird_x + bird_size * 6, bird_y + bird_size * 8, colour_bird_yellow) %left, middle
    drawfillbox (bird_x + bird_size * 6, bird_y + bird_size * 5, bird_x + bird_size * 7, bird_y + bird_size * 6, colour_bird_yellow) %single pixel near left middle
    %wing
    drawfillbox (bird_x + bird_size * 1, bird_y + bird_size * 5, bird_x + bird_size * 2, bird_y + bird_size * 6, colour_bird_yellow) %left
    drawfillbox (bird_x + bird_size * 2, bird_y + bird_size * 4, bird_x + bird_size * 5, bird_y + bird_size * 5, colour_bird_yellow) %middle
    drawfillbox (bird_x + bird_size * 5, bird_y + bird_size * 5, bird_x + bird_size * 6, bird_y + bird_size * 6, colour_bird_yellow) %right
    %light yellow
    drawfillbox (bird_x + bird_size * 2, bird_y + bird_size * 4, bird_x + bird_size * 5, bird_y + bird_size * 5, colour_bird_light_yellow) %light yellow, wing, top
    drawfillbox (bird_x + bird_size * 1, bird_y + bird_size * 3, bird_x + bird_size * 5, bird_y + bird_size * 4, colour_bird_light_yellow) %light yellow, wing, middle
    drawfillbox (bird_x + bird_size * 1, bird_y + bird_size * 2, bird_x + bird_size * 3, bird_y + bird_size * 3, colour_bird_light_yellow) %light yellow, wing, bottom
    drawfillbox (bird_x + bird_size * 6, bird_y + bird_size * 10, bird_x + bird_size * 9, bird_y + bird_size * 11, colour_bird_light_yellow) %light yellow, top
    drawfillbox (bird_x + bird_size * 4, bird_y + bird_size * 9, bird_x + bird_size * 6, bird_y + bird_size * 10, colour_bird_light_yellow) %2 pixels diagonal from latter
    drawfillbox (bird_x + bird_size * 3, bird_y + bird_size * 8, bird_x + bird_size * 4, bird_y + bird_size * 9, colour_bird_light_yellow) %single pixel diagonal from latter
    %eye white
    drawfillbox (bird_x + bird_size * 10, bird_y + bird_size * 7, bird_x + bird_size * 11, bird_y + bird_size * 11, colour_bird_white) %white, eye, left
    drawfillbox (bird_x + bird_size * 11, bird_y + bird_size * 6, bird_x + bird_size * 12, bird_y + bird_size * 11, colour_bird_white) %white, eye, middle
    drawfillbox (bird_x + bird_size * 13, bird_y + bird_size * 6, bird_x + bird_size * 14, bird_y + bird_size * 9, colour_bird_white) %white, eye, right
    drawfillbox (bird_x + bird_size * 12, bird_y + bird_size * 6, bird_x + bird_size * 13, bird_y + bird_size * 7, colour_bird_white) %bottom
    drawfillbox (bird_x + bird_size * 12, bird_y + bird_size * 9, bird_x + bird_size * 13, bird_y + bird_size * 10, colour_bird_white) %top
    drawfillbox (bird_x + bird_size * 9, bird_y + bird_size * 9, bird_x + bird_size * 10, bird_y + bird_size * 10, colour_bird_white) %left
    %eye grey
    drawfillbox (bird_x + bird_size * 9, bird_y + bird_size * 7, bird_x + bird_size * 10, bird_y + bird_size * 9, colour_bird_grey) %top
    drawfillbox (bird_x + bird_size * 10, bird_y + bird_size * 6, bird_x + bird_size * 11, bird_y + bird_size * 7, colour_bird_grey) %bottom
    %lips
    drawfillbox (bird_x + bird_size * 16, bird_y + bird_size * 4, bird_x + bird_size * 10, bird_y + bird_size * 5, colour_bird_red) %top
    drawfillbox (bird_x + bird_size * 15, bird_y + bird_size * 2, bird_x + bird_size * 10, bird_y + bird_size * 3, colour_bird_red) %bottom
    drawfillbox (bird_x + bird_size * 9, bird_y + bird_size * 3, bird_x + bird_size * 10, bird_y + bird_size * 4, colour_bird_red) %middle left
    %border
    drawfillbox (bird_x, bird_y + bird_size * 2, bird_x + bird_size, bird_y + bird_size * 5, colour_bird_border) %left wing
    drawfillbox (bird_x + bird_size, bird_y + bird_size * 5, bird_x + bird_size * 6, bird_y + bird_size * 6, colour_bird_border) %top wing
    drawfillbox (bird_x + bird_size * 6, bird_y + bird_size * 4, bird_x + bird_size * 7, bird_y + bird_size * 5, colour_bird_border) %right wing
    drawfillbox (bird_x + bird_size * 5, bird_y + bird_size * 3, bird_x + bird_size * 6, bird_y + bird_size * 4, colour_bird_border) %right wing left down
    drawfillbox (bird_x + bird_size * 4, bird_y + bird_size * 2, bird_x + bird_size * 5, bird_y + bird_size * 3, colour_bird_border) %right wing left down 2
    drawfillbox (bird_x + bird_size * 1, bird_y + bird_size, bird_x + bird_size * 5, bird_y + bird_size * 2, colour_bird_border) %bottom wing
    drawfillbox (bird_x + bird_size * 3, bird_y + bird_size * 1, bird_x + bird_size * 5, bird_y + bird_size * 2, colour_bird_border) %2 pixel line left of bottom line
    drawfillbox (bird_x + bird_size * 5, bird_y, bird_x + bird_size * 10, bird_y + bird_size, colour_bird_border) %bottom line
    drawfillbox (bird_x + bird_size * 10, bird_y + bird_size, bird_x + bird_size * 15, bird_y + bird_size * 2, colour_bird_border) %bottom lip
    drawfillbox (bird_x + bird_size * 15, bird_y + bird_size * 2, bird_x + bird_size * 16, bird_y + bird_size * 3, colour_bird_border)
    drawfillbox (bird_x + bird_size * 16, bird_y + bird_size * 3, bird_x + bird_size * 10, bird_y + bird_size * 4, colour_bird_border) %middle lip
    drawfillbox (bird_x + bird_size * 9, bird_y + bird_size * 2, bird_x + bird_size * 10, bird_y + bird_size * 3, colour_bird_border)
    drawfillbox (bird_x + bird_size * 8, bird_y + bird_size * 3, bird_x + bird_size * 9, bird_y + bird_size * 4, colour_bird_border)
    drawfillbox (bird_x + bird_size * 9, bird_y + bird_size * 4, bird_x + bird_size * 10, bird_y + bird_size * 5, colour_bird_border)
    drawfillbox (bird_x + bird_size * 16, bird_y + bird_size * 5, bird_x + bird_size * 10, bird_y + bird_size * 6, colour_bird_border) %top lip
    drawfillbox (bird_x + bird_size * 16, bird_y + bird_size * 4, bird_x2, bird_y + bird_size * 5, colour_bird_border)
    drawfillbox (bird_x + bird_size * 14, bird_y + bird_size * 6, bird_x + bird_size * 15, bird_y + bird_size * 9, colour_bird_border) %right eye
    drawfillbox (bird_x + bird_size * 13, bird_y + bird_size * 9, bird_x + bird_size * 14, bird_y + bird_size * 10, colour_bird_border)
    drawfillbox (bird_x + bird_size * 12, bird_y + bird_size * 7, bird_x + bird_size * 13, bird_y + bird_size * 9, colour_bird_border) %pupil
    drawfillbox (bird_x + bird_size * 12, bird_y + bird_size * 10, bird_x + bird_size * 13, bird_y + bird_size * 11, colour_bird_border)
    drawfillbox (bird_x + bird_size * 12, bird_y2, bird_x + bird_size * 6, bird_y + bird_size * 12, colour_bird_border) %top line
    drawfillbox (bird_x + bird_size * 9, bird_y + bird_size * 10, bird_x + bird_size * 10, bird_y + bird_size * 11, colour_bird_border)
    drawfillbox (bird_x + bird_size * 8, bird_y + bird_size * 10, bird_x + bird_size * 9, bird_y + bird_size * 7, colour_bird_border) %left eye
    drawfillbox (bird_x + bird_size * 9, bird_y + bird_size * 6, bird_x + bird_size * 10, bird_y + bird_size * 7, colour_bird_border)
    drawfillbox (bird_x + bird_size * 4, bird_y + bird_size * 10, bird_x + bird_size * 6, bird_y + bird_size * 11, colour_bird_border)
    drawfillbox (bird_x + bird_size * 3, bird_y + bird_size * 9, bird_x + bird_size * 4, bird_y + bird_size * 10, colour_bird_border)
    drawfillbox (bird_x + bird_size * 2, bird_y + bird_size * 8, bird_x + bird_size * 3, bird_y + bird_size * 9, colour_bird_border) %pixel diagonal from latter
    drawfillbox (bird_x + bird_size, bird_y + bird_size * 6, bird_x + bird_size * 2, bird_y + bird_size * 8, colour_bird_border) %pixel directly above top wing

end draw_bird3

procedure draw_pipes2

    %first pipe
    %top pipe
    %top
    drawfillbox (bbottomx (1) - 3, 550, bbottomx (1) + 73, toppipey (1) - 3, 19)
    drawfillbox (bbottomx (1), 550, bbottomx (1) + 70, toppipey (1), 2)
    %gradient
    drawfillbox (bbottomx (1), 550, bbottomx (1) + 2, toppipey (1), 10)
    drawfillbox (bbottomx (1) + 3, 550, bbottomx (1) + 6, toppipey (1), 68)
    drawfillbox (bbottomx (1) + 7, 550, bbottomx (1) + 16, toppipey (1), 10)
    drawfillbox (bbottomx (1) + 20, 550, bbottomx (1) + 23, toppipey (1), 10)
    drawfillbox (bbottomx (1) + 63, 550, bbottomx (1) + 70, toppipey (1), 191)
    drawfillbox (bbottomx (1) + 55, 550, bbottomx (1) + 58, toppipey (1), 191)
    %bottom
    drawfillbox (btopx (1) - 3, toppipey (1) + 1, btopx (1) + 83, toppipey (1) - 36, 19)
    drawfillbox (btopx (1), toppipey (1) - 2, btopx (1) + 80, toppipey (1) - 33, 2)
    %gradient
    drawfillbox (btopx (1), toppipey (1) - 2, btopx (1) + 2, toppipey (1) - 33, 10)
    drawfillbox (btopx (1) + 3, toppipey (1) - 2, btopx (1) + 6, toppipey (1) - 33, 68)
    drawfillbox (btopx (1) + 7, toppipey (1) - 2, btopx (1) + 16, toppipey (1) - 33, 10)
    drawfillbox (btopx (1) + 20, toppipey (1) - 2, btopx (1) + 23, toppipey (1) - 33, 10)
    drawfillbox (btopx (1) + 73, toppipey (1) - 2, btopx (1) + 80, toppipey (1) - 33, 191)
    drawfillbox (btopx (1) + 65, toppipey (1) - 2, btopx (1) + 68, toppipey (1) - 33, 191)

    %bottom pipe
    %top
    drawfillbox (btopx (1) - 3, btopy (1) + 3, btopx (1) + 83, btopy (1) - 33, 19)
    drawfillbox (btopx (1), btopy (1), btopx (1) + 80, btopy (1) - 30, 2)
    %gradient
    drawfillbox (btopx (1), btopy (1), btopx (1) + 2, btopy (1) - 30, 10)
    drawfillbox (btopx (1) + 3, btopy (1), btopx (1) + 6, btopy (1) - 30, 68)
    drawfillbox (btopx (1) + 7, btopy (1), btopx (1) + 16, btopy (1) - 30, 10)
    drawfillbox (btopx (1) + 20, btopy (1), btopx (1) + 23, btopy (1) - 30, 10)
    drawfillbox (btopx (1) + 73, btopy (1), btopx (1) + 80, btopy (1) - 30, 191)
    drawfillbox (btopx (1) + 65, btopy (1), btopx (1) + 68, btopy (1) - 30, 191)
    %bottom
    drawfillbox (bbottomx (1) - 3, bbottomy (1), bbottomx (1) + 73, pipeground, 19)
    drawfillbox (bbottomx (1), bbottomy (1) - 1, bbottomx (1) + 70, pipeground, 2)
    %gradient
    drawfillbox (bbottomx (1), bbottomy (1) - 1, bbottomx (1) + 2, pipeground, 10)
    drawfillbox (bbottomx (1) + 3, bbottomy (1) - 1, bbottomx (1) + 6, pipeground, 68)
    drawfillbox (bbottomx (1) + 7, bbottomy (1) - 1, bbottomx (1) + 16, pipeground, 10)
    drawfillbox (bbottomx (1) + 20, bbottomy (1) - 1, bbottomx (1) + 23, pipeground, 10)
    drawfillbox (bbottomx (1) + 63, bbottomy (1) - 1, bbottomx (1) + 70, pipeground, 191)
    drawfillbox (bbottomx (1) + 55, bbottomy (1) - 1, bbottomx (1) + 58, pipeground, 191)

    %second pipe
    %top pipe
    %top
    drawfillbox (bbottomx (2) - 3, 550, bbottomx (2) + 73, toppipey (2) - 3, 19)
    drawfillbox (bbottomx (2), 550, bbottomx (2) + 70, toppipey (2), 2)
    %gradient
    drawfillbox (bbottomx (2), 550, bbottomx (2) + 2, toppipey (2), 10)
    drawfillbox (bbottomx (2) + 3, 550, bbottomx (2) + 6, toppipey (2), 68)
    drawfillbox (bbottomx (2) + 7, 550, bbottomx (2) + 16, toppipey (2), 10)
    drawfillbox (bbottomx (2) + 20, 550, bbottomx (2) + 23, toppipey (2), 10)
    drawfillbox (bbottomx (2) + 63, 550, bbottomx (2) + 70, toppipey (2), 191)
    drawfillbox (bbottomx (2) + 55, 550, bbottomx (2) + 58, toppipey (2), 191)
    %bottom
    drawfillbox (btopx (2) - 3, toppipey (2) + 1, btopx (2) + 83, toppipey (2) - 36, 19)
    drawfillbox (btopx (2), toppipey (2) - 2, btopx (2) + 80, toppipey (2) - 33, 2)
    %gradient
    drawfillbox (btopx (2), toppipey (2) - 2, btopx (2) + 2, toppipey (2) - 33, 10)
    drawfillbox (btopx (2) + 3, toppipey (2) - 2, btopx (2) + 6, toppipey (2) - 33, 68)
    drawfillbox (btopx (2) + 7, toppipey (2) - 2, btopx (2) + 16, toppipey (2) - 33, 10)
    drawfillbox (btopx (2) + 20, toppipey (2) - 2, btopx (2) + 23, toppipey (2) - 33, 10)
    drawfillbox (btopx (2) + 73, toppipey (2) - 2, btopx (2) + 80, toppipey (2) - 33, 191)
    drawfillbox (btopx (2) + 65, toppipey (2) - 2, btopx (2) + 68, toppipey (2) - 33, 191)

    %bottom pipe
    %top
    drawfillbox (btopx (2) - 3, btopy (2) + 3, btopx (2) + 83, btopy (2) - 33, 19)
    drawfillbox (btopx (2), btopy (2), btopx (2) + 80, btopy (2) - 30, 2)
    %gradient
    drawfillbox (btopx (2), btopy (2), btopx (2) + 2, btopy (2) - 30, 10)
    drawfillbox (btopx (2) + 3, btopy (2), btopx (2) + 6, btopy (2) - 30, 68)
    drawfillbox (btopx (2) + 7, btopy (2), btopx (2) + 16, btopy (2) - 30, 10)
    drawfillbox (btopx (2) + 20, btopy (2), btopx (2) + 23, btopy (2) - 30, 10)
    drawfillbox (btopx (2) + 73, btopy (2), btopx (2) + 80, btopy (2) - 30, 191)
    drawfillbox (btopx (2) + 65, btopy (2), btopx (2) + 68, btopy (2) - 30, 191)
    %bottom
    drawfillbox (bbottomx (2) - 3, bbottomy (2), bbottomx (2) + 73, pipeground, 19)
    drawfillbox (bbottomx (2), bbottomy (2) - 1, bbottomx (2) + 70, pipeground, 2)
    %gradient
    drawfillbox (bbottomx (2), bbottomy (2) - 1, bbottomx (2) + 2, pipeground, 10)
    drawfillbox (bbottomx (2) + 3, bbottomy (2) - 1, bbottomx (2) + 6, pipeground, 68)
    drawfillbox (bbottomx (2) + 7, bbottomy (2) - 1, bbottomx (2) + 16, pipeground, 10)
    drawfillbox (bbottomx (2) + 20, bbottomy (2) - 1, bbottomx (2) + 23, pipeground, 10)
    drawfillbox (bbottomx (2) + 63, bbottomy (2) - 1, bbottomx (2) + 70, pipeground, 191)
    drawfillbox (bbottomx (2) + 55, bbottomy (2) - 1, bbottomx (2) + 58, pipeground, 191)

    %3rd pipe
    %top
    drawfillbox (bbottomx (3) - 3, 550, bbottomx (3) + 73, toppipey (3) - 3, 19)
    drawfillbox (bbottomx (3), 550, bbottomx (3) + 70, toppipey (3), 2)
    %gradient
    drawfillbox (bbottomx (3), 550, bbottomx (3) + 2, toppipey (3), 10)
    drawfillbox (bbottomx (3) + 3, 550, bbottomx (3) + 6, toppipey (3), 68)
    drawfillbox (bbottomx (3) + 7, 550, bbottomx (3) + 16, toppipey (3), 10)
    drawfillbox (bbottomx (3) + 20, 550, bbottomx (3) + 23, toppipey (3), 10)
    drawfillbox (bbottomx (3) + 63, 550, bbottomx (3) + 70, toppipey (3), 191)
    drawfillbox (bbottomx (3) + 55, 550, bbottomx (3) + 58, toppipey (3), 191)
    %bottom
    drawfillbox (btopx (3) - 3, toppipey (3) + 1, btopx (3) + 83, toppipey (3) - 36, 19)
    drawfillbox (btopx (3), toppipey (3) - 2, btopx (3) + 80, toppipey (3) - 33, 2)
    %gradient
    drawfillbox (btopx (3), toppipey (3) - 2, btopx (3) + 2, toppipey (3) - 33, 10)
    drawfillbox (btopx (3) + 3, toppipey (3) - 2, btopx (3) + 6, toppipey (3) - 33, 68)
    drawfillbox (btopx (3) + 7, toppipey (3) - 2, btopx (3) + 16, toppipey (3) - 33, 10)
    drawfillbox (btopx (3) + 20, toppipey (3) - 2, btopx (3) + 23, toppipey (3) - 33, 10)
    drawfillbox (btopx (3) + 73, toppipey (3) - 2, btopx (3) + 80, toppipey (3) - 33, 191)
    drawfillbox (btopx (3) + 65, toppipey (3) - 2, btopx (3) + 68, toppipey (3) - 33, 191)

    %bottom pipe
    %top
    drawfillbox (btopx (3) - 3, btopy (3) + 3, btopx (3) + 83, btopy (3) - 33, 19)
    drawfillbox (btopx (3), btopy (3), btopx (3) + 80, btopy (3) - 30, 2)
    %gradient
    drawfillbox (btopx (3), btopy (3), btopx (3) + 2, btopy (3) - 30, 10)
    drawfillbox (btopx (3) + 3, btopy (3), btopx (3) + 6, btopy (3) - 30, 68)
    drawfillbox (btopx (3) + 7, btopy (3), btopx (3) + 16, btopy (3) - 30, 10)
    drawfillbox (btopx (3) + 20, btopy (3), btopx (3) + 23, btopy (3) - 30, 10)
    drawfillbox (btopx (3) + 73, btopy (3), btopx (3) + 80, btopy (3) - 30, 191)
    drawfillbox (btopx (3) + 65, btopy (3), btopx (3) + 68, btopy (3) - 30, 191)
    %bottom
    drawfillbox (bbottomx (3) - 3, bbottomy (3), bbottomx (3) + 73, pipeground, 19)
    drawfillbox (bbottomx (3), bbottomy (3) - 1, bbottomx (3) + 70, pipeground, 2)
    %gradient
    drawfillbox (bbottomx (3), bbottomy (3) - 1, bbottomx (3) + 2, pipeground, 10)
    drawfillbox (bbottomx (3) + 3, bbottomy (3) - 1, bbottomx (3) + 6, pipeground, 68)
    drawfillbox (bbottomx (3) + 7, bbottomy (3) - 1, bbottomx (3) + 16, pipeground, 10)
    drawfillbox (bbottomx (3) + 20, bbottomy (3) - 1, bbottomx (3) + 23, pipeground, 10)
    drawfillbox (bbottomx (3) + 63, bbottomy (3) - 1, bbottomx (3) + 70, pipeground, 191)
    drawfillbox (bbottomx (3) + 55, bbottomy (3) - 1, bbottomx (3) + 58, pipeground, 191)

    %4th pipe
    %top pipe
    %top
    drawfillbox (bbottomx (4) - 3, 550, bbottomx (4) + 73, toppipey (4) - 3, 19)
    drawfillbox (bbottomx (4), 550, bbottomx (4) + 70, toppipey (4), 2)
    %gradient
    drawfillbox (bbottomx (4), 550, bbottomx (4) + 2, toppipey (4), 10)
    drawfillbox (bbottomx (4) + 3, 550, bbottomx (4) + 6, toppipey (4), 68)
    drawfillbox (bbottomx (4) + 7, 550, bbottomx (4) + 16, toppipey (4), 10)
    drawfillbox (bbottomx (4) + 20, 550, bbottomx (4) + 23, toppipey (4), 10)
    drawfillbox (bbottomx (4) + 63, 550, bbottomx (4) + 70, toppipey (4), 191)
    drawfillbox (bbottomx (4) + 55, 550, bbottomx (4) + 58, toppipey (4), 191)
    %bottom
    drawfillbox (btopx (4) - 3, toppipey (4) + 1, btopx (4) + 83, toppipey (4) - 36, 19)
    drawfillbox (btopx (4), toppipey (4) - 2, btopx (4) + 80, toppipey (4) - 33, 2)
    %gradient
    drawfillbox (btopx (4), toppipey (4) - 2, btopx (4) + 2, toppipey (4) - 33, 10)
    drawfillbox (btopx (4) + 3, toppipey (4) - 2, btopx (4) + 6, toppipey (4) - 33, 68)
    drawfillbox (btopx (4) + 7, toppipey (4) - 2, btopx (4) + 16, toppipey (4) - 33, 10)
    drawfillbox (btopx (4) + 20, toppipey (4) - 2, btopx (4) + 23, toppipey (4) - 33, 10)
    drawfillbox (btopx (4) + 73, toppipey (4) - 2, btopx (4) + 80, toppipey (4) - 33, 191)
    drawfillbox (btopx (4) + 65, toppipey (4) - 2, btopx (4) + 68, toppipey (4) - 33, 191)

    %bottom pipe
    %top
    drawfillbox (btopx (4) - 3, btopy (4) + 3, btopx (4) + 83, btopy (4) - 33, 19)
    drawfillbox (btopx (4), btopy (4), btopx (4) + 80, btopy (4) - 30, 2)
    %gradient
    drawfillbox (btopx (4), btopy (4), btopx (4) + 2, btopy (4) - 30, 10)
    drawfillbox (btopx (4) + 3, btopy (4), btopx (4) + 6, btopy (4) - 30, 68)
    drawfillbox (btopx (4) + 7, btopy (4), btopx (4) + 16, btopy (4) - 30, 10)
    drawfillbox (btopx (4) + 20, btopy (4), btopx (4) + 23, btopy (4) - 30, 10)
    drawfillbox (btopx (4) + 73, btopy (4), btopx (4) + 80, btopy (4) - 30, 191)
    drawfillbox (btopx (4) + 65, btopy (4), btopx (4) + 68, btopy (4) - 30, 191)
    %bottom
    drawfillbox (bbottomx (4) - 3, bbottomy (4), bbottomx (4) + 73, pipeground, 19)
    drawfillbox (bbottomx (4), bbottomy (4) - 1, bbottomx (4) + 70, pipeground, 2)
    %gradient
    drawfillbox (bbottomx (4), bbottomy (4) - 1, bbottomx (4) + 2, pipeground, 10)
    drawfillbox (bbottomx (4) + 3, bbottomy (4) - 1, bbottomx (4) + 6, pipeground, 68)
    drawfillbox (bbottomx (4) + 7, bbottomy (4) - 1, bbottomx (4) + 16, pipeground, 10)
    drawfillbox (bbottomx (4) + 20, bbottomy (4) - 1, bbottomx (4) + 23, pipeground, 10)
    drawfillbox (bbottomx (4) + 63, bbottomy (4) - 1, bbottomx (4) + 70, pipeground, 191)
    drawfillbox (bbottomx (4) + 55, bbottomy (4) - 1, bbottomx (4) + 58, pipeground, 191)

end draw_pipes2

procedure draw_start_button

    drawfillbox (option1_x1 - 7 - margin3, option1_y1 + 3 - margin3, option1_x1 + 70 + margin3, option1_y1 + 10 + margin3, 16) %black border
    drawfillbox (option1_x1 - 7 - margin2, option1_y1 + 5 - margin2, option1_x1 + 70 + margin2, option1_y1 + 10 + margin2, 0) %white border
    drawfillbox (option1_x1 - 12 - margin, option1_y1 - margin, option1_x1 + 75 + margin, option1_y1 + 15 + margin, colour_button_orange) %orange
    Font.Draw ("START", option1_x1, option1_y1, font, colour2)

end draw_start_button

procedure draw_score_button

    drawfillbox (option2_x1 - 3 - margin3, option2_y1 + 3 - margin3, option2_x1 + 74 + margin3, option2_y1 + 10 + margin3, 16)
    drawfillbox (option2_x1 - 3 - margin2, option2_y1 + 5 - margin2, option2_x1 + 74 + margin2, option2_y1 + 10 + margin2, 0)
    drawfillbox (option2_x1 - 8 - margin, option2_y1 - margin, option2_x1 + 79 + margin, option2_y1 + 15 + margin, colour_button_orange)
    Font.Draw ("SCORE", option2_x1, option2_y1, font, colour2)

end draw_score_button

procedure draw_title

    Pic.Draw (title, 20, bird_y + 70, picCopy)

end draw_title

procedure draw_ok_button

    drawfillbox (option1_x1 - 8 - margin3, option1_y1 + 3 - margin3, option1_x1 + 69 + margin3, option1_y1 + 10 + margin3, 16) %black border
    drawfillbox (option1_x1 - 8 - margin2, option1_y1 + 5 - margin2, option1_x1 + 69 + margin2, option1_y1 + 10 + margin2, 0) %white border
    drawfillbox (option1_x1 - 13 - margin, option1_y1 - margin, option1_x1 + 74 + margin, option1_y1 + 15 + margin, colour_button_orange) %orange
    Font.Draw ("OK", option1_x1 + 14, option1_y1, font, colour2)

end draw_ok_button

procedure draw_menu_button

    drawfillbox (option2_x1 - 4 - margin3, option2_y1 + 3 - margin3, option2_x1 + 75 + margin3, option2_y1 + 10 + margin3, 16)
    drawfillbox (option2_x1 - 4 - margin2, option2_y1 + 5 - margin2, option2_x1 + 75 + margin2, option2_y1 + 10 + margin2, 0)
    drawfillbox (option2_x1 - 9 - margin, option2_y1 - margin, option2_x1 + 80 + margin, option2_y1 + 15 + margin, colour_button_orange)
    Font.Draw ("MENU", option2_x1 + 7, option2_y1, font, colour2)

end draw_menu_button

procedure draw_performance

    for y : 225 .. 225

	drawfillbox (40, y, 410, y + 150, 19) %black border
	drawfillbox (45, y + 9, 405, y + 145, 67)  %board
	drawfillbox (45, y + 9, 405, y + 12, 43)  %bottom, orange
	drawfillbox (58, y + 18, 392, y + 21, 68) %bottom, light yellow
	drawfillbox (52, y + 22, 57, y + 132, 43)   %left, orange
	drawfillbox (45, y + 142, 405, y + 145, 68) %top, light yellow
	drawfillbox (52, y + 133, 392, y + 136, 43)  %top, orange
	drawfillbox (393, y + 22, 396, y + 132, 68)  %right, light yellow

	Font.Draw ("SCORE", 300, y + 103, font2, 68)
	Font.Draw ("SCORE", 300, y + 105, font2, 42)
	Font.Draw ("BEST", 315, y + 57, font2, 68)
	Font.Draw ("BEST", 315, y + 59, font2, 42)

	Font.Draw (intstr (score), 354 - (length (intstr (score)) - 1) * 15, 225 + 77, score_font, 68)
	Font.Draw (intstr (score), 354 - (length (intstr (score)) - 1) * 15, 225 + 79, score_font, 42)
	Font.Draw (intstr (best_score), 354 - (length (intstr (best_score)) - 1) * 15, 225 + 32, score_font, 68)
	Font.Draw (intstr (best_score), 354 - (length (intstr (best_score)) - 1) * 15, 225 + 34, score_font, 42)

	if new_score = true then
	    drawfillbox (260, y + 53, 310, y + 75, 40)
	    Font.Draw ("NEW", 264, y + 58, font2, 0)
	end if

	Font.Draw ("PERFORMANCE", 80, y + 103, font2, 68)
	Font.Draw ("PERFORMANCE", 80, y + 105, font2, 42)

	/*
	 if score >= 50 then
	 if super_bird_unlocked = false then
	 bird_y := 282
	 bird_y2 := bird_y + bird_size * 11
	 colour_bird_orange := 42
	 colour_bird_yellow := 43
	 colour_bird_light_yellow := 68
	 draw_bird
	 Font.Draw ("SUPER BIRD", 93, y + 32, font2, 68)
	 Font.Draw ("SUPER BIRD", 93, y + 34, font2, 47)
	 bird_y := 100
	 bird_y2 := bird_y + bird_size * 11
	 bird_colour_setter
	 %super_bird_unlocked := true
	 end if
	 else
	 */

	if score >= 30 and score < 40 then
	    if performance_flash mod 60 = 0 then
		colour_performance := 10
	    elsif performance_flash mod 30 = 0 then
		colour_performance := 47
	    end if
	elsif score >= 40 and score < 50 then
	    if performance_flash mod 60 = 0 then
		colour_performance := 53
	    elsif performance_flash mod 30 = 0 then
		colour_performance := 11
	    end if
	elsif score >= 50 then
	    if performance_flash mod 60 = 0 then
		colour_performance := 35
	    elsif performance_flash mod 30 = 0 then
		colour_performance := 36
	    end if
	end if
	Font.Draw (performance, performancex - (length (performance) - 1) * 6, y + 58, font2, 68)
	Font.Draw (performance, performancex - (length (performance) - 1) * 6, y + 60, font2, colour_performance)

    end for

end draw_performance

procedure game_over

    for l : 1 .. 1

	exit when exit_to_menu = true or exit_to_game = true

	drawfillbox (0, 0, maxx, maxy, 0)
	View.Update
	delay (50)

	if bird_size > 0 then
	    death_height := bird_y
	elsif bird_size < 0 then
	    death_height := bird_y2
	end if

	if score < 10 then
	    performance := "NOT BAD"
	    performancex := 146
	    colour_performance := 43
	elsif score >= 10 and score < 20 then
	    performance := "GOOD"
	    performancex := 142
	    colour_performance := 43
	elsif score >= 20 and score < 30 then
	    performance := "GREAT"
	    performancex := 144
	    colour_performance := 41
	elsif score >= 30 and score < 40 then
	    performance := "EXCELLENT"
	    performancex := 143
	    colour_performance := 47
	elsif score >= 40 and score < 50 then
	    performance := "AWESOME!"
	    performancex := 143
	    colour_performance := 11
	elsif score >= 50 then
	    performance := "AMAZING!"
	    performancex := 147
	    colour_performance := 36
	end if

	if score > best_score then
	    new_score := true
	    best_score := score
	    best_performance := performance
	    colour_best_performance := colour_performance
	end if

	for decreasing y : death_height .. 100 by dly
	    cls

	    if bird_size > 0 then
		bird_y := y
		bird_y2 := bird_y + bird_size * 11
	    elsif bird_size < 0 then
		bird_y := y - bird_size * 11
		bird_y2 := bird_y + bird_size * 11
	    end if

	    draw_background
	    draw_pipes2
	    draw_ground2
	    draw_bird

	    delay (dly)
	    View.Update
	end for

	for i : 1 .. 1
	    if bird_size > 0 then
		bird_y := 100
		bird_y2 := bird_y + bird_size * 11
	    elsif bird_size < 0 then
		bird_y := 101 - bird_size - bird_size * 11
		bird_y2 := bird_y + bird_size * 11
	    end if
	    draw_background
	    draw_pipes2
	    draw_ground
	    draw_bird
	    delay (dly)
	    View.Update
	end for

	for y : 0 .. 225 by dly
	    cls
	    draw_background
	    draw_pipes2
	    draw_ground2
	    draw_bird

	    drawfillbox (40, y, 410, y + 150, 19) %black border
	    drawfillbox (45, y + 9, 405, y + 145, 67) %board
	    drawfillbox (45, y + 9, 405, y + 12, 43) %bottom, orange
	    drawfillbox (58, y + 18, 392, y + 21, 68) %bottom, light yellow
	    drawfillbox (52, y + 22, 57, y + 132, 43) %left, orange
	    drawfillbox (45, y + 142, 405, y + 145, 68) %top, light yellow
	    drawfillbox (52, y + 133, 392, y + 136, 43) %top, orange
	    drawfillbox (393, y + 22, 396, y + 132, 68) %right, light yellow

	    Font.Draw ("PERFORMANCE", 80, y + 103, font2, 68)
	    Font.Draw ("PERFORMANCE", 80, y + 105, font2, 42)
	    Font.Draw ("SCORE", 300, y + 103, font2, 68)
	    Font.Draw ("SCORE", 300, y + 105, font2, 42)
	    Font.Draw ("BEST", 315, y + 57, font2, 68)
	    Font.Draw ("BEST", 315, y + 59, font2, 42)

	    if new_score = true then
		drawfillbox (260, y + 53, 310, y + 75, 40)
		Font.Draw ("NEW", 264, y + 58, font2, 0)
	    end if

	    delay (dly)
	    View.Update
	end for

	for i : 1 .. maxint

	    Font.Draw (intstr (score), 354 - (length (intstr (score)) - 1) * 15, 225 + 77, score_font, 68)
	    Font.Draw (intstr (score), 354 - (length (intstr (score)) - 1) * 15, 225 + 79, score_font, 42)
	    Font.Draw (intstr (best_score), 354 - (length (intstr (best_score)) - 1) * 15, 225 + 32, score_font, 68)
	    Font.Draw (intstr (best_score), 354 - (length (intstr (best_score)) - 1) * 15, 225 + 34, score_font, 42)

	    draw_menu_button
	    draw_ok_button

	    draw_bird

	    performance_flash := i
	    draw_performance
	    View.Update
	    delay (dly)
	    mousewhere (mousex, mousey, mouseclick)

	    if mouseclick = 1 then
		if mousex > option1_x1 - 8 - margin3 and mousex < option1_x1 + 69 + margin3 and mousey > option1_y1 + 3 - margin3 and mousey < option1_y1 + 10 + margin3 then
		    loop
			mousewhere (mousex, mousey, mouseclick)

			draw_background
			draw_pipes2
			draw_ground2
			draw_bird

			draw_menu_button
			option1_y1 := option1_y1 - 5
			draw_ok_button

			draw_performance

			View.Update

			option1_y1 := option1_y1 + 5

			exit_to_game := true

			exit when mouseclick not= 1
		    end loop
		    exit
		elsif mousex > option2_x1 - 4 - margin3 and mousex < option2_x1 + 75 + margin3 and mousey > option2_y1 + 3 - margin3 and mousey < option2_y1 + 10 + margin3 then
		    loop
			mousewhere (mousex, mousey, mouseclick)

			draw_background
			draw_pipes2
			draw_ground2
			draw_bird

			draw_ok_button
			option2_y1 := option2_y1 - 5
			draw_menu_button

			draw_performance

			View.Update

			option2_y1 := option2_y1 + 5

			exit_to_menu := true

			exit when mouseclick not= 1
		    end loop
		end if
	    end if
	    if exit_to_menu = true or exit_to_game = true then
		reset
		exit
	    end if
	end for

    end for

end game_over

procedure death_checker

    if bird_size > 0 then
	for pipetop : 1 .. 4
	    if bird_x2 >= bbottomx (pipetop) - 3 and bird_x2 <= bbottomx (pipetop) + 73 and bird_y2 >= toppipey (pipetop) - 3 then
		game_over
		if exit_to_menu = true then
		    exit
		end if
		if exit_to_game = true then
		    exit
		end if
	    end if
	    if bird_x2 >= btopx (pipetop) - 3 and bird_x2 <= btopx (pipetop) + 83 and bird_y2 <= toppipey (pipetop) + 1 and bird_y2 >= toppipey (pipetop) - 36 then
		game_over
		if exit_to_menu = true then
		    exit
		end if
		if exit_to_game = true then
		    exit
		end if
	    end if
	    if bird_x >= btopx (pipetop) - 3 and bird_x <= btopx (pipetop) + 83 and bird_y2 <= toppipey (pipetop) + 1 and bird_y2 >= toppipey (pipetop) - 36 then
		game_over
		if exit_to_menu = true then
		    exit
		end if
		if exit_to_game = true then
		    exit
		end if
	    end if
	    if bird_x2 >= bbottomx (pipetop) - 3 and bird_x2 <= bbottomx (pipetop) + 73 and bird_y <= bbottomy (pipetop) then
		game_over
		if exit_to_menu = true then
		    exit
		end if
		if exit_to_game = true then
		    exit
		end if
	    end if
	    if bird_x2 >= btopx (pipetop) - 3 and bird_x2 <= btopx (pipetop) + 83 and bird_y <= btopy (pipetop) and bird_y >= btopy (pipetop) - 30 then
		game_over
		if exit_to_menu = true then
		    exit
		end if
		if exit_to_game = true then
		    exit
		end if
	    end if
	    if bird_x >= bbottomx (pipetop) - 3 and bird_x <= bbottomx (pipetop) + 73 and bird_y <= bbottomy (pipetop) then
		game_over
		if exit_to_menu = true then
		    exit
		end if
	    end if
	    if bird_x >= btopx (pipetop) - 3 and bird_x <= btopx (pipetop) + 83 and bird_y <= btopy (pipetop) + 3 and bird_y >= btopy (pipetop) - 33 then
		game_over
		if exit_to_menu = true then
		    exit
		end if
	    end if
	end for
    elsif bird_size < 0 then
	for pipetop : 1 .. 4
	    if bird_x >= bbottomx (pipetop) - 3 and bird_x <= bbottomx (pipetop) + 73 and bird_y >= toppipey (pipetop) - 3 then
		game_over
		if exit_to_menu = true then
		    exit
		end if
		if exit_to_game = true then
		    exit
		end if
	    end if
	    if bird_x >= btopx (pipetop) - 3 and bird_x <= btopx (pipetop) + 83 and bird_y <= toppipey (pipetop) + 1 and bird_y >= toppipey (pipetop) - 36 then
		game_over
		if exit_to_menu = true then
		    exit
		end if
		if exit_to_game = true then
		    exit
		end if
	    end if
	    if bird_x2 >= btopx (pipetop) - 3 and bird_x2 <= btopx (pipetop) + 83 and bird_y <= toppipey (pipetop) + 1 and bird_y >= toppipey (pipetop) - 36 then
		game_over
		if exit_to_menu = true then
		    exit
		end if
		if exit_to_game = true then
		    exit
		end if
	    end if
	    if bird_x >= bbottomx (pipetop) - 3 and bird_x <= bbottomx (pipetop) + 73 and bird_y2 <= bbottomy (pipetop) then
		game_over
		if exit_to_menu = true then
		    exit
		end if
		if exit_to_game = true then
		    exit
		end if
	    end if
	    if bird_x >= btopx (pipetop) - 3 and bird_x <= btopx (pipetop) + 83 and bird_y2 <= btopy (pipetop) and bird_y2 >= btopy (pipetop) - 30 then
		game_over
		if exit_to_menu = true then
		    exit
		end if
		if exit_to_game = true then
		    exit
		end if
	    end if
	    if bird_x2 >= bbottomx (pipetop) - 3 and bird_x2 <= bbottomx (pipetop) + 73 and bird_y2 <= bbottomy (pipetop) then
		game_over
		if exit_to_menu = true then
		    exit
		end if
	    end if
	    if bird_x2 >= btopx (pipetop) - 3 and bird_x2 <= btopx (pipetop) + 83 and bird_y2 <= btopy (pipetop) + 3 and bird_y2 >= btopy (pipetop) - 33 then
		game_over
		if exit_to_menu = true then
		    exit
		end if
	    end if
	end for
    end if

    if bird_size < 0 then
	if bird_y <= 113 - bird_size then
	    game_over
	end if
    end if

    if bird_y <= 100 then
	game_over
    end if

end death_checker

procedure score_checker

    scorecounting += 1
    if bird_y < toppipey (scorecounting) - 33 and bird_y > btopy (scorecounting) and bird_x >= btopx (scorecounting) + 70 and bird_x <= btopx (scorecounting) + 72 then
	score += 1
    end if
    if scorecounting = 4 then
	scorecounting := 0
    end if

end score_checker

procedure draw_pipes

    for i : 1 .. 1
	%first pipe
	if bbottomx (4) < bbottomx (1) and pipecounter4 = 1 then
	    bbottomx (1) := bbottomx (4) + pipe_distance
	    btopx (1) := bbottomx (4) + pipe_distance
	end if
	btopy (1) := bbottomy (1) + 33
	toppipey (1) := bbottomy (1) + 200
	%top pipe
	%top
	drawfillbox (bbottomx (1) - 3, 550, bbottomx (1) + 73, toppipey (1) - 3, 19)
	drawfillbox (bbottomx (1), 550, bbottomx (1) + 70, toppipey (1), 2)
	%gradient
	drawfillbox (bbottomx (1), 550, bbottomx (1) + 2, toppipey (1), 10)
	drawfillbox (bbottomx (1) + 3, 550, bbottomx (1) + 6, toppipey (1), 68)
	drawfillbox (bbottomx (1) + 7, 550, bbottomx (1) + 16, toppipey (1), 10)
	drawfillbox (bbottomx (1) + 20, 550, bbottomx (1) + 23, toppipey (1), 10)
	drawfillbox (bbottomx (1) + 63, 550, bbottomx (1) + 70, toppipey (1), 191)
	drawfillbox (bbottomx (1) + 55, 550, bbottomx (1) + 58, toppipey (1), 191)
	%bottom
	drawfillbox (btopx (1) - 3, toppipey (1) + 1, btopx (1) + 83, toppipey (1) - 36, 19)
	drawfillbox (btopx (1), toppipey (1) - 2, btopx (1) + 80, toppipey (1) - 33, 2)
	%gradient
	drawfillbox (btopx (1), toppipey (1) - 2, btopx (1) + 2, toppipey (1) - 33, 10)
	drawfillbox (btopx (1) + 3, toppipey (1) - 2, btopx (1) + 6, toppipey (1) - 33, 68)
	drawfillbox (btopx (1) + 7, toppipey (1) - 2, btopx (1) + 16, toppipey (1) - 33, 10)
	drawfillbox (btopx (1) + 20, toppipey (1) - 2, btopx (1) + 23, toppipey (1) - 33, 10)
	drawfillbox (btopx (1) + 73, toppipey (1) - 2, btopx (1) + 80, toppipey (1) - 33, 191)
	drawfillbox (btopx (1) + 65, toppipey (1) - 2, btopx (1) + 68, toppipey (1) - 33, 191)

	%bottom pipe
	%top
	drawfillbox (btopx (1) - 3, btopy (1) + 3, btopx (1) + 83, btopy (1) - 33, 19)
	drawfillbox (btopx (1), btopy (1), btopx (1) + 80, btopy (1) - 30, 2)
	%gradient
	drawfillbox (btopx (1), btopy (1), btopx (1) + 2, btopy (1) - 30, 10)
	drawfillbox (btopx (1) + 3, btopy (1), btopx (1) + 6, btopy (1) - 30, 68)
	drawfillbox (btopx (1) + 7, btopy (1), btopx (1) + 16, btopy (1) - 30, 10)
	drawfillbox (btopx (1) + 20, btopy (1), btopx (1) + 23, btopy (1) - 30, 10)
	drawfillbox (btopx (1) + 73, btopy (1), btopx (1) + 80, btopy (1) - 30, 191)
	drawfillbox (btopx (1) + 65, btopy (1), btopx (1) + 68, btopy (1) - 30, 191)
	%bottom
	drawfillbox (bbottomx (1) - 3, bbottomy (1), bbottomx (1) + 73, pipeground, 19)
	drawfillbox (bbottomx (1), bbottomy (1) - 1, bbottomx (1) + 70, pipeground, 2)
	%gradient
	drawfillbox (bbottomx (1), bbottomy (1) - 1, bbottomx (1) + 2, pipeground, 10)
	drawfillbox (bbottomx (1) + 3, bbottomy (1) - 1, bbottomx (1) + 6, pipeground, 68)
	drawfillbox (bbottomx (1) + 7, bbottomy (1) - 1, bbottomx (1) + 16, pipeground, 10)
	drawfillbox (bbottomx (1) + 20, bbottomy (1) - 1, bbottomx (1) + 23, pipeground, 10)
	drawfillbox (bbottomx (1) + 63, bbottomy (1) - 1, bbottomx (1) + 70, pipeground, 191)
	drawfillbox (bbottomx (1) + 55, bbottomy (1) - 1, bbottomx (1) + 58, pipeground, 191)
	bbottomx (1) += pipe_speed
	btopx (1) += pipe_speed
	score_checker
	death_checker

	%second pipe
	if bbottomx (1) > 0 and pipecounter = 1 then
	    bbottomx (2) := bbottomx (1) + pipe_distance
	    btopx (2) := btopx (1) + pipe_distance
	end if
	btopy (1 + 1) := bbottomy (1 + 1) + 33
	toppipey (1 + 1) := bbottomy (1 + 1) + 200
	death_checker

	%top pipe
	%top
	drawfillbox (bbottomx (2) - 3, 550, bbottomx (2) + 73, toppipey (2) - 3, 19)
	drawfillbox (bbottomx (2), 550, bbottomx (2) + 70, toppipey (2), 2)
	%gradient
	drawfillbox (bbottomx (2), 550, bbottomx (2) + 2, toppipey (2), 10)
	drawfillbox (bbottomx (2) + 3, 550, bbottomx (2) + 6, toppipey (2), 68)
	drawfillbox (bbottomx (2) + 7, 550, bbottomx (2) + 16, toppipey (2), 10)
	drawfillbox (bbottomx (2) + 20, 550, bbottomx (2) + 23, toppipey (2), 10)
	drawfillbox (bbottomx (2) + 63, 550, bbottomx (2) + 70, toppipey (2), 191)
	drawfillbox (bbottomx (2) + 55, 550, bbottomx (2) + 58, toppipey (2), 191)
	%bottom
	drawfillbox (btopx (2) - 3, toppipey (2) + 1, btopx (2) + 83, toppipey (2) - 36, 19)
	drawfillbox (btopx (2), toppipey (2) - 2, btopx (2) + 80, toppipey (2) - 33, 2)
	%gradient
	drawfillbox (btopx (2), toppipey (2) - 2, btopx (2) + 2, toppipey (2) - 33, 10)
	drawfillbox (btopx (2) + 3, toppipey (2) - 2, btopx (2) + 6, toppipey (2) - 33, 68)
	drawfillbox (btopx (2) + 7, toppipey (2) - 2, btopx (2) + 16, toppipey (2) - 33, 10)
	drawfillbox (btopx (2) + 20, toppipey (2) - 2, btopx (2) + 23, toppipey (2) - 33, 10)
	drawfillbox (btopx (2) + 73, toppipey (2) - 2, btopx (2) + 80, toppipey (2) - 33, 191)
	drawfillbox (btopx (2) + 65, toppipey (2) - 2, btopx (2) + 68, toppipey (2) - 33, 191)

	%bottom pipe
	%top
	drawfillbox (btopx (2) - 3, btopy (2) + 3, btopx (2) + 83, btopy (2) - 33, 19)
	drawfillbox (btopx (2), btopy (2), btopx (2) + 80, btopy (2) - 30, 2)
	%gradient
	drawfillbox (btopx (2), btopy (2), btopx (2) + 2, btopy (2) - 30, 10)
	drawfillbox (btopx (2) + 3, btopy (2), btopx (2) + 6, btopy (2) - 30, 68)
	drawfillbox (btopx (2) + 7, btopy (2), btopx (2) + 16, btopy (2) - 30, 10)
	drawfillbox (btopx (2) + 20, btopy (2), btopx (2) + 23, btopy (2) - 30, 10)
	drawfillbox (btopx (2) + 73, btopy (2), btopx (2) + 80, btopy (2) - 30, 191)
	drawfillbox (btopx (2) + 65, btopy (2), btopx (2) + 68, btopy (2) - 30, 191)
	%bottom
	drawfillbox (bbottomx (2) - 3, bbottomy (2), bbottomx (2) + 73, pipeground, 19)
	drawfillbox (bbottomx (2), bbottomy (2) - 1, bbottomx (2) + 70, pipeground, 2)
	%gradient
	drawfillbox (bbottomx (2), bbottomy (2) - 1, bbottomx (2) + 2, pipeground, 10)
	drawfillbox (bbottomx (2) + 3, bbottomy (2) - 1, bbottomx (2) + 6, pipeground, 68)
	drawfillbox (bbottomx (2) + 7, bbottomy (2) - 1, bbottomx (2) + 16, pipeground, 10)
	drawfillbox (bbottomx (2) + 20, bbottomy (2) - 1, bbottomx (2) + 23, pipeground, 10)
	drawfillbox (bbottomx (2) + 63, bbottomy (2) - 1, bbottomx (2) + 70, pipeground, 191)
	drawfillbox (bbottomx (2) + 55, bbottomy (2) - 1, bbottomx (2) + 58, pipeground, 191)
	bbottomx (1 + 1) += pipe_speed
	btopx (1 + 1) += pipe_speed
	score_checker
	death_checker

	%3rd pipe
	if bbottomx (2) > 0 and pipecounter2 = 1 then
	    bbottomx (3) := bbottomx (2) + pipe_distance
	    btopx (3) := btopx (2) + pipe_distance
	end if

	btopy (1 + 2) := bbottomy (1 + 2) + 33
	toppipey (1 + 2) := bbottomy (1 + 2) + 200
	death_checker

	%top
	drawfillbox (bbottomx (3) - 3, 550, bbottomx (3) + 73, toppipey (3) - 3, 19)
	drawfillbox (bbottomx (3), 550, bbottomx (3) + 70, toppipey (3), 2)
	%gradient
	drawfillbox (bbottomx (3), 550, bbottomx (3) + 2, toppipey (3), 10)
	drawfillbox (bbottomx (3) + 3, 550, bbottomx (3) + 6, toppipey (3), 68)
	drawfillbox (bbottomx (3) + 7, 550, bbottomx (3) + 16, toppipey (3), 10)
	drawfillbox (bbottomx (3) + 20, 550, bbottomx (3) + 23, toppipey (3), 10)
	drawfillbox (bbottomx (3) + 63, 550, bbottomx (3) + 70, toppipey (3), 191)
	drawfillbox (bbottomx (3) + 55, 550, bbottomx (3) + 58, toppipey (3), 191)
	%bottom
	drawfillbox (btopx (3) - 3, toppipey (3) + 1, btopx (3) + 83, toppipey (3) - 36, 19)
	drawfillbox (btopx (3), toppipey (3) - 2, btopx (3) + 80, toppipey (3) - 33, 2)
	%gradient
	drawfillbox (btopx (3), toppipey (3) - 2, btopx (3) + 2, toppipey (3) - 33, 10)
	drawfillbox (btopx (3) + 3, toppipey (3) - 2, btopx (3) + 6, toppipey (3) - 33, 68)
	drawfillbox (btopx (3) + 7, toppipey (3) - 2, btopx (3) + 16, toppipey (3) - 33, 10)
	drawfillbox (btopx (3) + 20, toppipey (3) - 2, btopx (3) + 23, toppipey (3) - 33, 10)
	drawfillbox (btopx (3) + 73, toppipey (3) - 2, btopx (3) + 80, toppipey (3) - 33, 191)
	drawfillbox (btopx (3) + 65, toppipey (3) - 2, btopx (3) + 68, toppipey (3) - 33, 191)

	%bottom pipe
	%top
	drawfillbox (btopx (3) - 3, btopy (3) + 3, btopx (3) + 83, btopy (3) - 33, 19)
	drawfillbox (btopx (3), btopy (3), btopx (3) + 80, btopy (3) - 30, 2)
	%gradient
	drawfillbox (btopx (3), btopy (3), btopx (3) + 2, btopy (3) - 30, 10)
	drawfillbox (btopx (3) + 3, btopy (3), btopx (3) + 6, btopy (3) - 30, 68)
	drawfillbox (btopx (3) + 7, btopy (3), btopx (3) + 16, btopy (3) - 30, 10)
	drawfillbox (btopx (3) + 20, btopy (3), btopx (3) + 23, btopy (3) - 30, 10)
	drawfillbox (btopx (3) + 73, btopy (3), btopx (3) + 80, btopy (3) - 30, 191)
	drawfillbox (btopx (3) + 65, btopy (3), btopx (3) + 68, btopy (3) - 30, 191)
	%bottom
	drawfillbox (bbottomx (3) - 3, bbottomy (3), bbottomx (3) + 73, pipeground, 19)
	drawfillbox (bbottomx (3), bbottomy (3) - 1, bbottomx (3) + 70, pipeground, 2)
	%gradient
	drawfillbox (bbottomx (3), bbottomy (3) - 1, bbottomx (3) + 2, pipeground, 10)
	drawfillbox (bbottomx (3) + 3, bbottomy (3) - 1, bbottomx (3) + 6, pipeground, 68)
	drawfillbox (bbottomx (3) + 7, bbottomy (3) - 1, bbottomx (3) + 16, pipeground, 10)
	drawfillbox (bbottomx (3) + 20, bbottomy (3) - 1, bbottomx (3) + 23, pipeground, 10)
	drawfillbox (bbottomx (3) + 63, bbottomy (3) - 1, bbottomx (3) + 70, pipeground, 191)
	drawfillbox (bbottomx (3) + 55, bbottomy (3) - 1, bbottomx (3) + 58, pipeground, 191)
	bbottomx (1 + 2) += pipe_speed
	btopx (1 + 2) += pipe_speed
	score_checker
	death_checker

	%4th pipe
	if bbottomx (3) > 0 and pipecounter3 = 1 then
	    bbottomx (4) := bbottomx (3) + pipe_distance
	    btopx (4) := btopx (3) + pipe_distance
	end if

	btopy (4) := bbottomy (4) + 33
	toppipey (4) := bbottomy (4) + 200
	death_checker

	%top pipe
	%top
	drawfillbox (bbottomx (4) - 3, 550, bbottomx (4) + 73, toppipey (4) - 3, 19)
	drawfillbox (bbottomx (4), 550, bbottomx (4) + 70, toppipey (4), 2)
	%gradient
	drawfillbox (bbottomx (4), 550, bbottomx (4) + 2, toppipey (4), 10)
	drawfillbox (bbottomx (4) + 3, 550, bbottomx (4) + 6, toppipey (4), 68)
	drawfillbox (bbottomx (4) + 7, 550, bbottomx (4) + 16, toppipey (4), 10)
	drawfillbox (bbottomx (4) + 20, 550, bbottomx (4) + 23, toppipey (4), 10)
	drawfillbox (bbottomx (4) + 63, 550, bbottomx (4) + 70, toppipey (4), 191)
	drawfillbox (bbottomx (4) + 55, 550, bbottomx (4) + 58, toppipey (4), 191)
	%bottom
	drawfillbox (btopx (4) - 3, toppipey (4) + 1, btopx (4) + 83, toppipey (4) - 36, 19)
	drawfillbox (btopx (4), toppipey (4) - 2, btopx (4) + 80, toppipey (4) - 33, 2)
	%gradient
	drawfillbox (btopx (4), toppipey (4) - 2, btopx (4) + 2, toppipey (4) - 33, 10)
	drawfillbox (btopx (4) + 3, toppipey (4) - 2, btopx (4) + 6, toppipey (4) - 33, 68)
	drawfillbox (btopx (4) + 7, toppipey (4) - 2, btopx (4) + 16, toppipey (4) - 33, 10)
	drawfillbox (btopx (4) + 20, toppipey (4) - 2, btopx (4) + 23, toppipey (4) - 33, 10)
	drawfillbox (btopx (4) + 73, toppipey (4) - 2, btopx (4) + 80, toppipey (4) - 33, 191)
	drawfillbox (btopx (4) + 65, toppipey (4) - 2, btopx (4) + 68, toppipey (4) - 33, 191)

	%bottom pipe
	%top
	drawfillbox (btopx (4) - 3, btopy (4) + 3, btopx (4) + 83, btopy (4) - 33, 19)
	drawfillbox (btopx (4), btopy (4), btopx (4) + 80, btopy (4) - 30, 2)
	%gradient
	drawfillbox (btopx (4), btopy (4), btopx (4) + 2, btopy (4) - 30, 10)
	drawfillbox (btopx (4) + 3, btopy (4), btopx (4) + 6, btopy (4) - 30, 68)
	drawfillbox (btopx (4) + 7, btopy (4), btopx (4) + 16, btopy (4) - 30, 10)
	drawfillbox (btopx (4) + 20, btopy (4), btopx (4) + 23, btopy (4) - 30, 10)
	drawfillbox (btopx (4) + 73, btopy (4), btopx (4) + 80, btopy (4) - 30, 191)
	drawfillbox (btopx (4) + 65, btopy (4), btopx (4) + 68, btopy (4) - 30, 191)
	%bottom
	drawfillbox (bbottomx (4) - 3, bbottomy (4), bbottomx (4) + 73, pipeground, 19)
	drawfillbox (bbottomx (4), bbottomy (4) - 1, bbottomx (4) + 70, pipeground, 2)
	%gradient
	drawfillbox (bbottomx (4), bbottomy (4) - 1, bbottomx (4) + 2, pipeground, 10)
	drawfillbox (bbottomx (4) + 3, bbottomy (4) - 1, bbottomx (4) + 6, pipeground, 68)
	drawfillbox (bbottomx (4) + 7, bbottomy (4) - 1, bbottomx (4) + 16, pipeground, 10)
	drawfillbox (bbottomx (4) + 20, bbottomy (4) - 1, bbottomx (4) + 23, pipeground, 10)
	drawfillbox (bbottomx (4) + 63, bbottomy (4) - 1, bbottomx (4) + 70, pipeground, 191)
	drawfillbox (bbottomx (4) + 55, bbottomy (4) - 1, bbottomx (4) + 58, pipeground, 191)
	bbottomx (4) += pipe_speed
	btopx (4) += pipe_speed
	score_checker
	death_checker

	if bbottomx (1) + 72 <= 0 then
	    pipecounter4 := 1
	    randint (bbottomy (1), 120, 335)
	    btopy (1) := bbottomy (1) + 33
	    toppipey (1) := bbottomy (1) + 200
	    pipecounter := 0
	end if
	if bbottomx (2) + 72 <= 0 then
	    btopx (2) := 455 + pipe_distance
	    bbottomx (2) := 460 + pipe_distance
	    randint (bbottomy (2), 120, 335)
	    btopy (2) := bbottomy (2) + 33
	    toppipey (2) := bbottomy (2) + 200
	    pipecounter := 1
	    pipecounter2 := 0
	end if
	if bbottomx (3) + 72 <= 0 then
	    btopx (3) := 395 + pipe_distance
	    bbottomx (3) := 400 + pipe_distance
	    randint (bbottomy (3), 120, 335)
	    btopy (3) := bbottomy (3) + 33
	    toppipey (3) := bbottomy (3) + 200
	    pipecounter2 := 1
	    pipecounter3 := 0
	end if
	if bbottomx (4) + 72 <= 0 then
	    btopx (4) := 395 + pipe_distance
	    bbottomx (4) := 400 + pipe_distance
	    randint (bbottomy (4), 120, 335)
	    btopy (4) := bbottomy (4) + 33
	    toppipey (4) := bbottomy (4) + 200
	    pipecounter3 := 1
	    pipecounter4 := 0
	end if
    end for

end draw_pipes

procedure draw_score

    Font.Draw (intstr (score), 218 - (length (intstr (score)) - 1) * 8, 447, title_font, 16)
    Font.Draw (intstr (score), 218 - (length (intstr (score)) - 1) * 8, 450, title_font, 0)

end draw_score

procedure draw_pause_button

    drawfillbox (pause_x1, pause_y1, pause_x1 + pause_size, pause_y1 + pause_size + 2, 16)
    drawfillbox (pause_x1 + pause_margin2, pause_y1 + pause_margin2 + 2, pause_x1 + pause_size - pause_margin2, pause_y1 + pause_size - pause_margin2 + 2, 0)
    drawfillbox (pause_x1 + pause_margin3, pause_y1 + pause_margin3 + 2, pause_x1 + pause_size - pause_margin3, pause_y1 + pause_size - pause_margin3 + 2, 42)

    drawfillbox (pause_x1 + 10, pause_y1 + 9, pause_x1 + 13, pause_y1 + 23, 114)
    drawfillbox (pause_x1 + 17, pause_y1 + 9, pause_x1 + 20, pause_y1 + 23, 114)

    drawfillbox (pause_x1 + 10, pause_y1 + 11, pause_x1 + 13, pause_y1 + 23, 0)
    drawfillbox (pause_x1 + 17, pause_y1 + 11, pause_x1 + 20, pause_y1 + 23, 0)

end draw_pause_button

procedure draw_paused_button

    drawfillbox (pause_x1, pause_y1, pause_x1 + pause_size, pause_y1 + pause_size + 2, 16)
    drawfillbox (pause_x1 + pause_margin2, pause_y1 + pause_margin2 + 2, pause_x1 + pause_size - pause_margin2, pause_y1 + pause_size - pause_margin2 + 2, 0)
    drawfillbox (pause_x1 + pause_margin3, pause_y1 + pause_margin3 + 2, pause_x1 + pause_size - pause_margin3, pause_y1 + pause_size - pause_margin3 + 2, 42)

    drawfillbox (pause_x1 + 12, pause_y1 + 9, pause_x1 + 14, pause_y1 + 24, 114)
    drawfillbox (pause_x1 + 14, pause_y1 + 11, pause_x1 + 16, pause_y1 + 22, 114)
    drawfillbox (pause_x1 + 16, pause_y1 + 13, pause_x1 + 18, pause_y1 + 20, 114)
    drawfillbox (pause_x1 + 18, pause_y1 + 15, pause_x1 + 20, pause_y1 + 18, 114)

    drawfillbox (pause_x1 + 12, pause_y1 + 11, pause_x1 + 14, pause_y1 + 24, 0)
    drawfillbox (pause_x1 + 14, pause_y1 + 13, pause_x1 + 16, pause_y1 + 22, 0)
    drawfillbox (pause_x1 + 16, pause_y1 + 15, pause_x1 + 18, pause_y1 + 20, 0)
    drawfillbox (pause_x1 + 18, pause_y1 + 17, pause_x1 + 20, pause_y1 + 18, 0)

end draw_paused_button

procedure draw_hover (waiting : int)

    if bird_hover_up = true and player_ready = false then
	bird_y := bird_y + 1
	bird_y2 := bird_y + bird_size * 11
	if bird_y = max_hover_height then
	    bird_hover_up := false
	end if
    elsif bird_hover_up = false and player_ready = false then
	bird_y := bird_y - 1
	bird_y2 := bird_y + bird_size * 11
	if bird_y = min_hover_height then
	    bird_hover_up := true
	end if
    end if

    if player_ready = false then
	if bird_size > 0 then
	    if waiting mod 24 >= 0 and waiting mod 24 <= 5 then
		draw_bird
	    elsif waiting mod 24 >= 6 and waiting mod 24 <= 11 then
		draw_bird2
	    elsif waiting mod 24 >= 12 and waiting mod 24 <= 17 then
		draw_bird3
	    elsif waiting mod 24 >= 18 and waiting mod 24 <= 23 then
		draw_bird2
	    end if
	else
	    if waiting mod 24 >= 0 and waiting mod 24 <= 5 then
		draw_bird3
	    elsif waiting mod 24 >= 6 and waiting mod 24 <= 11 then
		draw_bird2
	    elsif waiting mod 24 >= 12 and waiting mod 24 <= 17 then
		draw_bird
	    elsif waiting mod 24 >= 18 and waiting mod 24 <= 23 then
		draw_bird2
	    end if
	end if
    else
	if bird_size > 0 then
	    draw_bird
	else
	    draw_bird3
	end if
    end if

end draw_hover

procedure draw_ready

    %white
    drawfillbox (ready_x + ready_size, ready_y + ready_size, ready_x + ready_size * 6, ready_y + ready_size * 5, colour_ready_white) %bottom half, middle
    drawfillbox (ready_x + ready_size, ready_y + ready_size * 6, ready_x + ready_size * 3, ready_y + ready_size * 10, colour_ready_white) %top half, left click
    drawfillbox (ready_x + ready_size * 4, ready_y + ready_size * 6, ready_x + ready_size * 6, ready_y + ready_size * 10, colour_ready_white) %top half, right click

    for range : 50 .. 100
	if waiting mod 100 = range then
	    %red
	    drawfillbox (ready_x + ready_size, ready_y + ready_size * 6, ready_x + ready_size * 3, ready_y + ready_size * 10, colour_ready_red) %top half, left click
	    drawfillbox (ready_x + ready_size * 3, ready_y + ready_size * 13, ready_x + ready_size * 4, ready_y + ready_size * 15, colour_ready_border) %middle line
	    drawfillbox (ready_x + ready_size * 6, ready_y + ready_size * 12, ready_x + ready_size * 7, ready_y + ready_size * 13, colour_ready_border) %right line bottom pixel
	    drawfillbox (ready_x + ready_size * 7, ready_y + ready_size * 13, ready_x + ready_size * 8, ready_y + ready_size * 14, colour_ready_border) %right line top pixel
	    drawfillbox (ready_x, ready_y + ready_size * 12, ready_x + ready_size, ready_y + ready_size * 13, colour_ready_border) %left line bottom pixel
	    drawfillbox (ready_x, ready_y + ready_size * 13, ready_x - ready_size, ready_y + ready_size * 14, colour_ready_border) %left line bottom pixel
	end if
    end for

    %border
    drawfillbox (ready_x, ready_y + ready_size * 2, ready_x + ready_size, ready_y + ready_size * 9, colour_ready_border) %left side
    drawfillbox (ready_x + ready_size, ready_y + ready_size, ready_x + ready_size * 2, ready_y + ready_size * 2, colour_ready_border) %diagonal down from latter
    drawfillbox (ready_x + ready_size * 2, ready_y, ready_x + ready_size * 5, ready_y + ready_size, colour_ready_border) %bottom side
    drawfillbox (ready_x + ready_size * 5, ready_y + ready_size, ready_x + ready_size * 6, ready_y + ready_size * 2, colour_ready_border) %diagonal up from latter
    drawfillbox (ready_x + ready_size * 6, ready_y + ready_size * 2, ready_x + ready_size * 7, ready_y + ready_size * 9, colour_ready_border) %right side
    drawfillbox (ready_x + ready_size * 5, ready_y + ready_size * 9, ready_x + ready_size * 6, ready_y + ready_size * 10, colour_ready_border) %diagonal up from latter
    drawfillbox (ready_x + ready_size * 2, ready_y + ready_size * 10, ready_x + ready_size * 5, ready_y + ready_size * 11, colour_ready_border) %top side
    drawfillbox (ready_x + ready_size, ready_y + ready_size * 9, ready_x + ready_size * 2, ready_y + ready_size * 10, colour_ready_border) %diagonal down from latter
    drawfillbox (ready_x + ready_size * 3, ready_y + ready_size * 10, ready_x + ready_size * 4, ready_y + ready_size * 6, colour_ready_border) %middle vertical line
    drawfillbox (ready_x + ready_size, ready_y + ready_size * 5, ready_x + ready_size * 6, ready_y + ready_size * 6, colour_ready_border) %middle horizontal line

end draw_ready

procedure bird_colour_toggler

    if mouseclicked = false then
	if mouseclick = 1 then
	    if mousex > bird_x and mousex < bird_x2 and mousey > bird_y and mousey < bird_y2 then
		bird_colour += 1
		mouseclicked := true
	    elsif bird_size < 0 and mousex < bird_x and mousex > bird_x2 and mousey < bird_y and mousey > bird_y2 then
		bird_colour += 1
		mouseclicked := true
	    end if
	end if
    end if

    if mouseclick not= 1 then
	mouseclicked := false
    end if

    if bird_colour > 10 then
	bird_colour := 1
    end if

    bird_colour_setter

end bird_colour_toggler

procedure game_pause

    option2_x1 := 188
    option2_y1 := 35

    loop
	cls
	draw_background
	draw_pipes2
	draw_ground
	draw_bird
	draw_paused_button
	draw_score
	draw_menu_button
	View.Update
	Input.KeyDown (key)
	if key (KEY_ESC) then
	else
	    exit
	end if
    end loop

    loop
	cls
	draw_background
	draw_pipes2
	draw_ground
	draw_bird
	draw_paused_button
	draw_score
	draw_menu_button
	View.Update
	mousewhere (mousex, mousey, mouseclick)
	exit when mouseclick not= 1
    end loop

    loop
	waiting += 1
	cls
	draw_background
	draw_pipes2
	draw_ground2
	draw_paused_button
	draw_score
	draw_menu_button

	if super_bird = true then
	    draw_bird
	else
	    draw_hover (waiting)
	end if

	View.Update
	delay (dly)
	Input.KeyDown (key)
	if key (KEY_ESC) then
	    loop
		Input.KeyDown (key)
		if key (KEY_ESC) then
		else
		    exit
		end if
	    end loop
	    exit
	end if
	mousewhere (mousex, mousey, mouseclick)

	easter_egg_toggler

	if mouseclick = 1 and mousex > pause_x1 and mousex < pause_x1 + pause_size and mousey > pause_y1 and mousey < pause_y1 + pause_size + 2 then
	    loop
		mousewhere (mousex, mousey, mouseclick)
		exit when mouseclick not= 1
	    end loop
	    exit
	elsif mouseclick = 1 and mousex > option2_x1 - 4 - margin3 and mousex < option2_x1 + 75 + margin3 and mousey > option2_y1 + 3 - margin3 and mousey < option2_y1 + 10 + margin3 then
	    loop
		cls
		waiting += 1
		mousewhere (mousex, mousey, mouseclick)

		draw_background
		draw_pipes2
		draw_ground2
		draw_hover (waiting)
		draw_paused_button
		draw_score

		option2_y1 := option2_y1 - 5
		draw_menu_button

		View.Update
		delay (15)

		draw_background
		draw_ground2
		option2_y1 := option2_y1 + 5

		exit_to_menu := true

		exit when mouseclick not= 1
	    end loop
	    reset
	    exit
	end if
    end loop

    option2_x1 := 279
    option2_y1 := 155

end game_pause

procedure falling

    for i : 1 .. 1
	mousewhere (mousex, mousey, mouseclick)

	if mouseclick = 0 and player_ready = true and super_bird = false then

	    time_elapsed += 0.01
	    bird_velocity -= ACCEL * time_elapsed
	    if egg_current not= 4 then
		bird_y += round (bird_velocity)
	    elsif egg_current = 4 then
		bird_y -= round (bird_velocity)
	    end if
	    bird_y2 := bird_y + bird_size * 11
	    death_checker

	    if bird_velocity < -10 then
		bird_velocity := -10
	    end if

	elsif mouseclick = 1 and mousex > pause_x1 and mousex < pause_x1 + pause_size and mousey > pause_y1 and mousey < pause_y1 + pause_size + 2 then

	    game_pause

	elsif mouseclick = 1 and super_bird = false and mousex > 0 and mousex < maxx and mousey > 0 and mousey < maxy and player_ready = true then
	    %normal jumping
	    bird_velocity := MAX_JUMP
	    time_elapsed := 0.5
	    loop
		mousewhere (mousex, mousey, mouseclick)

		cls

		time_elapsed += 0.01
		bird_velocity -= ACCEL * time_elapsed
		if egg_current not= 4 then
		    bird_y += round (bird_velocity)
		elsif egg_current = 4 then
		    bird_y -= round (bird_velocity)
		end if
		bird_y2 := bird_y + bird_size * 11
		draw_background
		draw_pipes
		draw_ground

		draw_pause_button
		if mouseclick = 1 and mousex > pause_x1 and mousex < pause_x1 + pause_size and mousey > pause_y1 and mousey < pause_y1 + pause_size + 2 then
		    game_pause
		end if
		Input.KeyDown (key)
		if key (KEY_ESC) and player_ready = true then
		    game_pause
		end if

		if exit_to_menu = true then
		    exit
		end if
		if exit_to_game = true then
		    exit
		end if

		if bird_size > 0 then
		    draw_bird3
		else
		    draw_bird
		end if

		draw_score

		View.Update
		delay (dly)

		if mouseclick not= 1 and mousex > 0 and mousex < maxx and mousey > 0 and mousey < maxy then
		    loop
			mousewhere (mousex, mousey, mouseclick)

			if mouseclick = 1 and mousex > 0 and mousex < maxx and mousey > 0 and mousey < maxy and player_ready = true then
			    bird_velocity := MAX_JUMP
			    time_elapsed := 0.5
			    loop
				mousewhere (mousex, mousey, mouseclick)

				cls

				time_elapsed += 0.01
				bird_velocity -= ACCEL * time_elapsed
				if egg_current not= 4 then
				    bird_y += round (bird_velocity)
				elsif egg_current = 4 then
				    bird_y -= round (bird_velocity)
				end if
				bird_y2 := bird_y + bird_size * 11

				draw_background
				draw_pipes
				draw_ground

				draw_pause_button
				if mouseclick = 1 and mousex > pause_x1 and mousex < pause_x1 + pause_size and mousey > pause_y1 and mousey < pause_y1 + pause_size + 2 then
				    game_pause
				end if
				Input.KeyDown (key)
				if key (KEY_ESC) and player_ready = true then
				    game_pause
				end if

				if exit_to_menu = true then
				    exit
				end if
				if exit_to_game = true then
				    exit
				end if

				if bird_size > 0 then
				    draw_bird3
				else
				    draw_bird
				end if

				draw_score

				View.Update
				delay (dly)

				if mouseclick not= 1 and mousex > 0 and mousex < maxx and mousey > 0 and mousey < maxy then
				    loop
					mousewhere (mousex, mousey, mouseclick)

					if mouseclick = 1 and mousex > 0 and mousex < maxx and mousey > 0 and mousey < maxy and player_ready = true then
					    bird_velocity := MAX_JUMP
					    time_elapsed := 0.5
					    loop
						mousewhere (mousex, mousey, mouseclick)

						cls

						time_elapsed += 0.01
						bird_velocity -= ACCEL * time_elapsed
						if egg_current not= 4 then
						    bird_y += round (bird_velocity)
						elsif egg_current = 4 then
						    bird_y -= round (bird_velocity)
						end if
						bird_y2 := bird_y + bird_size * 11

						draw_background
						draw_pipes
						draw_ground

						draw_pause_button
						if mouseclick = 1 and mousex > pause_x1 and mousex < pause_x1 + pause_size and mousey > pause_y1 and mousey < pause_y1 + pause_size + 2 then
						    game_pause
						end if
						Input.KeyDown (key)
						if key (KEY_ESC) and player_ready = true then
						    game_pause
						end if

						if exit_to_menu = true then
						    exit
						end if
						if exit_to_game = true then
						    exit
						end if

						if bird_size > 0 then
						    draw_bird3
						else
						    draw_bird
						end if

						draw_score

						View.Update
						delay (dly)

						if mouseclick not= 1 and mousex > 0 and mousex < maxx and mousey > 0 and mousey < maxy then
						    loop
							mousewhere (mousex, mousey, mouseclick)

							if mouseclick = 1 and mousex > 0 and mousex < maxx and mousey > 0 and mousey < maxy and player_ready = true then
							    bird_velocity := MAX_JUMP
							    time_elapsed := 0.5
							    loop
								mousewhere (mousex, mousey, mouseclick)

								if mouseclick not= 1 and mousex > 0 and mousex < maxx and mousey > 0 and mousey < maxy then
								    loop
									mousewhere (mousex, mousey, mouseclick)

									if mouseclick = 1 and mousex > 0 and mousex < maxx and mousey > 0 and mousey < maxy and player_ready = true then
									    bird_velocity := MAX_JUMP
									    time_elapsed := 0.5
									    loop
										mousewhere (mousex, mousey, mouseclick)

										cls

										time_elapsed += 0.01
										bird_velocity -= ACCEL * time_elapsed
										if egg_current not= 4 then
										    bird_y += round (bird_velocity)
										elsif egg_current = 4 then
										    bird_y -= round (bird_velocity)
										end if
										bird_y2 := bird_y + bird_size * 11

										draw_background
										draw_pipes
										draw_ground

										draw_pause_button
										if mouseclick = 1 and mousex > pause_x1 and mousex < pause_x1 + pause_size and mousey > pause_y1 and mousey < pause_y1
											+ pause_size + 2 then
										    game_pause
										end if
										Input.KeyDown (key)
										if key (KEY_ESC) and player_ready = true then
										    game_pause
										end if

										if exit_to_menu = true then
										    exit
										end if
										if exit_to_game = true then
										    exit
										end if

										if bird_size > 0 then
										    draw_bird3
										else
										    draw_bird
										end if

										draw_score

										View.Update
										delay (dly)

										exit when bird_velocity < 0

									    end loop

									end if

									cls

									time_elapsed += 0.01
									bird_velocity -= ACCEL * time_elapsed
									if egg_current not= 4 then
									    bird_y += round (bird_velocity)
									elsif egg_current = 4 then
									    bird_y -= round (bird_velocity)
									end if
									bird_y2 := bird_y + bird_size * 11

									draw_background
									draw_pipes
									draw_ground

									draw_pause_button
									if mouseclick = 1 and mousex > pause_x1 and mousex < pause_x1 + pause_size and mousey > pause_y1 and mousey < pause_y1 +
										pause_size + 2 then
									    game_pause
									end if
									Input.KeyDown (key)
									if key (KEY_ESC) and player_ready = true then
									    game_pause
									end if

									if exit_to_menu = true then
									    exit
									end if
									if exit_to_game = true then
									    exit
									end if

									if bird_size > 0 then
									    draw_bird3
									else
									    draw_bird
									end if

									draw_score

									View.Update
									delay (dly)

									exit when bird_velocity < 0

								    end loop
								end if

								cls

								time_elapsed += 0.01
								bird_velocity -= ACCEL * time_elapsed
								if egg_current not= 4 then
								    bird_y += round (bird_velocity)
								elsif egg_current = 4 then
								    bird_y -= round (bird_velocity)
								end if
								bird_y2 := bird_y + bird_size * 11

								draw_background
								draw_pipes
								draw_ground

								draw_pause_button
								if mouseclick = 1 and mousex > pause_x1 and mousex < pause_x1 + pause_size and mousey > pause_y1 and mousey < pause_y1 + pause_size + 2
									then
								    game_pause
								end if
								Input.KeyDown (key)
								if key (KEY_ESC) and player_ready = true then
								    game_pause
								end if

								if exit_to_menu = true then
								    exit
								end if
								if exit_to_game = true then
								    exit
								end if

								if bird_size > 0 then
								    draw_bird3
								else
								    draw_bird
								end if

								draw_score

								View.Update
								delay (dly)

								exit when bird_velocity < 0

							    end loop

							end if

							cls

							time_elapsed += 0.01
							bird_velocity -= ACCEL * time_elapsed
							if egg_current not= 4 then
							    bird_y += round (bird_velocity)
							elsif egg_current = 4 then
							    bird_y -= round (bird_velocity)
							end if
							bird_y2 := bird_y + bird_size * 11

							draw_background
							draw_pipes
							draw_ground

							draw_pause_button
							if mouseclick = 1 and mousex > pause_x1 and mousex < pause_x1 + pause_size and mousey > pause_y1 and mousey < pause_y1 + pause_size + 2 then
							    game_pause
							end if
							Input.KeyDown (key)
							if key (KEY_ESC) and player_ready = true then
							    game_pause
							end if

							if exit_to_menu = true then
							    exit
							end if
							if exit_to_game = true then
							    exit
							end if

							if bird_size > 0 then
							    draw_bird3
							else
							    draw_bird
							end if

							draw_score

							View.Update
							delay (dly)

							exit when bird_velocity < 0

						    end loop
						end if

						exit when bird_velocity < 0

					    end loop

					end if

					cls

					time_elapsed += 0.01
					bird_velocity -= ACCEL * time_elapsed
					if egg_current not= 4 then
					    bird_y += round (bird_velocity)
					elsif egg_current = 4 then
					    bird_y -= round (bird_velocity)
					end if
					bird_y2 := bird_y + bird_size * 11

					draw_background
					draw_pipes
					draw_ground

					draw_pause_button
					if mouseclick = 1 and mousex > pause_x1 and mousex < pause_x1 + pause_size and mousey > pause_y1 and mousey < pause_y1 + pause_size + 2 then
					    game_pause
					end if
					Input.KeyDown (key)
					if key (KEY_ESC) and player_ready = true then
					    game_pause
					end if

					if exit_to_menu = true then
					    exit
					end if
					if exit_to_game = true then
					    exit
					end if

					if bird_size > 0 then
					    draw_bird3
					else
					    draw_bird
					end if

					draw_score

					View.Update
					delay (dly)

					exit when bird_velocity < 0

				    end loop
				end if

				exit when bird_velocity < 0

			    end loop

			end if

			cls

			time_elapsed += 0.01
			bird_velocity -= ACCEL * time_elapsed
			if egg_current not= 4 then
			    bird_y += round (bird_velocity)
			elsif egg_current = 4 then
			    bird_y -= round (bird_velocity)
			end if
			bird_y2 := bird_y + bird_size * 11

			draw_background
			draw_pipes
			draw_ground

			draw_pause_button
			if mouseclick = 1 and mousex > pause_x1 and mousex < pause_x1 + pause_size and mousey > pause_y1 and mousey < pause_y1 + pause_size + 2 then
			    game_pause
			end if
			Input.KeyDown (key)
			if key (KEY_ESC) and player_ready = true then
			    game_pause
			end if

			if exit_to_menu = true then
			    exit
			end if
			if exit_to_game = true then
			    exit
			end if

			if bird_size > 0 then
			    draw_bird3
			else
			    draw_bird
			end if

			draw_score

			View.Update
			delay (dly)

			exit when bird_velocity < 0

		    end loop
		end if

		exit when bird_velocity < 0

	    end loop

	    exit when exit_to_menu = true or exit_to_game = true

	    bird_velocity := 0
	    time_elapsed := 0.4
	end if

	if mousex < 0 or mousex > maxx or mousey < 0 or mousey > maxy then
	    if player_ready = true and egg_current not= 7 then
		game_pause
	    end if
	end if

	if mouseclick = 1 and mousex > 0 and mousex < maxx and mousey > 0 and mousey < maxy and player_ready = false then
	    if easter_egg_toggled = false then
		randint (random_egg, 0, 100)
		if random_egg <= MAX_EGGS then
		    egg_toggle := random_egg
		    egg_current := random_egg
		else
		    egg_toggle := 0
		    egg_current := 0
		end if
		easter_egg_setter
	    end if
	    player_ready := true
	end if

	if bird_y >= 600 then
	    bird_y := 600
	    bird_y2 := bird_y + bird_size * 11
	end if
    end for

end falling

procedure game_play

    loop
	loop
	    waiting += 1
	    cls

	    draw_background

	    if super_bird = true then
		draw_bird
	    else
		draw_hover (waiting)
	    end if

	    if player_ready = true then
		draw_pipes
		if exit_to_menu = true then
		    exit
		end if
		if exit_to_game = true then
		    reset
		    exit_to_game := false
		end if
	    else

		draw_ready

	    end if

	    draw_pause_button
	    draw_ground
	    draw_score

	    if mouseclick = 1 and mousex > pause_x1 and mousex < pause_x1 + pause_size and mousey > pause_y1 and mousey < pause_y1 + pause_size + 2 then
		game_pause
	    end if

	    falling

	    if exit_to_menu = true then
		exit
	    end if
	    if exit_to_game = true then
		reset
		exit_to_game := false
	    end if

	    Input.KeyDown (key)
	    if key (KEY_ESC) then
		game_pause
	    end if

	    if super_bird = true then
		pipe_speed := -10
		mousewhere (mousex, mousey, mouseclick)
		if mousey not= mouse_hover and mousex > 0 and mousex < maxx and mousey > 0 and mousey < maxy then
		    bird_y := mousey - bird_size * 11 div 2
		end if
		mouse_hover := mousey
		if key (KEY_UP_ARROW) then
		    bird_y += bird_speed
		elsif key (KEY_DOWN_ARROW) then
		    bird_y -= bird_speed
		end if
		if bird_y <= 110 then
		    bird_y := 110
		end if
		bird_y2 := bird_y + bird_size * 11
	    end if

	    View.Update
	    delay (dly)

	end loop

	if exit_to_menu = true then
	    reset
	    exit_to_menu := false
	    exit
	end if
    end loop

end game_play

procedure draw_score_menu

    for y : 225 .. 225
	drawfillbox (40, y, 410, y + 150, 19) %black border
	drawfillbox (45, y + 9, 405, y + 145, 67) %board
	drawfillbox (45, y + 9, 405, y + 12, 43) %bottom, orange
	drawfillbox (58, y + 18, 392, y + 21, 68) %bottom, light yellow
	drawfillbox (52, y + 22, 57, y + 132, 43) %left, orange
	drawfillbox (45, y + 142, 405, y + 145, 68) %top, light yellow
	drawfillbox (52, y + 133, 392, y + 136, 43) %top, orange
	drawfillbox (393, y + 22, 396, y + 132, 68) %right, light yellow

	Font.Draw ("BEST PERFORMANCE", performancex, y + 103, font2, 68)
	Font.Draw ("BEST PERFORMANCE", performancex, y + 105, font2, 42)

	if best_performance = "EXCELLENT" then
	    if performance_flash mod 60 = 0 then
		colour_performance := 10
	    elsif performance_flash mod 30 = 0 then
		colour_performance := 47
	    end if
	elsif best_performance = "AWESOME!" then
	    if performance_flash mod 60 = 0 then
		colour_performance := 53
	    elsif performance_flash mod 30 = 0 then
		colour_performance := 11
	    end if
	elsif best_performance = "AMAZING!" then
	    if performance_flash mod 60 = 0 then
		colour_performance := 35
	    elsif performance_flash mod 30 = 0 then
		colour_performance := 36
	    end if
	end if

	Font.Draw (best_performance, performancex, y + 77, font2, 68)
	Font.Draw (best_performance, performancex, y + 79, font2, colour_performance)

	Font.Draw ("BEST SCORE", 255, y + 32, font2, 68)
	Font.Draw ("BEST SCORE", 255, y + 34, font2, 42)

	Font.Draw (intstr (best_score), 364 - (length (intstr (best_score)) - 1) * 15, y + 57, score_font, 68)
	Font.Draw (intstr (best_score), 364 - (length (intstr (best_score)) - 1) * 15, y + 59, score_font, 43)
    end for

end draw_score_menu

procedure score_menu

    option1_x1 := 198
    colour_performance := colour_best_performance

    for i : 1 .. maxint
	cls
	draw_background
	draw_ground

	performancex := 75
	performance_flash := i
	draw_score_menu
	draw_ok_button
	delay (dly)
	View.Update

	mousewhere (mousex, mousey, mouseclick)

	if mouseclick = 1 and mousex > option1_x1 - 8 - margin3 and mousex < option1_x1 + 69 + margin3 and mousey > option1_y1 + 3 - margin3 and mousey < option1_y1 + 10 + margin3 then
	    loop
		mousewhere (mousex, mousey, mouseclick)

		draw_background
		draw_ground

		option1_y1 := option1_y1 - 5
		draw_ok_button

		draw_score_menu

		delay (dly)
		View.Update

		option1_y1 := option1_y1 + 5

		exit when mouseclick not= 1
	    end loop

	    exit
	end if
    end for

    option1_x1 := 103

end score_menu

procedure main_menu

    for waiting : 0 .. maxint
	cls

	draw_background
	draw_ground
	draw_start_button
	draw_score_button
	draw_title

	draw_hover (waiting)

	mousewhere (mousex, mousey, mouseclick)

	bird_colour_toggler

	if mouseclick = 1 then
	    if mousex > option1_x1 - 7 - margin3 and mousex < option1_x1 + 70 + margin3 and mousey > option1_y1 + 3 - margin3 and mousey < option1_y1 + 10 + margin3 then
		for waiting2 : waiting .. maxint
		    mousewhere (mousex, mousey, mouseclick)

		    draw_background
		    draw_ground
		    draw_title

		    draw_hover (waiting2)

		    draw_score_button
		    option1_y1 := option1_y1 - 5
		    draw_start_button

		    View.Update

		    option1_y1 := option1_y1 + 5

		    delay (dly)

		    exit when mouseclick not= 1
		end for

		game_play

	    elsif mousex > option2_x1 - 3 - margin3 and mousex < option2_x1 + 74 + margin3 and mousey > option2_y1 + 3 - margin3 and mousey < option2_y1 + 10 + margin3 then
		for waiting2 : waiting .. maxint
		    mousewhere (mousex, mousey, mouseclick)

		    draw_background
		    draw_ground
		    draw_title

		    draw_hover (waiting2)

		    draw_start_button
		    option2_y1 := option2_y1 - 5
		    draw_score_button

		    View.Update

		    option2_y1 := option2_y1 + 5

		    delay (dly)

		    exit when mouseclick not= 1
		end for

		score_menu

	    end if
	end if

	delay (dly)
	View.Update
    end for

end main_menu

procedure credits

    colorback (7)
    cls

    for i : 1 .. 1

	Pic.Draw (credits_title, 20, 275, picCopy)

	View.Update

	delay (1500)

	for c : 16 .. 31
	    Font.Draw ("A Turing Game by", 84, 230, credit_font2, c)
	    View.Update
	    Input.KeyDown (key)
	    if key (KEY_ESC) then
		exit
	    end if
	    delay (100)
	end for

	if key (KEY_ESC) then
	    exit
	end if

	delay (1500)

	for c : 16 .. 31
	    Font.Draw ("Tiger Dong, Anthony Chen, and Charlie Zhao", 20, 195, credit_font3, c)
	    View.Update
	    Input.KeyDown (key)
	    if key (KEY_ESC) then
		exit
	    end if
	    delay (100)
	end for

	if key (KEY_ESC) then
	    exit
	end if

	delay (2500)

    end for

    main_menu

    colorback (54)

end credits

credits


