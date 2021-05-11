#!/bin/sh

rm -rf ./build
mkdir build

scan_in="./Lexer/Lexer.x"
scan_out="./Lexer/Lexer.hs"
alex $scan_in -o $scan_out

parser_in="./Parser/Parser.y"
parser_out="./Parser/Parser.hs"
happy $parser_in -o $parser_out

ghc Main.hs -o ./build/main -outputdir=build