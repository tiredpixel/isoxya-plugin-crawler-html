module Isoxya.Plugin.CrawlerHTML.Endpoint.DataSpec (spec) where


import Isoxya.Plugin.CrawlerHTML.Test


spec :: Spec
spec = snapCrawlerHTML $
    describe "create" $ do
        it "=> 200" $ do
            let req = postJSON "/data" pC
            res <- runRequest req
            rspStatus res `shouldBe` 200
            b <- getResponseBody res
            b ^. key "data" . key "header" . _Object `shouldBe` emptyO
            test res Nothing []
        
        it "header => 200" $ do
            let p = mergeObject pC $ object [
                    ("header", object [
                        ("Content-Type", "application/pdf")])]
            let req = postJSON "/data" p
            res <- runRequest req
            rspStatus res `shouldBe` 200
            b <- getResponseBody res
            b ^. key "data" . key "header" . key "Content-Type" . _String `shouldBe` "application/pdf"
            b ^. key "data" . key "header" . _Object `shouldMeasure` 1
            test res Nothing []
        
        it "status => 200" $ do
            let p = mergeObject pC $ object [
                    ("meta", object [
                        ("status", Number 418)])]
            let req = postJSON "/data" p
            res <- runRequest req
            rspStatus res `shouldBe` 200
            b <- getResponseBody res
            b ^. key "data" . key "header" . _Object `shouldBe` emptyO
            test res (Just 418) []
        
        it "redirect => 200" $ do
            let p = mergeObject pC $ object [
                    ("meta", object [
                        ("status", Number 301)]),
                    ("header", object [
                        ("Location", "http://example.com")])]
            let req = postJSON "/data" p
            res <- runRequest req
            rspStatus res `shouldBe` 200
            b <- getResponseBody res
            b ^. key "data" . key "header" . key "Location" . _String `shouldBe` "http://example.com"
            b ^. key "data" . key "header" . _Object `shouldMeasure` 1
            test res (Just 301) ["http://example.com"]


pC :: Value
pC = object [
    ("meta", object [
        ("url", "http://example.com:80/"),
        ("method", "GET")]),
    ("header", object []),
    ("body", String "")]

test :: Response -> Maybe Integer -> [Value] -> SnapHspecM b ()
test res status urls = do
    rspStatus res `shouldBe` 200
    b <- getResponseBody res
    b ^? key "data" . key "duration" . _Object `shouldBe` Nothing
    b ^? key "data" . key "error" . _String `shouldBe` Nothing
    b ^. key "data" . key "method" . _String `shouldBe` "GET"
    b ^? key "data" . key "status" . _Integer `shouldBe` status
    b ^. key "data" . _Object `shouldMeasure` 5
    toList (b ^. key "urls" . _Array) `shouldBeList` urls
    b ^. _Object `shouldMeasure` 2
