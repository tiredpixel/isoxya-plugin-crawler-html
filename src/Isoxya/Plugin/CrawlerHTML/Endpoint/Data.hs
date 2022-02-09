module Isoxya.Plugin.CrawlerHTML.Endpoint.Data (
    create,
    ) where


import           Isoxya.Plugin.CrawlerHTML.Core
import           TiredPixel.Common.Isoxya.Processor
import           TiredPixel.Common.Isoxya.Snap.Processor ()


create :: Handler b CrawlerHTML ()
create = do
    req_ <- getBoundedJSON' reqLim >>= validateJSON
    Just req <- runValidate req_
    let dat = Data {
        dataDuration = processorIMetaDuration $ processorIMeta req,
        dataError    = processorIMetaError $ processorIMeta req,
        dataHeader   = processorIHeader req,
        dataMethod   = processorIMetaMethod $ processorIMeta req,
        dataStatus   = processorIMetaStatus $ processorIMeta req}
    let urls = parse req
    writeJSON ProcessorO {
        processorOData = toJSON dat,
        processorOURLs = urls}
    where
        reqLim = 2097152 -- 2 MB = (1 + .5) * (4/3) MB
