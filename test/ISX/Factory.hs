module ISX.Factory (
    fRock,
    fxExt
    ) where


import              Network.URI
import              TPX.Com.API.Ext.URI
import qualified    Data.Text                               as  T
import qualified    TPX.Com.API.Resource.ISX.Pick           as  R


fRock :: Text -> Integer -> R.RockHeader -> IO R.Rock
fRock url status header = do
    body <- readFileBS $ fixturePage url
    return R.Rock {
        R.rockMeta   = meta,
        R.rockHeader = header,
        R.rockBody   = body}
    where
        Just metaUrl = parseUrl url
        meta = R.RockMeta {
            R.rockMetaUrl        = metaUrl,
            R.rockMetaStatusCode = Just status,
            R.rockMetaConfig     = Nothing}

fxExt :: Text -> Text
fxExt url = if T.takeEnd 1 url == "/"
    then url <> "index.html"
    else url


fixturePage :: Text -> FilePath
fixturePage url = toString $ "test/fixture/pages/" <> fxExt url

parseUrl :: Text -> Maybe URIAbsolute
parseUrl url = URIAbsolute <$> parseAbsoluteURI (toString $ "http://" <> url)
