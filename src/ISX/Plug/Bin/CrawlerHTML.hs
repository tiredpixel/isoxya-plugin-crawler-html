{-# LANGUAGE TemplateHaskell #-}


module Main (main) where


import           Control.Concurrent          (forkIO)
import           Control.Lens                (makeLenses)
import           Data.Version                (showVersion)
import           ISX.Plug.CrawlerHTML
import           Paths_isx_plug_crawler_html (version)
import           Snap.Snaplet
import           System.IO
import qualified TPX.Com.Snap.Main           as S


newtype App = App {
    _crawlerHTML :: Snaplet CrawlerHTML}

makeLenses ''App

main :: IO ()
main = do
    let ver = toText $ showVersion version
    hPutStrLn stderr $ "Isoxya plugin: Crawler HTML " <> toString ver
    done <- S.init
    tId <- forkIO $ serveSnaplet S.config initApp
    S.wait done tId


initApp :: SnapletInit App App
initApp = makeSnaplet "App" "" Nothing $ do
    crawlerHTML' <- nestSnaplet "" crawlerHTML initCrawlerHTML
    return $ App crawlerHTML'
