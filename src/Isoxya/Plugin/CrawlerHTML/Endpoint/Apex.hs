module Isoxya.Plugin.CrawlerHTML.Endpoint.Apex (
    apex,
    ) where


import Data.Time.Clock
import Data.Version                     (showVersion)
import Isoxya.Plugin.CrawlerHTML.Core
import Paths_isoxya_plugin_crawler_html (version)


apex :: Handler b CrawlerHTML ()
apex = do
    t <- liftIO getCurrentTime
    writeJSON $ Apex t ver
    where
        ver = toText $ showVersion version
