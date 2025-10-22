{-# OPTIONS_GHC -Wno-incomplete-uni-patterns #-}

module Day5
  ( day5,
    splitRulesAndPages,
    Day5Input (..),
    Day5Result (..),
    Rule (..),
    stringToInput,
    violatesRule,
    pagesViolatesRule,
    pagesViolatesRules,
  )
where

data Rule = Rule Int Int
  deriving (Show, Eq)

data Day5Input = Day5Input [Rule] [[Int]]
  deriving (Show, Eq)

newtype Day5Result = Day5Result Int
  deriving (Show, Eq)

day5 :: Day5Input -> Day5Result
day5 input = Day5Result $ sum $ map getMiddleElement $ pagesInOrder input
  where
    getMiddleElement xs = xs !! div (length xs) 2

pagesInOrder :: Day5Input -> [[Int]]
pagesInOrder (Day5Input rules pages) =
  filter (not . pagesViolatesRules rules) pages

pagesViolatesRules :: [Rule] -> [Int] -> Bool
pagesViolatesRules [] _ = False
pagesViolatesRules (r : rs) ps =
  pagesViolatesRule [] ps r || pagesViolatesRules rs ps

pagesViolatesRule :: [Int] -> [Int] -> Rule -> Bool
pagesViolatesRule _ [] _ = False
pagesViolatesRule prev (p : ps) rule =
  violatesRule prev p rule || pagesViolatesRule (prev ++ [p]) ps rule

violatesRule :: [Int] -> Int -> Rule -> Bool
violatesRule prev curr (Rule first second) =
  elem second prev && (curr == first)

stringToInput :: String -> Day5Input
stringToInput str =
  let (ruleStrs, pageStrs) = splitRulesAndPages str
   in Day5Input (map parseRule ruleStrs) (map parsePage pageStrs)

splitRulesAndPages :: String -> ([String], [String])
splitRulesAndPages str =
  let (firstPart, rest) = break null $ lines str
   in (firstPart, dropWhile null rest)

parseRule :: String -> Rule
parseRule xs =
  let (first, _ : second) = break (== '|') xs
   in Rule (read first) (read second)

parsePage :: String -> [Int]
parsePage = map read . split ','

split :: (Eq a) => a -> [a] -> [[a]]
split _ [] = []
split sep xs =
  let (num, rest) = break (== sep) xs
   in num : split sep (drop 1 rest)
