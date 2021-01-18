module ISX.Factory (
    fPlugProcI,
    fxExt,
    ) where


import              Network.URI
import              TPX.Com.ISX.PlugProc
import              TPX.Com.URI
import qualified    Data.Text                               as  T


fPlugProcI :: Text -> Integer -> PlugProcIHeader -> IO PlugProcI
fPlugProcI url status header = do
    body <- readFileBS $ fixturePage url
    return PlugProcI {
        plugProcIMeta   = meta,
        plugProcIHeader = header,
        plugProcIBody   = body}
    where
        Just metaURL = parseURL url
        meta = PlugProcIMeta {
            plugProcIMetaURL    = metaURL,
            plugProcIMetaStatus = Just status,
            plugProcIMetaConfig = Nothing}

fxExt :: Text -> Text
fxExt url = if T.takeEnd 1 url == "/"
    then url <> "index.html"
    else url


fixturePage :: Text -> FilePath
fixturePage url = toString $ "test/fixture/pages/" <> fxExt url

parseURL :: Text -> Maybe URIAbsolute
parseURL url = URIAbsolute <$> parseAbsoluteURI (toString $ "http://" <> url)
