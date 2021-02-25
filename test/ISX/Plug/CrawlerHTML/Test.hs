module ISX.Plug.CrawlerHTML.Test (
    module ISX.Plug.CrawlerHTML,
    module ISX.Plug.CrawlerHTML.Core,
    module TPX.Com.Snap.Test,
    fixtureLink,
    fixturePage,
    fixtureResult,
    genPlugProcI,
    snapCrawlerHTML,
    ) where


import           ISX.Plug.CrawlerHTML
import           ISX.Plug.CrawlerHTML.Core hiding (addHeader, setContentType, setHeader, (.=))
import           Network.URI
import           TPX.Com.Isoxya.PlugProc
import           TPX.Com.Snap.Test
import           TPX.Com.URI
import qualified Data.Text                 as T


fixtureLink :: Text -> FilePath
fixtureLink url = toString $ "test/fixture/links/" <> fxExt url <> ".json"

fixturePage :: Text -> FilePath
fixturePage url = toString $ "test/fixture/pages/" <> fxExt url

fixtureResult :: Text -> FilePath
fixtureResult url = toString $ "test/fixture/results/" <> fxExt url <> ".json"

genPlugProcI :: MonadIO m => Text -> Integer -> PlugProcIHeader -> m PlugProcI
genPlugProcI url status header = do
    body <- liftIO $ readFileBS $ fixturePage url
    return PlugProcI {
        plugProcIMeta   = meta,
        plugProcIHeader = header,
        plugProcIBody   = body}
    where
        Just metaURL = URIAbsolute <$>
            parseAbsoluteURI (toString $ "http://" <> url)
        meta = PlugProcIMeta {
            plugProcIMetaURL      = metaURL,
            plugProcIMetaMethod   = "GET",
            plugProcIMetaStatus   = Just status,
            plugProcIMetaDuration = Nothing,
            plugProcIMetaErr      = Nothing,
            plugProcIMetaConfig   = Nothing}

snapCrawlerHTML :: SpecWith (SnapHspecState CrawlerHTML) -> Spec
snapCrawlerHTML = snap (route routesCrawlerHTML) initCrawlerHTMLTest


fxExt :: Text -> Text
fxExt url = if T.takeEnd 1 url == "/"
    then url <> "index.html"
    else url

initCrawlerHTMLTest :: SnapletInit b CrawlerHTML
initCrawlerHTMLTest = makeSnaplet "crawlerHTMLTest" "Isoxya plugin: Crawler HTML Test" Nothing $ do
    addRoutes routesCrawlerHTML
    return CrawlerHTML
