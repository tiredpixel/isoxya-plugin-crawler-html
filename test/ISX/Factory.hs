module ISX.Factory (
    fProcI,
    fxExt
    ) where


import              Network.URI
import              TPX.Com.API.Ext.URI
import qualified    Data.Text                               as  T
import qualified    TPX.Com.API.Resource.ISX.Proc           as  R


fProcI :: Text -> Integer -> R.ProcIHeader -> IO R.ProcI
fProcI url status header = do
    body <- readFileBS $ fixturePage url
    return R.ProcI {
        R.procIMeta   = meta,
        R.procIHeader = header,
        R.procIBody   = body}
    where
        Just metaUrl = parseUrl url
        meta = R.ProcIMeta {
            R.procIMetaUrl        = metaUrl,
            R.procIMetaStatusCode = Just status,
            R.procIMetaConfig     = Nothing}

fxExt :: Text -> Text
fxExt url = if T.takeEnd 1 url == "/"
    then url <> "index.html"
    else url


fixturePage :: Text -> FilePath
fixturePage url = toString $ "test/fixture/pages/" <> fxExt url

parseUrl :: Text -> Maybe URIAbsolute
parseUrl url = URIAbsolute <$> parseAbsoluteURI (toString $ "http://" <> url)
