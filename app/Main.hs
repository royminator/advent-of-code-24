module Main (main) where

import Day5

main :: IO ()
main = readFile "res/day5input.txt" >>= print . day5 . stringToInput
