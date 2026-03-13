module Main where
import Graphics.Gloss

-- start (x, y), length, angle, thickness
draw_branches :: Point -> Float -> Float -> Float -> Picture
draw_branches point len angle thickness
  | len > 1 =
      pictures
        [ drawRect point len angle thickness
--        , draw_branches (x2, y2) (x2-3, y2-5)
        ]
  | otherwise = Blank
  where

    get_distance :: Point -> Point -> Float
    get_distance (x1,y1) (x2,y2) =
      sqrt ((x2-x1)^2 + (y2-y1)^2)

    get_end :: Point -> Float -> Float -> Point
    get_end (x, y) len angle = (x+(sin angle)*len,y+(cos angle)) 
     
    drawRect :: Point -> Float -> Float -> Float -> Picture
    drawRect (x1,y1) len angle thickness =
      rotate angle (translate x1 y1 (rectangleSolid thickness len))

main :: IO ()
main =
  display
    (InWindow "Nice Window" (600,400) (10,10))
    (makeColorI 245 245 245 255)
    (draw_branches (0, (-200)) 60 0 20)
