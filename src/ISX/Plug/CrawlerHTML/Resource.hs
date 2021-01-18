{-# LANGUAGE RecordWildCards #-}


module ISX.Plug.CrawlerHTML.Resource (
    Apex(..),
    Data(..),
    ) where


import              Data.Aeson
import              Data.Time.Clock                         (UTCTime)
import              TPX.Com.ISX.PlugProc


data Apex = Apex {
    apexTNow    :: UTCTime,
    apexVersion :: Text
    } deriving (Show)
instance ToJSON Apex where
    toJSON Apex{..} = object [
        "t_now"   .= apexTNow,
        "version" .= apexVersion]

data Data = Data {
    dataHeader :: PlugProcIHeader,
    dataStatus :: Maybe Integer
    } deriving (Show)
instance ToJSON Data where
    toJSON Data{..} = object [
        "header" .= dataHeader,
        "status" .= dataStatus]
