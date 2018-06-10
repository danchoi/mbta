module Main where
import Data.Text (Text)
import Mbta.Types
import Mbta.Core
import Options.Applicative
import Data.Monoid
import qualified Data.ByteString.Lazy.Char8 as BL
import Data.Vector (Vector, toList)
import Data.Csv (decode, HasHeader(..))
import Data.Traversable

data Options = 
      ParseRoutes
    | ParseTrips
    | ParseStops
    | ParseStopTimes
  
options :: Parser Options
options = subparser (
      command "routes" 
          (info (helper <*> pure ParseRoutes)
                    (progDesc "parse routes.csv stream"))
   <> command "trips" 
          (info (helper <*> pure ParseTrips)
                    (progDesc "parse trips.csv stream"))
   <> command "stops" 
          (info (helper <*> pure ParseStops)
                    (progDesc "parse stops.csv stream"))
   <> command "stop-times" 
          (info (helper <*> pure ParseStopTimes)
                    (progDesc "parse stop_times.csv stream"))
                   
                )

opts :: ParserInfo Options
opts = info (helper <*> options) (header "mbta" )

main :: IO ()
main = do
  o <- execParser opts
  bs <- BL.getContents
  case o of
    ParseRoutes -> do
        let vs :: Either String (Vector Route)
            vs = decode HasHeader bs
        either error (mapM_ (putStrLn . show)) vs

    ParseTrips -> do
        let vs :: Either String (Vector Trip)
            vs = decode HasHeader bs
        either error (mapM_ (putStrLn . show)) vs

    ParseStops -> do
        let vs :: Either String (Vector Stop)
            vs = decode HasHeader bs
        either error (mapM_ (putStrLn . show)) vs

    ParseStopTimes -> do
        let vs :: Either String (Vector StopTime)
            vs = decode HasHeader bs
        either error (mapM_ (putStrLn . show)) vs
