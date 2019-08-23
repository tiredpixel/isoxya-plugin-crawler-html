module ISX.Pick.CrawlerHTML.Zone.Common.DataSpec (spec) where


import              ISX.Test
import              Prelude                                 hiding  (get)


{-# ANN module ("HLint: ignore Reduce duplication" :: String) #-}


spec :: Spec
spec =
    describe "/data POST" $ do
        it "ok" $ do
            res <- withSrv $ postJSON "/data" pC
            assertSuccess res
            b <- getResponseBody res
            b ^.. key "data" . values `shouldBe` []
            b ^.. key "urls" . values `shouldBe` []
            assertElemN res 2
        
        describe "www.pavouk.tech" $
            it "apex" $
                testPage "www.pavouk.tech/"


pC :: Value
pC = object [
    ("meta", object [
        ("url", "http://example.com:80/")]),
    ("header", object []),
    ("body", String "")]

testPage :: Text -> IO ()
testPage url = do
    rock <- fRock url
    res <- withSrv $ postJSON "/data" rock
    assertSuccess res
    b <- getResponseBody res
    b ^.. key "data" . values `shouldBe` []
    assertResultsLookup (b ^. key "urls" . _Array) url
    assertElemN res 2
