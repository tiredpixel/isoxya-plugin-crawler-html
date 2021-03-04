{-# LANGUAGE TemplateHaskell #-}


module Main (main) where


import Control.Lens                (makeLenses)
import Data.Version                (showVersion)
import ISX.Plug.CrawlerHTML
import Paths_isx_plug_crawler_html (version)
import Snap.Snaplet
import System.IO
import TPX.Com.Snap.CoreUtils


newtype App = App {
    _crawlerHTML :: Snaplet CrawlerHTML}

makeLenses ''App

main :: IO ()
main = do
    let ver = toText $ showVersion version
    hPutStrLn stderr $ toString ver
    serveSnaplet snapCfg initApp


initApp :: SnapletInit App App
initApp = makeSnaplet "App" "" Nothing $ do
    crawlerHTML' <- nestSnaplet "" crawlerHTML initCrawlerHTML
    return $ App crawlerHTML'
