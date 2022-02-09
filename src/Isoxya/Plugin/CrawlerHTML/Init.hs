module Isoxya.Plugin.CrawlerHTML.Init (
    initCrawlerHTML,
    routesCrawlerHTML,
    ) where


import qualified Isoxya.Plugin.CrawlerHTML.Endpoint.Apex as Apx
import qualified Isoxya.Plugin.CrawlerHTML.Endpoint.Data as Dat
import           Isoxya.Plugin.CrawlerHTML.Type
import           Snap.Core
import           Snap.Snaplet
import           TiredPixel.Common.Snap.CoreUtil


initCrawlerHTML :: SnapletInit b CrawlerHTML
initCrawlerHTML = makeSnaplet "CrawlerHTML" "" Nothing $ do
    addRoutes routesCrawlerHTML
    return CrawlerHTML

routesCrawlerHTML :: [(ByteString, Handler b CrawlerHTML ())]
routesCrawlerHTML = [
    ("",        ifTop       Apx.apex),
    --
    ("data",    method POST Dat.create),
    ("data/:_",             notFound),
    --
    ("",                    notFound)]
