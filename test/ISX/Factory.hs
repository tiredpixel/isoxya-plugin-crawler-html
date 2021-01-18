module ISX.Factory (
    fPlugProcI,
    fxExt
    ) where


import              Network.URI
import              TPX.Com.URI
import qualified    Data.Text                               as  T
import qualified    TPX.Com.ISX.PlugProc                    as  R


fPlugProcI :: Text -> Integer -> R.PlugProcIHeader -> IO R.PlugProcI
fPlugProcI url status header = do
    body <- readFileBS $ fixturePage url
    return R.PlugProcI {
        R.plugProcIMeta   = meta,
        R.plugProcIHeader = header,
        R.plugProcIBody   = body}
    where
        Just metaURL = parseURL url
        meta = R.PlugProcIMeta {
            R.plugProcIMetaURL    = metaURL,
            R.plugProcIMetaStatus = Just status,
            R.plugProcIMetaConfig = Nothing}

fxExt :: Text -> Text
fxExt url = if T.takeEnd 1 url == "/"
    then url <> "index.html"
    else url


fixturePage :: Text -> FilePath
fixturePage url = toString $ "test/fixture/pages/" <> fxExt url

parseURL :: Text -> Maybe URIAbsolute
parseURL url = URIAbsolute <$> parseAbsoluteURI (toString $ "http://" <> url)
