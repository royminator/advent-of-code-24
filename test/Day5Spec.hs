module Day5Spec
  ( day5Spec,
  )
where

import Day5
import Test.Hspec

day5Spec :: Spec
day5Spec = do
  describe "day5 with example input" $ do
    it "should give correct result" $ do
      True `shouldBe` True
  describe "splitRulesAndPages" $ do
    it "should parse input" $ do
      splitRulesAndPages exampleInputString `shouldBe` (rulesString, pagesString)
  describe "stringToInput" $ do
    it "should return input" $ do
      stringToInput exampleInputStringShort `shouldBe` exampleInputShort
  describe "pagesViolatesRules" $ do
    it "should return false" $ do
      case exampleInputShort of
        Day5Input rules (p : _) ->
          pagesViolatesRules rules p `shouldBe` False
        Day5Input _ [] ->
          error "No pages in input"
  describe "violatesRule" $ do
    it "should be false" $ do
      violatesRule [42, 2] 5 (Rule 99 5) `shouldBe` False
    it "should be false" $ do
      violatesRule [42, 2] 5 (Rule 42 5) `shouldBe` False
    it "should be true" $ do
      violatesRule [2, 5] 42 (Rule 42 5) `shouldBe` True
  describe "pagesViolatesRule" $ do
    it "should be true" $ do
      pagesViolatesRule [] [42, 5, 8] (Rule 5 42) `shouldBe` True
    it "should be false" $ do
      pagesViolatesRule [] [42, 5, 8] (Rule 5 8) `shouldBe` False
  describe "day5 with example input" $ do
    it "should give 143" $ do
      day5 (stringToInput exampleInputString) `shouldBe` Day5Result 143

exampleInputShort :: Day5Input
exampleInputShort =
  Day5Input
    [ Rule 47 53,
      Rule 97 13,
      Rule 97 61
    ]
    [[75, 47, 61, 53, 29], [97, 61, 53, 29, 13]]

exampleInputStringShort :: String
exampleInputStringShort =
  "47|53\n\
  \97|13\n\
  \97|61\n\
  \\n\
  \75,47,61,53,29\n\
  \97,61,53,29,13"

exampleInputString :: String
exampleInputString =
  "47|53\n\
  \97|13\n\
  \97|61\n\
  \97|47\n\
  \75|29\n\
  \61|13\n\
  \75|53\n\
  \29|13\n\
  \97|29\n\
  \53|29\n\
  \61|53\n\
  \97|53\n\
  \61|29\n\
  \47|13\n\
  \75|47\n\
  \97|75\n\
  \47|61\n\
  \75|61\n\
  \47|29\n\
  \75|13\n\
  \53|13\n\
  \\n\
  \75,47,61,53,29\n\
  \97,61,53,29,13\n\
  \75,29,13\n\
  \75,97,47,61,53\n\
  \61,13,29\n\
  \97,13,75,29,47"

rulesString :: [String]
rulesString =
  lines
    "47|53\n\
    \97|13\n\
    \97|61\n\
    \97|47\n\
    \75|29\n\
    \61|13\n\
    \75|53\n\
    \29|13\n\
    \97|29\n\
    \53|29\n\
    \61|53\n\
    \97|53\n\
    \61|29\n\
    \47|13\n\
    \75|47\n\
    \97|75\n\
    \47|61\n\
    \75|61\n\
    \47|29\n\
    \75|13\n\
    \53|13"

pagesString :: [String]
pagesString =
  lines
    "75,47,61,53,29\n\
    \97,61,53,29,13\n\
    \75,29,13\n\
    \75,97,47,61,53\n\
    \61,13,29\n\
    \97,13,75,29,47"
