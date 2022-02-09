module Isoxya.Plugin.CrawlerHTML.ParserSpec (spec) where


import qualified Data.Map.Strict                    as M
import           Isoxya.Plugin.CrawlerHTML.Test
import           TiredPixel.Common.Isoxya.Processor


spec :: Spec
spec = snapCrawlerHTML $ do
    describe "example.com" $ do
        it "apex" $ do
            (a, e) <- load "example.com/" 200 M.empty
            a `shouldBeSet` e

        it "follow x-robots-tag ua:noindex,nofollow" $ do
            (a, e) <- load "example.com/" 200 $ M.fromList [
                ("X-Robots-Tag", "otherbot: noindex, nofollow")]
            a `shouldBeSet` e

        it "nofollow x-robots-tag nofollow" $ do
            (a, e) <- load "example.com/_x_robots_tag" 200 $ M.fromList [
                ("X-Robots-Tag", "nofollow")]
            a `shouldBeSet` e

        it "nofollow x-robots-tag noindex,nofollow" $ do
            (a, e) <- load "example.com/_x_robots_tag" 200 $ M.fromList [
                ("X-Robots-Tag", "noindex, nofollow")]
            a `shouldBeSet` e

        it "nofollow meta-robots noindex,nofollow" $ do
            (a, e) <- load "example.com/_meta_robots" 200 M.empty
            a `shouldBeSet` e

        it "nofollow rel nofollow" $ do
            (a, e) <- load "example.com/_rel_nofollow" 200 M.empty
            a `shouldBeSet` e

        it "base" $ do
            (a, e) <- load "example.com/_base" 200 M.empty
            a `shouldBeSet` e

    describe "www.pavouk.tech" $ do
        it "apex" $ do
            (a, e) <- load "www.pavouk.tech/" 200 M.empty
            a `shouldBeSet` e

        it "robots" $ do
            (a, e) <- load "www.pavouk.tech/robots.txt" 200 M.empty
            a `shouldBeSet` e

        it "image" $ do
            (a, e) <- load "www.pavouk.tech/wp-content/themes/pv-www-theme-2.1.1/assets/images/logo/pv-center.svg.inv.svg.png" 200 M.empty
            a `shouldBeSet` e

    describe "www.tiredpixel.com" $
        it "apex" $ do
            (a, e) <- load "www.tiredpixel.com/" 200 M.empty
            a `shouldBeSet` e

    describe "xkcd.com" $ do
        it "no-redirect 200" $ do
            (a, e) <- load "xkcd.com/_empty" 200 $ M.fromList [
                ("Location", "https://xkcd.com/")]
            a `shouldBeSet` e

        it "no-redirect 404" $ do
            (a, e) <- load "xkcd.com/_empty" 404 $ M.fromList [
                ("Location", "https://xkcd.com/")]
            a `shouldBeSet` e

        it "redirect 301" $ do
            (a, e) <- load "xkcd.com/" 301 $ M.fromList [
                ("Location", "https://xkcd.com/")]
            a `shouldBeSet` e

        it "redirect 302" $ do
            (a, e) <- load "xkcd.com/" 302 $ M.fromList [
                ("Location", "https://xkcd.com/")]
            a `shouldBeSet` e

        it "redirect 303" $ do
            (a, e) <- load "xkcd.com/" 303 $ M.fromList [
                ("Location", "https://xkcd.com/")]
            a `shouldBeSet` e

        it "redirect 307" $ do
            (a, e) <- load "xkcd.com/" 307 $ M.fromList [
                ("Location", "https://xkcd.com/")]
            a `shouldBeSet` e

        it "redirect 308" $ do
            (a, e) <- load "xkcd.com/" 308 $ M.fromList [
                ("Location", "https://xkcd.com/")]
            a `shouldBeSet` e


load :: (MonadFail m, MonadIO m) => Text -> Integer -> ProcessorIHeader ->
    m (Set ProcessorOURL, Set ProcessorOURL)
load url status header = do
    i <- genProcessorI url status header
    let linksA = parse i
    t <- readFileText $ fixtureLink url
    let Just linksE = decode $ encodeUtf8 t
    return (linksA, linksE)
