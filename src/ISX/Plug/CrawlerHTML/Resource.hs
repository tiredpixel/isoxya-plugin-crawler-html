{-# LANGUAGE RecordWildCards #-}


module ISX.Plug.CrawlerHTML.Resource (
    Apex(..),
    Data(..),
    ) where


import Data.Aeson
import Data.Time.Clock
import TPX.Com.Isoxya.PlugProc


data Apex = Apex {
    apexTNow    :: UTCTime,
    apexVersion :: Text
    } deriving (Show)
instance ToJSON Apex where
    toJSON Apex{..} = object [
        "t_now"   .= apexTNow,
        "version" .= apexVersion]

data Data = Data {
    dataHeader   :: PlugProcIHeader,
    dataMethod   :: Text,
    dataStatus   :: Maybe Integer,
    dataDuration :: Maybe Rational,
    dataErr      :: Maybe Text
    } deriving (Show)
instance ToJSON Data where
    toJSON Data{..} = object [
        "header"   .= dataHeader,
        "method"   .= dataMethod,
        "status"   .= dataStatus,
        "duration" .= dataDuration,
        "err"      .= dataErr]
