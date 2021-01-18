module ISX.Plug.CrawlerHTML.Route (site) where


import              Snap.Core
import              TPX.Com.API.Res
import qualified    ISX.Plug.CrawlerHTML.Zone.Apex          as  ZA
import qualified    ISX.Plug.CrawlerHTML.Zone.Data          as  ZD


site :: Snap ()
site = ifTop ZA.apex <|> route [
    ("data",                                method POST     ZD.create),
    ("data/:_",                                             notFound),
    --
    ("",                                                    notFound)]
