module ISX.Plug.CrawlerHTML.Zone.Apex (
    apex,
    ) where


import Data.Time.Clock
import Data.Version                (showVersion)
import ISX.Plug.CrawlerHTML.Core
import Paths_isx_plug_crawler_html (version)


apex :: Handler b CrawlerHTML ()
apex = do
    t <- liftIO getCurrentTime
    let v = toText $ showVersion version
    writeJSON $ Apex t v
