module Isoxya.Plugin.CrawlerHTML.Init (
    initCrawlerHTML,
    routesCrawlerHTML,
    ) where


import           Isoxya.Plugin.CrawlerHTML.Type
import           Snap.Core
import           Snap.Snaplet
import           TiredPixel.Common.Snap.CoreUtil
import qualified Isoxya.Plugin.CrawlerHTML.Endpoint.Apex as EA
import qualified Isoxya.Plugin.CrawlerHTML.Endpoint.Data as ED


initCrawlerHTML :: SnapletInit b CrawlerHTML
initCrawlerHTML = makeSnaplet "CrawlerHTML" "" Nothing $ do
    addRoutes routesCrawlerHTML
    return CrawlerHTML

routesCrawlerHTML :: [(ByteString, Handler b CrawlerHTML ())]
routesCrawlerHTML = [
    ("",        ifTop       EA.apex),
    --
    ("data",    method POST ED.create),
    ("data/:_",             notFound),
    --
    ("",                    notFound)]
