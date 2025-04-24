module MatrixMult (matrixMult, randomMatrix) where

import Data.Array.IO as R
import System.Random (randomRIO)

type Matrix = Array U DIM2 Double

randomMatrix :: Int -> IO Matrix
randomMatrix n = do
  elems <- mapM (const $ randomRIO (0.0, 1.0)) [1..n*n]
  let arr = fromListUnboxed (Z :. n :. n) elems
  return arr

matrixMult :: Matrix -> Matrix -> Matrix
matrixMult a b =
  let Z :. n :. _ = extent a
      bT = transpose b
      c = fromFunction (Z :. n :. n) (\(Z :. i :. j) -> 
            R.sumAllS (R.zipWith (*) (slice a (Z :. i :. All)) (slice bT (Z :. j :. All))))
  in computeS c

transpose :: Source r Double => Array r DIM2 Double -> Array D DIM2 Double
transpose arr =
  let Z :. rows :. cols = extent arr
  in fromFunction (Z :. cols :. rows) $ \(Z :. i :. j) -> arr ! (Z :. j :. i)
