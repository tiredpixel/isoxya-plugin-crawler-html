module ISX.Plug.CrawlerHTML.Zone.Data (
    create,
    ) where


import ISX.Plug.CrawlerHTML.Core
import TPX.Com.Isoxya.PlugProc
import TPX.Com.Isoxya.Snap.PlugProc ()


create :: Handler b CrawlerHTML ()
create = do
    req_     <- getBoundedJSON' reqLim >>= validateJSON
    Just req <- runValidate req_
    let dat = Data {
        dataHeader   = plugProcIHeader req,
        dataMethod   = plugProcIMetaMethod $ plugProcIMeta req,
        dataStatus   = plugProcIMetaStatus $ plugProcIMeta req,
        dataDuration = plugProcIMetaDuration $ plugProcIMeta req,
        dataErr      = plugProcIMetaErr $ plugProcIMeta req}
    let urls = parse req
    writeJSON PlugProcO {
        plugProcOData = toJSON dat,
        plugProcOURLs = urls}
    where
        reqLim = 2097152 -- 2 MB = (1 + .5) * (4/3) MB
