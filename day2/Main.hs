import qualified Data.Text as T
import Debug.Trace
import Control.Monad
import qualified Data.Sequence as Sequence
import qualified Data.Foldable as Foldable

-- the first two numbers after the Opcode tells you which position, the third iindicates the output position
-- Opcode 1 means add
-- Opcode 2 means multiply
-- Opcode 99 means end
-- any other Opcode means an error occurred

main :: IO ()
main = do
        let output = 19690720
        input <- (readInputFile "input.txt")
        Foldable.forM_ [1..100] $ \first -> do
                Foldable.forM_ [1..100] $ \second -> do        
                        let computedIntcode = intcodeComputation 0 (updateList 1 first (updateList 2 second input))
                        when ((computedIntcode!!0) == output) $ putStr ("answer: " ++ show (100 * first + second))
        print "done"


updateList :: Int -> Int -> [Int] -> [Int]
updateList index value list = (Foldable.toList (Sequence.update index value (Sequence.fromList list)))


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