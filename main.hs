module Main where

import Regex
import Lexer.Lexer
import Parser.Parser
import Parser.AST

main :: IO ()
main = do
    print $ test "(a?)+bcd?q" "abcdq"
    print $ test "(bar)+" "barbar"
    print $ test "bar+" "barrrr"
    print $ test "foo|(ba?r)+" "fobarbr"
    print $ test "(foo)*bar(baz)+" "barbazbaz"
    print $ test "a?+" "aaa"
    print $ test "a|b|c|d" "aaa"