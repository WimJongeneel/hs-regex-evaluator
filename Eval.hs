module Eval where

import Control.Monad.State
import Data.Set (Set, toList, singleton, union, fromList)

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
        (True, True)    -> lr `union` rr
        (False, False)  -> lr `union` rr
        (True, False)   -> lr
        (False, True)   -> rr
    return $ lp || rp

eval (RStar r) = do
    remainers <- get
    let consume = \(rem, res) -> let state = eval r; (pass, rem') = runState state rem
                                 in if pass then consume (rem', rem' `union` res) else res
    put $ consume (remainers, remainers)
    return True

eval (RPlus r) = do
    pass <- eval r
    remainers <- get
    let consume = \(rem, res) -> let state = eval r; (pass, rem') = runState state rem
                                 in if pass then consume (rem', rem' `union` res) else res
    put $ consume (remainers, remainers)
    return pass

eval (RNested n) = eval n

runEval :: Regex -> String -> (Bool, [String])
runEval r s = let state = eval r; (pass, remainers) = runState state $ singleton s in (pass, toList remainers)

test :: Regex -> String -> Bool
test r s = let (p, _) = runEval r s in p