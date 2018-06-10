module Mbta.Core where
import Data.Csv
import Data.Vector
import Mbta.Types
import Data.ByteString.Lazy.Char8 as BL



-- maybe should use conduit

decodeFile :: FromRecord a => BL.ByteString -> Either String (Vector a)
decodeFile bs = 
    decode HasHeader bs



