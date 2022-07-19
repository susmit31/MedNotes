module Main where

import System.Process

split :: String -> String -> [String]
split st sep
  | length st == 0 = [st]
  | otherwise = splitloop st sep "" [] where
    splitloop st sep word arr
      |  length st == 0 = append arr word
      |  (take (length sep) st) == sep = splitloop (rest (length sep) st) sep "" (append arr word)
      |  otherwise = splitloop (rest (length sep) st) sep (word++(take (length sep) st)) arr
    rest = (\num -> \li -> if num == 0; then li; else let (x:xs) = li in (rest (num-1) xs))
    append li el =
      case li of
        [] -> [el]
        (x : xs) -> x : (append xs el)

join :: [String] -> String -> String
join strlist sep =
  case strlist of
    [last] -> last
    (first : rest) -> first ++ sep ++ (join rest sep)

replace :: String -> String -> String -> String
replace srcstr old new = join (split srcstr old) new


main :: IO ()
main = do
  putStr "Name of the source file? "
  fname <- getLine
  fcontents <- readFile fname
  let splitcontents = split fcontents "\n"
  let splitfirstline = map (\text -> "\\cellcolor{violet!60}\\color{white}"++text) (split (splitcontents!!0) "|")
  let firstline = join splitfirstline " &\n"
  let restlines = join (map (\text -> replace text "|" " & ") (tail splitcontents)) " \\\\\n"
  let textable = firstline++restlines
  putStrLn textable
  callCommand ("echo \"" ++ textable ++ "\" | xclip -sel clip")
  putStrLn "Copied!"
