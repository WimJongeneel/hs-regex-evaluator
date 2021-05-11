module Main where

import Regex

main :: IO ()
main = do
    print $ test "test" "test"
    print $ test "(test)+" "testtesttestqq"
    print $ test "a*b+q|ws" "bws"
    print $ test "a*b+q|ws" "bws"