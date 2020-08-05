module ISX.Plugin.CrawlerHTML.Resource.Common (
    Apex(..),
    Data(..)
    ) where


import              Data.Aeson
import              Data.Time.Clock                         (UTCTime)
import              TPX.Com.API.Resource.ISX.Pick


data Apex = Apex {
    apexTNow    :: UTCTime,
    apexVersion :: Text
    } deriving (Show)
instance ToJSON Apex where
    toJSON o = object [
        "t_now"   .= apexTNow o,
        "version" .= apexVersion o]

data Data = Data {
    dataHeader     :: RockHeader,
    dataStatusCode :: Maybe Integer
    } deriving (Show)
instance ToJSON Data where
    toJSON o = object [
        "header"      .= dataHeader o,
        "status_code" .= dataStatusCode o]
