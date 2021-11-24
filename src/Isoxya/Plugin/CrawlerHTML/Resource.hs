{-# LANGUAGE RecordWildCards #-}


module Isoxya.Plugin.CrawlerHTML.Resource (
    Apex(..),
    Data(..),
    ) where


import Data.Aeson
import Data.Time.Clock
import TiredPixel.Common.Isoxya.Processor


data Apex = Apex {
    apexNow     :: UTCTime,
    apexVersion :: Text
    } deriving (Show)
instance ToJSON Apex where
    toJSON Apex{..} = object [
        "now"     .= apexNow,
        "version" .= apexVersion]

data Data = Data {
    dataDuration :: Maybe Integer,
    dataError    :: Maybe Text,
    dataHeader   :: ProcessorIHeader,
    dataMethod   :: Text,
    dataStatus   :: Maybe Integer
    } deriving (Show)
instance ToJSON Data where
    toJSON Data{..} = object [
        "duration" .= dataDuration,
        "error"    .= dataError,
        "header"   .= dataHeader,
        "method"   .= dataMethod,
        "status"   .= dataStatus]
