import System.IO (readFile)
import System.Environment (getArgs)
import Data.List (find)


merge :: [(String, String)] -> [(String, String)] -> String -> String -> [(String, (String, String))]
merge values1 values2 defaultValue1 defaultValue2 =
    if length values1 == 0 && length values2 == 0
        then []
        else if length values1 == 0
            then
                let (key2, val2) = head values2
                in [(key2, (defaultValue1, val2))] ++ merge [] (tail values2) defaultValue1 defaultValue2
            else if length values2 == 0
                then
                    let (key1, val1) = head values1
                    in [(key1, (val1, defaultValue2))] ++ merge (tail values1) [] defaultValue1 defaultValue2
                else
                    let (key1, val1) = head values1
                        (key2, val2) = head values2
                    in if key1 < key2
                        then [(key1, (val1, defaultValue2))] ++ merge (tail values1) values2 defaultValue1 defaultValue2
                        else if key1 > key2
                            then [(key2, (defaultValue1, val2))] ++ merge values1 (tail values2) defaultValue1 defaultValue2
                            else [(key1, (val1, val2))] ++ merge (tail values1) (tail values2) defaultValue1 defaultValue2


getValueByKey :: String -> String -> [(String, String)] -> String
getValueByKey key defaultValue entries =
    case find (\(k, _) -> k == key) entries of
        Just v -> snd v
        Nothing -> defaultValue


mergeFirstWithSecond :: [(String, String)] -> [(String, String)] -> String -> String -> [(String, (String, String))]
mergeFirstWithSecond values1 values2 defaultValue1 defaultValue2 =
    map (\(key, val1) -> (key, (val1, getValueByKey key defaultValue2 values2))) values1


parseLine :: String -> (String, String)
parseLine line =
    let values = break (== ',') line
    in (fst values, tail $ snd values)


toString :: (String, (String, String)) -> String
toString (id, (value1, value2)) = id ++ "," ++ value1  ++ ","++ value2


main :: IO()
main = do
    (file1:file2:defaultValue1:defaultValue2:_) <- getArgs
    content1 <- readFile file1
    content2 <- readFile file2


    let values1 = map parseLine $ lines content1
        values2 = map parseLine $ lines content2

    putStrLn $ "First file size: " ++ (show $ length values1)
    putStrLn $ "Second file size: " ++ (show $ length values2)

    let merged = mergeFirstWithSecond values1 values2 defaultValue1 defaultValue2

    putStrLn $ "Result size: " ++ (show $ length merged)

    writeFile "merged.dat" (unlines $ map (\val -> toString val) merged)
