{-# LANGUAGE TemplateHaskell #-}
{-# OPTIONS_GHC -Wno-unused-top-binds #-}


module Isoxya.Plugin.CrawlerHTML.Types (
    CrawlerHTML(..),
    ) where


import Control.Lens (makeLenses)


data CrawlerHTML = CrawlerHTML {}

makeLenses ''CrawlerHTML
