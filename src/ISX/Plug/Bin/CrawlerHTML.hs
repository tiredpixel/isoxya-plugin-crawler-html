module Main (main) where


import              Data.Version                            (showVersion)
import              ISX.Plug.CrawlerHTML.Route
import              Paths_isx_plug_crawler_html             (version)
import              TPX.Com.API.Res
import qualified    Snap.Http.Server                        as  Srv


main :: IO ()
main = do
    let ver = toText $ showVersion version
    putTextLn ver
    cEmp <- Srv.commandLineConfig Srv.emptyConfig
    Srv.httpServe (conf cEmp) site
    where
        cLog = Srv.ConfigFileLog "-"
        conf =
            Srv.setAccessLog cLog .
            Srv.setErrorLog cLog .
            Srv.setErrorHandler intErr'
