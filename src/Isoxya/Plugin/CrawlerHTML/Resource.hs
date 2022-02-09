{-# LANGUAGE RecordWildCards #-}


module Isoxya.Plugin.CrawlerHTML.Resource (
    Apex(..),
    Data(..),
    ) where


import           Data.Aeson
import           Data.Fixed                         (Pico)
import           Data.Time.Clock
import           TiredPixel.Common.Isoxya.Processor


data Apex = Apex
              { apexTime    :: UTCTime
              , apexVersion :: Text
              }
  deriving (Show)
instance ToJSON Apex where
    toJSON Apex{..} = object [
        "time"    .= apexTime,
        "version" .= apexVersion]

data Data = Data
              { dataDuration :: Maybe Pico
              , dataError    :: Maybe Text
              , dataHeader   :: ProcessorIHeader
              , dataMethod   :: Text
              , dataStatus   :: Maybe Integer
              }
  deriving (Show)
instance ToJSON Data where
    toJSON Data{..} = object [
        "duration" .= dataDuration,
        "error"    .= dataError,
        "header"   .= dataHeader,
        "method"   .= dataMethod,
        "status"   .= dataStatus]
