module ISX.Pick.CrawlerHTML.ParserSpec (spec) where


import              ISX.Pick.CrawlerHTML.Parser
import              ISX.Test
import              Prelude                                 hiding  (get)
import qualified    Data.Map.Strict                         as  M
import qualified    PVK.Com.API.Resource.ISXPick            as  R


spec :: Spec
spec = do
    describe "example.com" $ do
        it "apex" $
            testPage "example.com/" 200 M.empty
        
        it "follow x-robots-tag ua:noindex,nofollow" $
            testPage "example.com/" 200 $ M.fromList [
                ("X-Robots-Tag", "otherbot: noindex, nofollow")]
        
        it "nofollow x-robots-tag nofollow" $
            testPage "example.com/_x_robots_tag" 200 $ M.fromList [
                ("X-Robots-Tag", "nofollow")]
        
        it "nofollow x-robots-tag noindex,nofollow" $
            testPage "example.com/_x_robots_tag" 200 $ M.fromList [
                ("X-Robots-Tag", "noindex, nofollow")]
        
        it "nofollow meta-robots noindex,nofollow" $
            testPage "example.com/_meta_robots" 200 M.empty
        
        it "nofollow rel nofollow" $
            testPage "example.com/_rel_nofollow" 200 M.empty
    
    describe "www.pavouk.tech" $ do
        it "apex" $
            testPage "www.pavouk.tech/" 200 M.empty
        
        it "robots" $
            testPage "www.pavouk.tech/robots.txt" 200 M.empty
        
        it "image" $
            testPage "www.pavouk.tech/wp-content/themes/pv-www-theme-2.1.1/assets/images/logo/pv-center.svg.inv.svg.png" 200 M.empty
    
    describe "www.tiredpixel.com" $
        it "apex" $
            testPage "www.tiredpixel.com/" 200 M.empty
    
    describe "xkcd.com" $ do
        it "no-redirect 200" $
            testPage "xkcd.com/_empty" 200 $ M.fromList [
                ("Location", "https://xkcd.com/")]
        
        it "no-redirect 404" $
            testPage "xkcd.com/_empty" 404 $ M.fromList [
                ("Location", "https://xkcd.com/")]
        
        it "redirect 301" $
            testPage "xkcd.com/" 301 $ M.fromList [
                ("Location", "https://xkcd.com/")]
        
        it "redirect 302" $
            testPage "xkcd.com/" 302 $ M.fromList [
                ("Location", "https://xkcd.com/")]
        
        it "redirect 303" $
            testPage "xkcd.com/" 303 $ M.fromList [
                ("Location", "https://xkcd.com/")]
        
        it "redirect 307" $
            testPage "xkcd.com/" 307 $ M.fromList [
                ("Location", "https://xkcd.com/")]
        
        it "redirect 308" $
            testPage "xkcd.com/" 308 $ M.fromList [
                ("Location", "https://xkcd.com/")]


testPage :: Text -> Integer -> R.RockHeader -> IO ()
testPage url status header = do
    rock <- fRock url status header
    let links = parse rock
    assertLinksLookup (toJSON links) url
