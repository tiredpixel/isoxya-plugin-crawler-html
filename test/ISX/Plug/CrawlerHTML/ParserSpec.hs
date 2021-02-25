module ISX.Plug.CrawlerHTML.ParserSpec (spec) where


import           ISX.Plug.CrawlerHTML.Test
import           TPX.Com.Isoxya.PlugProc
import qualified Data.Map.Strict           as M


spec :: Spec
spec = snapCrawlerHTML $ do
    describe "example.com" $ do
        it "apex" $ do
            (a, e) <- testPage "example.com/" 200 M.empty
            a `shouldBeSet` e
        
        it "follow x-robots-tag ua:noindex,nofollow" $ do
            (a, e) <- testPage "example.com/" 200 $ M.fromList [
                ("X-Robots-Tag", "otherbot: noindex, nofollow")]
            a `shouldBeSet` e
        
        it "nofollow x-robots-tag nofollow" $ do
            (a, e) <- testPage "example.com/_x_robots_tag" 200 $ M.fromList [
                ("X-Robots-Tag", "nofollow")]
            a `shouldBeSet` e
        
        it "nofollow x-robots-tag noindex,nofollow" $ do
            (a, e) <- testPage "example.com/_x_robots_tag" 200 $ M.fromList [
                ("X-Robots-Tag", "noindex, nofollow")]
            a `shouldBeSet` e
        
        it "nofollow meta-robots noindex,nofollow" $ do
            (a, e) <- testPage "example.com/_meta_robots" 200 M.empty
            a `shouldBeSet` e
        
        it "nofollow rel nofollow" $ do
            (a, e) <- testPage "example.com/_rel_nofollow" 200 M.empty
            a `shouldBeSet` e
        
        it "base" $ do
            (a, e) <- testPage "example.com/_base" 200 M.empty
            a `shouldBeSet` e
    
    describe "www.pavouk.tech" $ do
        it "apex" $ do
            (a, e) <- testPage "www.pavouk.tech/" 200 M.empty
            a `shouldBeSet` e
        
        it "robots" $ do
            (a, e) <- testPage "www.pavouk.tech/robots.txt" 200 M.empty
            a `shouldBeSet` e
        
        it "image" $ do
            (a, e) <- testPage "www.pavouk.tech/wp-content/themes/pv-www-theme-2.1.1/assets/images/logo/pv-center.svg.inv.svg.png" 200 M.empty
            a `shouldBeSet` e
    
    describe "www.tiredpixel.com" $
        it "apex" $ do
            (a, e) <- testPage "www.tiredpixel.com/" 200 M.empty
            a `shouldBeSet` e
    
    describe "xkcd.com" $ do
        it "no-redirect 200" $ do
            (a, e) <- testPage "xkcd.com/_empty" 200 $ M.fromList [
                ("Location", "https://xkcd.com/")]
            a `shouldBeSet` e
        
        it "no-redirect 404" $ do
            (a, e) <- testPage "xkcd.com/_empty" 404 $ M.fromList [
                ("Location", "https://xkcd.com/")]
            a `shouldBeSet` e
        
        it "redirect 301" $ do
            (a, e) <- testPage "xkcd.com/" 301 $ M.fromList [
                ("Location", "https://xkcd.com/")]
            a `shouldBeSet` e
        
        it "redirect 302" $ do
            (a, e) <- testPage "xkcd.com/" 302 $ M.fromList [
                ("Location", "https://xkcd.com/")]
            a `shouldBeSet` e
        
        it "redirect 303" $ do
            (a, e) <- testPage "xkcd.com/" 303 $ M.fromList [
                ("Location", "https://xkcd.com/")]
            a `shouldBeSet` e
        
        it "redirect 307" $ do
            (a, e) <- testPage "xkcd.com/" 307 $ M.fromList [
                ("Location", "https://xkcd.com/")]
            a `shouldBeSet` e
        
        it "redirect 308" $ do
            (a, e) <- testPage "xkcd.com/" 308 $ M.fromList [
                ("Location", "https://xkcd.com/")]
            a `shouldBeSet` e


fixtureLink' :: MonadIO m => Text -> m (Maybe (Set PlugProcOURL))
fixtureLink' url = do
    ls <- readFileText $ fixtureLink url
    return $ decode $ encodeUtf8 ls

testPage :: (MonadFail m, MonadIO m) => Text -> Integer -> PlugProcIHeader ->
    m (Set PlugProcOURL, Set PlugProcOURL)
testPage url status header = do
    i <- genPlugProcI url status header
    let linksA = parse i
    Just linksE <- fixtureLink' url
    return (linksA, linksE)
