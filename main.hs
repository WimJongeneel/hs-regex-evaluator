module Main where

import Lexer.Lexer
import Parser.Parser
import Parser.AST
import Eval

main :: IO ()
main = do
    let tokens = alexScanTokens "a*ba*aa"
    print tokens
    let ast = parse tokens
    print ast
    print $ runEval ast "aaabaab"