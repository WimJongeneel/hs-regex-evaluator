# Haskell Regex Evaluator

## Supported features:

* matching of exact chars
* an or-operator with `|`
* the `*` operator on every nested regex
* the `+` operator on every nested regex
* nested regexes with `( )` to apply the operators to complex regexes

## Implementation details

Lexing and parsing happens with Alex and Happy.

The eval function uses a `State` monand with a `Set` of remainders as the state and a `Bool` as the value. (This migth change for the implementation of capture groups).