import System.IO (readFile)
import System.Environment (getArgs)
import Data.List (head)


mean :: [Double] -> Double
mean values = (sum values) / (fromIntegral $ length values)


crossCorrelationFn :: [Double] -> [Double] -> Int -> Double
crossCorrelationFn f g d =
    let
        n = (length f) - d

        fd = take n f
        meanF = mean fd
        devF = map (subtract meanF) fd
        squaredDevF = map (^2) devF

        gd = drop d g
        meanG = mean gd
        devG = map (subtract meanG) gd
        squaredDevG = map (^2) devG

        cov = sum $ zipWith (*) devF devG
    in
        cov / (sqrt ((sum squaredDevF) * (sum squaredDevG)))


applyCrossCorrelation :: [Double] -> [Double] -> Int -> (Int, Double)
applyCrossCorrelation f g d =
    let
        correlation = if d >= 0
            then crossCorrelationFn f g d
            else crossCorrelationFn g f (-d)
    in
        (d, abs correlation)


getCrossCorrelationForArrays :: [Double] -> [Double] -> [(Int, Double)]
getCrossCorrelationForArrays f g =
    let
        n = floor $ 0.5 * (fromIntegral $ length f)
        cc1 = map (\d -> applyCrossCorrelation f g d) [1..n]
        cc2 = map (\d -> applyCrossCorrelation f g d) [-n..0]
    in
        cc2 ++ cc1


-- Reading / writing

splitOn :: Char -> String -> [String]
splitOn delim str =
    if length str < 1
        then []
        else (\(a, b) -> if length b < 1 then [str] else [a] ++ (splitOn delim (tail b))) (break (== delim) str)


parseLine :: String -> (Double, Double)
parseLine line =
    let values = map read (tail $ splitOn '\t' line) :: [Double]
    in (values !! 0, values !! 1)


isComment :: [Char] -> Bool
isComment line = '#' == head line


filterComments :: [String] -> [String]
filterComments strs = filter (not . isComment) strs


toTabSeparatedString :: (Int, Double) -> String
toTabSeparatedString (f, g) = (show f) ++ "\t" ++ (show g)


-- Main

main :: IO()
main = do
    (dataFile:_) <- getArgs
    content <- readFile dataFile

    let signals = unzip $ map parseLine $ filterComments $ lines content
    putStrLn $ "Signals size: " ++ (show $ length $ fst signals)

    let result = getCrossCorrelationForArrays (fst signals) (snd signals)
    writeFile "result.dat" (unlines $ map toTabSeparatedString result)
