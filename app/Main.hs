module Main where
import Graphics.Gloss

deg2rad :: Float -> Float
deg2rad a = a * pi / 180

get_end :: Point -> Float -> Float -> Point
get_end (start_x, start_y) len angle = (start_x+(sin (deg2rad angle))*len, start_y+(cos (deg2rad angle))*len) 



-- start (x, y), length, angle, thickness
draw_branches :: Point -> Float -> Float -> Float -> Picture
draw_branches (x, y) len angle thickness
  | len > 1 =
      pictures
        [ drawRect (x, y) len angle thickness
        , draw_branches (get_end (x, y) len angle) (0.7*len) (angle+20) (0.7*thickness)
        , draw_branches (get_end (x, y) len angle) (0.7*len) (angle-20) (0.7*thickness)        
        ]
  | otherwise = Blank
  where

     
    drawRect :: Point -> Float -> Float -> Float -> Picture
    drawRect (x1,y1) len angle thickness =
      translate x1 y1
      (rotate angle
       (translate 0 (len/2)
         (rectangleSolid thickness len)))

main :: IO ()
main =
  display
    (InWindow "Fractal trees" (900,600) (10,10))
    (makeColorI 245 245 245 255)
    (draw_branches (0, (-200)) 200 0 20)
