module Main where
import Test.HUnit
import Mbta.Types
import Data.Csv
import Data.Vector

main :: IO Counts
main = runTestTT . test $ [

    "decode Agency" ~:
      let v :: Either String (Vector Agency)
          v = decode NoHeader 
                  -- agency id comes as quoted number, but this works
                  "\"3\",\"Cape Cod Regional Transit Authority\",\"http://www.capecodrta.org/\",\"America/New_York\",\"EN\",\"800-352-7155\""
      in v @?= Right (fromList [Agency 3 "Cape Cod Regional Transit Authority" "http://www.capecodrta.org/" "800-352-7155"])

  , "decode CalDate" ~:
      let v :: Either String (Vector CalDate)
          v = decode NoHeader 
                  "\"CR-Weekday-NorthSide-Spring-18-RegReduced\",20180704,2"
      in v @?= Right (fromList [CalDate "CR-Weekday-NorthSide-Spring-18-RegReduced" 20180704 2])

  , "decode Trip" ~:
      let v :: Either String (Vector Trip)
          v = decode NoHeader 
                  "\"1\",\"BUS22018-hbc28017-Sunday-02\",\"36640921\",\"Dudley\",\"\",1,\"C01-13\",\"010058\",1,\"\""
      in v @?= Right (fromList [Trip
                  "1" "BUS22018-hbc28017-Sunday-02" "36640921" "Dudley" "" 1 "C01-13" "010058" 1 ""
                  ])

  , "decode Route" ~:
      let v :: Either String (Vector Route)
          v = decode NoHeader 
                  "\"1\",\"1\",\"1\",\"\",\"Key Bus Route (Frequent Service)\",3,\"\",\"FFC72C\",\"000000\",100"
      in v @?= Right (fromList [Route
                  "1" 1 "1" "" "Key Bus Route (Frequent Service)" 3 "" "FFC72C" "000000" 100
                  ])

  , "decode StopTime" ~:
      let v :: Either String (Vector StopTime)
          v = decode NoHeader
                "\"CR-Sunday-PTC-18-2502\",\"10:32:00\",\"10:32:00\",\"West Newton\",13,\"\",3,3,1,\"\""
      in v @?= Right (fromList 
                [StopTime "CR-Sunday-PTC-18-2502" "10:32:00" "10:32:00" "West Newton" 13 "" 3 3 1 ""])

  , "decode Stop" ~:
      let v :: Either String (Vector Stop)
          v = decode NoHeader ("\"71\",\"71\",\"Massachusetts Ave @ Pleasant St\",\"\",\"\",\"\",42.366717,-71.106102,\"\",\"\",\"\",\"\",0,\"\",0")
      in v @?= Right (fromList [Stop "71" "71" "Massachusetts Ave @ Pleasant St" "" "" "" 42.366717 (-71.106102) "" "" "" "" 0 "" 0 ])

  ]


