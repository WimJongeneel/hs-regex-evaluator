module Main where

import Regex

main :: IO ()
main = do
    print $ test "foo" "foo"
    print $ test "(bar)+" "barbar"
    print $ test "bar+" "barrrr"
    print $ test "foo|(bar)+" "fobarbar"
    print $ test "(foo)*bar(baz)+" "barbazbaz"