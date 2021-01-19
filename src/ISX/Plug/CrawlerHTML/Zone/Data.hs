module ISX.Plug.CrawlerHTML.Zone.Data (
    create,
    ) where


import              Data.Aeson
import              ISX.Plug.CrawlerHTML.Parser
import              ISX.Plug.CrawlerHTML.Resource
import              Snap.Core
import              Snap.Extras.JSON
import              TPX.Com.API.Req
import              TPX.Com.API.Res
import              TPX.Com.ISX.PlugProc
import              TPX.Com.ISX.PlugProcSnap                ()


create :: Snap ()
create = do
    req_     <- getBoundedJSON' reqLim >>= validateJSON
    Just req <- runValidate req_
    let dat = Data {
        dataHeader   = plugProcIHeader req,
        dataMethod   = plugProcIMetaMethod $ plugProcIMeta req,
        dataStatus   = plugProcIMetaStatus $ plugProcIMeta req,
        dataDuration = plugProcIMetaDuration (plugProcIMeta req),
        dataErr      = plugProcIMetaErr $ plugProcIMeta req}
    let urls = parse req
    writeJSON PlugProcO {
        plugProcOData = toJSON dat,
        plugProcOURLs = urls}
    where
        reqLim = 2097152 -- 2 MB = (1 + .5) * (4/3) MB
