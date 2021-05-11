{
module Lexer.Lexer
  (alexScanTokens)
where

import Lexer.Tokens
}

%wrapper "basic"

$alpha = [a-zA-Z]

tokens :-
  $white+                             ;
  "("                                 { (\_ -> TLeftParenthesis) }
  ")"                                 { (\_ -> TRigthParenthesis) }
  "+"                                 { (\_ -> TPlus) }
  "*"                                 { (\_ -> TStar) }
  "|"                                 { (\_ -> TPipe) }
  $alpha                              { (\s -> TChar $ s) }