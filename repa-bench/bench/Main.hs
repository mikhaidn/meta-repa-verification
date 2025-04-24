import Criterion.Main
import MatrixMult

main :: IO ()
main = do
  let n = 500  -- Set matrix size here
  a <- randomMatrix n
  b <- randomMatrix n
  defaultMain [
    bench "matrix multiplication" $ nf (matrixMult a) b
    ]
