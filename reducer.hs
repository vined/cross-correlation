import System.IO (readFile)
import System.Environment (getArgs)
import Data.List (head, findIndex)


getEntryIdx :: String -> [(String, Int)] -> Maybe Int
getEntryIdx key entries = findIndex (\(k, _) -> k == key) entries


addValues :: String -> Int -> [(String, Int)] -> [(String, Int)]
addValues key val acc =
    let entryIdx = getEntryIdx key acc
    in case entryIdx of
        Just idx -> (take idx acc) ++ [(key, (snd $ (acc !! idx)) + val)] ++ (drop (idx+1) acc)
        Nothing -> acc ++ [(key, val)]


reduce :: [(String, Int)] -> [(String, Int)]
reduce values =
    foldl (\acc (key, val) -> addValues key val acc) [] values


parseLine :: String -> (String, Int)
parseLine line =
    let values = break (== ',') line
    in (fst values, read (tail $ snd values) :: Int)


toString :: (String, Int) -> String
toString (id, val) = id ++ "\t" ++ (show val)


main :: IO()
main = do
    (dataFile:_) <- getArgs
    content <- readFile dataFile

    let values = map parseLine $ tail $ lines content
    putStrLn $ "Size: " ++ (show $ length values)

    let reduced = reduce values
    putStrLn $ "Reduced size: " ++ (show $ length reduced)

    writeFile "reduced.dat" (unlines $ map (\(id, val) -> id ++ "\t" ++ (show val)) reduced)
