{
module Parser.Parser(parse) where

import Lexer.Tokens
import Parser.AST
import qualified Lexer.Lexer as L
}

%name parse
%tokentype { Token }

%token
lp        { TLeftParenthesis }
rp        { TRigthParenthesis }
plus      { TPlus }
star      { TStar } 
pipe      { TPipe }
char      { TChar $$ }
optional  { TOptional }

%right pipe
%right star pipe optional

%%

Regex : Regex Regex                                                     { RConcat $1 $2 }
    | Other { $1 }

Other: char                                                             { RChar $1 }
    | lp Regex rp                                                       { RNested $2 }
    | Regex star                                                        { RStar $1 }
    | Regex plus                                                        { RPlus $1 }
    | Regex optional                                                    { ROptional $1 }
    | Other pipe Regex                                                  { $1 `ROr` $3 }
{
happyError :: [Token] -> a
happyError i = error $ show i
}