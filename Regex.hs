module Regex where

import Control.Monad.State
import Data.Set (Set, toList, singleton, union, fromList)

import Lexer.Lexer
import Parser.Parser
import Parser.AST

eval :: Regex -> State (Set String) Bool

eval (RChar c) = do
    remainers <- get
    let res = fmap (\r -> if c == take 1 r then ([ drop 1 r ] , True) else ([ ], False)) $ toList remainers
    put $ fromList $ res >>= fst
    return $ any snd res

eval (RConcat l r) = do
    pass <- eval l
    pass' <- eval r
    return $ pass && pass'

eval (ROr l r) = do
    remainers <- get
    let (lp, lr) = let state = eval l in runState state remainers
    let (rp, rr) = let state = eval r in runState state remainers
    put $ case (lp, rp) of
        (True, False)   -> lr
        (False, True)   -> rr
        _               -> lr `union` rr
    return $ lp || rp

eval (RStar r) = do
    remainers <- get
    let consume = \(rem, res) -> let state = eval r; (pass, rem') = runState state rem
                                 in if rem /= rem' 
                                    then consume (rem', rem' `union` res) 
                                    else res
    put $ consume (remainers, remainers)
    return True

eval (RPlus r) = do
    pass <- eval r
    remainers <- get
    let consume = \(rem, res) -> let state = eval r; (pass, rem') = runState state rem
                                 in if rem /= rem' 
                                    then consume (rem', rem' `union` res) 
                                    else res
    put $ consume (remainers, remainers)
    return pass

eval (ROptional r) = do 
    remainers <- get
    pass <- eval r
    remainers' <- get
    put $ if pass then remainers `union` remainers' else remainers
    return True

eval (RNested n) = eval n

runEval :: String -> String -> (Bool, [String])
runEval r s = let tokens = alexScanTokens r;
                  ast = parse tokens
                  res = runState (eval ast) $ singleton s
              in (fst res, toList $ snd res)

test :: String -> String -> Bool
test r s = fst $ runEval r s