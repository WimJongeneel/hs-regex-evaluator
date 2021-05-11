module Lexer.Tokens where

data Token = TChar String
  | TStar
  | TPlus
  | TPipe
  | TLeftParenthesis
  | TRigthParenthesis
  | TOptional
  deriving (Eq, Show)