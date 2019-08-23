module ISX.Test (
    module ISX.Factory,
    module PVK.Com.API.Test,
    assertLinksLookup,
    assertResultsLookup,
    withSrv
    ) where


import              Data.Vector                             (Vector)
import              ISX.Factory
import              ISX.Pick.CrawlerHTML.Route
import              PVK.Com.API.Test


assertLinksLookup :: Value -> Text -> IO ()
assertLinksLookup links url = do
    links0 <- readFileText $ fixtureLink url
    let Just links0' = decode $ encodeUtf8 links0 :: Maybe Value
    links `shouldBe` links0'

assertResultsLookup :: Vector Value -> Text -> IO ()
assertResultsLookup results url = do
    results0 <- readFileText $ fixtureResult url
    let Just results0' = decode $ encodeUtf8 results0 :: Maybe (Vector Value)
    results `shouldBe` results0'

withSrv :: RequestBuilder IO () -> IO Response
withSrv r = runHandler r site


fixtureLink :: Text -> FilePath
fixtureLink url = toString $ "test/fixture/links/" <> fxExt url <> ".json"

fixtureResult :: Text -> FilePath
fixtureResult url = toString $ "test/fixture/results/" <> fxExt url <> ".json"
