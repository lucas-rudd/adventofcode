import qualified Data.Text as T
import Debug.Trace
import qualified Data.Sequence as Sequence
import qualified Data.Foldable as Foldable

-- the first two numbers after the Opcode tells you which position, the third iindicates the output position
-- Opcode 1 means add
-- Opcode 2 means multiply
-- Opcode 99 means end
-- any other Opcode means an error occurred

main :: IO ()
main = do  
        output <- (readInputFile "input.txt")
        let computedIntcode = intcodeComputation 0 output
        print (computedIntcode!!0)

intcodeComputation :: Int -> [Int] -> [Int]
intcodeComputation start input = do
        case input!!(start) of
                1  -> intcodeComputation (start+4) (Foldable.toList (Sequence.update (input!!(start+3)) ((input!!(input!!(start+1))) + (input!!(input!!(start+2)))) (Sequence.fromList input)))
                2  -> intcodeComputation (start+4) (Foldable.toList (Sequence.update (input!!(start+3)) ((input!!(input!!(start+1))) * (input!!(input!!(start+2)))) (Sequence.fromList input)))
                99 -> input
                _  -> error "An error occurred"

        

readInputFile :: FilePath -> IO [Int]
readInputFile fileName = do
        contents <- readFile fileName
        let singlewords = Prelude.map T.unpack (T.splitOn (T.pack ",") (T.pack contents))
        return (Prelude.map read singlewords)