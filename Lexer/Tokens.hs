module Lexer.Tokens where

data Token = TChar String
  | TStar
  | TPlus
  | TPipe
  | TLeftParenthesis
  | TRigthParenthesis
  deriving (Eq, Show)