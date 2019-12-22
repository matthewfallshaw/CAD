module Main where

-- import Lib
import Graphics.Implicit
-- import Graphics.Implicit.Definitions
-- import Graphics.Implicit.Primitives

out:: SymbolicObj3
out = union [
              rect3R 0 (0,0,0) (20,20,20),
              translate (20,20,20) (sphere 15) ]

main :: IO ()
main = writeSTL 0.3 "example.stl" out
