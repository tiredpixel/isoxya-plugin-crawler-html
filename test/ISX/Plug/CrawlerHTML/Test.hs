module ISX.Plug.CrawlerHTML.Test (
    module ISX.Plug.CrawlerHTML,
    module ISX.Plug.CrawlerHTML.Core,
    module TPX.Com.Snap.Test,
    fixtureLink,
    fixturePage,
    fixtureResult,
    snapCrawlerHTML,
    ) where


import           ISX.Plug.CrawlerHTML
import           ISX.Plug.CrawlerHTML.Core hiding (addHeader, setContentType, setHeader, (.=))
import           TPX.Com.Snap.Test
import qualified Data.Text                 as T


fixtureLink :: Text -> FilePath
fixtureLink url = toString $ "test/fixture/links/" <> fxExt url <> ".json"

fixturePage :: Text -> FilePath
fixturePage url = toString $ "test/fixture/pages/" <> fxExt url

fixtureResult :: Text -> FilePath
fixtureResult url = toString $ "test/fixture/results/" <> fxExt url <> ".json"

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
