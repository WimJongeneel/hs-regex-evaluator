module Parser.AST where

data Regex = RChar String
  | RNested Regex
  | RStar Regex
  | RPlus Regex
  | ROr Regex Regex
  | RConcat Regex Regex
  | ROptional Regex
  deriving (Eq, Show)