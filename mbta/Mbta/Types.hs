{-# LANGUAGE DeriveGeneric #-}
module Mbta.Types where
import Data.Text (Text)
import GHC.Generics (Generic)
import Data.Vector (Vector)
import Data.Csv
import Control.Monad (mzero)


data Agency = Agency {
    agencyId :: !Int
  , agencyName :: !Text
  , agencyUrl :: !Text
  , agencyPhone :: !Text
  } deriving (Show, Eq)

instance FromRecord Agency where
  parseRecord v
    | length v == 6 = Agency <$> v .! 0 <*> v .! 1 <*> v .! 2 <*> v .! 5
    | otherwise = mzero

data CalDate = CalDate {
    calServiceId :: !Text
  , calDate :: !Int
  , calExceptionType :: !Int
  } deriving (Generic, Show, Eq)

instance FromRecord CalDate where
  parseRecord v
    | length v == 3 = CalDate <$> v .! 0 <*> v .! 1 <*> v .! 2 
    | otherwise = mzero

data Route = Route {
    rId :: !Text
  , rAgencyId :: !Int
  , rShortName :: !Text
  , rLongName :: !Text
  , rDesc :: !Text
  , rType :: !Int
  , rUrl :: !Text
  , rColor :: !Text
  , rTextColor :: !Text
  , rSortOrder :: !Int
  } deriving (Generic, Show, Eq)

instance FromRecord Route

data Trip = Trip {
    tRouteId :: !Text
  , tServiceId :: !Text
  , tTripId :: !Text
  , tHeadsign :: !Text
  , tShortName :: !Text
  , tDirectionId :: !Int
  , tBlockId :: !Text
  , tShapeId :: !Text
  , tWheelchar :: !Int
  , tRouteType :: !Text
  } deriving (Generic, Show, Eq)

instance FromRecord Trip

data StopTime = StopTime {
    stTripId :: !Text
  , stArrivalTime :: !Text
  , stDepartureTime :: !Text
  , stStopId :: !Text
  , stStopSequence :: !Int
  , stHeadsign :: !Text
  , stPickupType :: !Int
  , stDropOffType :: !Int
  , stTimepoint :: !Int
  , stCheckpointId :: !Text
  } deriving (Generic, Show, Eq)

instance FromRecord StopTime

-- "stop_id","stop_code","stop_name","stop_desc","platform_code","platform_name","stop_lat","stop_lon","stop_address","zone_id","stop_url","level_id","location_type","parent_station","wheelchair_boarding"

data Stop = Stop {
    sStopId :: !Text
  , sStopCode :: !Text
  , sStopName :: !Text
  , sStopDesc :: !Text
  , sPlatformCode :: !Text
  , sPlatformName :: !Text
  , sStopLat :: !Double
  , sStopLong :: !Double
  , sStopAddress :: !Text
  , sZoneId :: !Text
  , sStopUrl :: !Text
  , sLevelId :: !Text
  , sLocationType :: !Int
  , sParentStation :: !Text
  , sWheelcharBoarding :: !Int
  } deriving (Generic, Show, Eq)

instance FromRecord Stop



