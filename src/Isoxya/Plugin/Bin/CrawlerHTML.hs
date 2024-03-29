{-# LANGUAGE TemplateHaskell #-}


module Main (main) where


import           Control.Concurrent               (forkIO)
import           Control.Lens                     (makeLenses)
import           Data.Version                     (showVersion)
import           Isoxya.Plugin.CrawlerHTML
import           Paths_isoxya_plugin_crawler_html (version)
import           Snap.Snaplet
import           System.IO
import qualified TiredPixel.Common.Snap.Main      as S


newtype App = App { _crawlerHTML :: Snaplet CrawlerHTML }

makeLenses ''App

main :: IO ()
main = do
    hPutStrLn stderr $ "Isoxya plugin Crawler HTML " <> toString ver
    done <- S.init
    tId <- forkIO $ serveSnaplet S.config initApp
    S.wait done tId
    where
        ver = toText $ showVersion version


initApp :: SnapletInit App App
initApp = makeSnaplet "App" "" Nothing $ do
    crawlerHTML' <- nestSnaplet "" crawlerHTML initCrawlerHTML
    return $ App crawlerHTML'
