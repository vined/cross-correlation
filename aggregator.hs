import System.IO (readFile)
import System.Environment (getArgs)
import Data.List (head)
import Data.Text (findIndex, isInfixOf, pack)


aggregateKeys :: String -> [(String, Int)] -> [(String, Int)]
aggregateKeys key acc =
    if (length acc) > 0 && key == (fst $ last acc)
        then (init acc) ++ [(key, (snd $ last acc) + 1)]
        else acc ++ [(key, 1)]


aggregate :: [(String, String)] -> [(String, Int)]
aggregate values =
    foldl (\acc (key, _) -> aggregateKeys key acc) [] values


parseLine :: String -> (String, String)
parseLine line =
    let values = break (== ',') line
    in (fst values, snd values)


main :: IO()
main = do
    (dataFile:term:_) <- getArgs
    content <- readFile dataFile

    let values = map parseLine $ tail $ lines content
        filtered = filter (\(id, text) -> isInfixOf (pack term) (pack text)) values

    putStrLn $ "Found occurencies: " ++ (show $ length filtered)

    let aggregated = aggregate filtered

    putStrLn $ "Aggregated size: " ++ (show $ length aggregated)
    writeFile "occurencies.dat" (unlines $ map (\(id, text) -> id ++ "\t" ++ (show text)) aggregated)
