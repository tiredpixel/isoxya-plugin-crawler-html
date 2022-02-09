module Isoxya.Plugin.CrawlerHTML.Test (
    module Isoxya.Plugin.CrawlerHTML,
    module Isoxya.Plugin.CrawlerHTML.Core,
    module TiredPixel.Common.Snap.Test,
    fixtureLink,
    fixturePage,
    fixtureResult,
    genProcessorI,
    snapCrawlerHTML,
    ) where


import qualified Data.Text                          as T
import           Isoxya.Plugin.CrawlerHTML
import           Isoxya.Plugin.CrawlerHTML.Core     hiding (addHeader,
                                                     setContentType, setHeader,
                                                     (.=))
import           Network.URI
import           TiredPixel.Common.Isoxya.Processor
import           TiredPixel.Common.Snap.Test
import           TiredPixel.Common.URI


fixtureLink :: Text -> FilePath
fixtureLink url = toString $ "test/fixture/links/" <> fxExt url <> ".json"

fixturePage :: Text -> FilePath
fixturePage url = toString $ "test/fixture/pages/" <> fxExt url

fixtureResult :: Text -> FilePath
fixtureResult url = toString $ "test/fixture/results/" <> fxExt url <> ".json"

genProcessorI :: MonadIO m => Text -> Integer -> ProcessorIHeader ->
    m ProcessorI
genProcessorI url status header = do
    body <- liftIO $ readFileBS $ fixturePage url
    return ProcessorI {
        processorIBody   = body,
        processorIHeader = header,
        processorIMeta   = meta}
    where
        Just metaURL = URIAbsolute <$>
            parseAbsoluteURI (toString $ "http://" <> url)
        meta = ProcessorIMeta {
            processorIMetaConfig   = Nothing,
            processorIMetaDuration = Nothing,
            processorIMetaError    = Nothing,
            processorIMetaMethod   = "GET",
            processorIMetaStatus   = Just status,
            processorIMetaURL      = metaURL}

snapCrawlerHTML :: SpecWith (SnapHspecState CrawlerHTML) -> Spec
snapCrawlerHTML = snap (route routesCrawlerHTML) initCrawlerHTMLTest


fxExt :: Text -> Text
fxExt url = if T.takeEnd 1 url == "/"
    then url <> "index.html"
    else url

initCrawlerHTMLTest :: SnapletInit b CrawlerHTML
initCrawlerHTMLTest = makeSnaplet "CrawlerHTML" "" Nothing $ do
    addRoutes routesCrawlerHTML
    return CrawlerHTML
