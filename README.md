# Haskell Regex Evaluator

```hs
module Main where

import Regex

main :: IO ()
main = do
    print $ test "test" "test"
    print $ test "(test)+" "testtesttestqq"
    print $ test "a*b+q|ws" "aaabws"
    print $ test "a*b+q|ws" "bws"
```

## Supported features:

* matching of single chars
* concatenated regexes by appending them together 
* the `|` between any two regexes
* the `*` operator on any nested regex
* the `+` operator on any nested regex
* nested regexes with `( )` to apply the operators to complex regexes

## Implementation details

Lexing and parsing happens with Alex and Happy.

The eval function uses a `State` monand with a `Set` of remainders as the state and a `Bool` as the value. (This migth change for the implementation of capture groups).