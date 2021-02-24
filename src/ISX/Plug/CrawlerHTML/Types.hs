{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -Wno-unused-top-binds #-}


module ISX.Plug.CrawlerHTML.Types (
    CrawlerHTML(..),
    ) where


import Control.Lens (makeLenses)


data CrawlerHTML = CrawlerHTML {}

makeLenses ''CrawlerHTML
