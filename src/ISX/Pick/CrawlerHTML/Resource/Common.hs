module ISX.Pick.CrawlerHTML.Resource.Common (
    Apex(..),
    DataStatus(..)
    ) where


import              Data.Aeson
import              Data.Time.Clock                         (UTCTime)


data Apex = Apex {
    apexTNow    :: UTCTime,
    apexVersion :: Text
    } deriving (Show)
instance ToJSON Apex where
    toJSON o = object [
        "t_now"   .= apexTNow o,
        "version" .= apexVersion o]

newtype DataStatus = DataStatus {
    dataStatusCode :: Maybe Integer
    } deriving (Show)
instance ToJSON DataStatus where
    toJSON o = object [
        "status_code" .= dataStatusCode o]
