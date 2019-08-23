module ISX.Test (
    module PVK.Com.API.Test,
    withSrv
    ) where


import              ISX.Pick.CrawlerHTML.Route
import              PVK.Com.API.Test


withSrv :: RequestBuilder IO () -> IO Response
withSrv r = runHandler r site
