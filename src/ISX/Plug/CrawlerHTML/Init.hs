module ISX.Plug.CrawlerHTML.Init (
    initCrawlerHTML,
    routesCrawlerHTML,
    ) where


import           ISX.Plug.CrawlerHTML.Types
import           Snap.Core
import           Snap.Snaplet
import           TPX.Com.Snap.CoreUtils
import qualified ISX.Plug.CrawlerHTML.Zone.Apex as ZA
import qualified ISX.Plug.CrawlerHTML.Zone.Data as ZD


initCrawlerHTML :: SnapletInit b CrawlerHTML
initCrawlerHTML = makeSnaplet "CrawlerHTML" "" Nothing $ do
    addRoutes routesCrawlerHTML
    return CrawlerHTML

routesCrawlerHTML :: [(ByteString, Handler b CrawlerHTML ())]
routesCrawlerHTML = [
    ("",                                    ifTop           ZA.apex),
    --
    ("data",                                method POST     ZD.create),
    ("data/:_",                                             notFound),
    --
    ("",                                                    notFound)]
