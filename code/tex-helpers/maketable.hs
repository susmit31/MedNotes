module Main where

import System.Process

splitstr :: String -> String -> [String]
splitstr st sep =
  | length st == 0 = [st]
  | otherwise = splitloop st sep "" [] where
    splitloop st sep word arr =
      case st of
        "" -> append word arr
        (first : rest) -> if first == sep
                          then splitloop rest sep "" (append word arr)
                          else splitloop rest sep (append first word) arr
    append li el =
      case li of
        [] -> [el]
        (x : xs) -> x : (append xs el)

main :: IO ()
main = do
  putStr "Name of the source file? "
  fname <- getLine
  fcontents <- readFile fname
  
