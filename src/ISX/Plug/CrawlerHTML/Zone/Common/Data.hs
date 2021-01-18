module ISX.Plug.CrawlerHTML.Zone.Common.Data (
    create
    ) where


import              Data.Aeson
import              ISX.Plug.CrawlerHTML.Parser
import              Snap.Core
import              Snap.Extras.JSON
import              System.Environment                      (lookupEnv)
import              TPX.Com.ISX.PlugProcSnap                ()
import qualified    ISX.Plug.CrawlerHTML.Resource.Common    as  R
import qualified    TPX.Com.API.Req                         as  Req
import qualified    TPX.Com.API.Res                         as  Res
import qualified    TPX.Com.ISX.PlugProc                    as  R


create :: Snap ()
create = do
    reqLim_ <- liftIO $ join <$> (fmap . fmap) readMaybe (lookupEnv "REQ_LIM")
    let reqLim = fromMaybe reqLimDef reqLim_
    req_      <- Req.getBoundedJSON' reqLim >>= Req.validateJSON
    Just procI <- Res.runValidate req_
    let links = parse procI
    writeJSON R.PlugProcO {
        R.plugProcOData = toJSON R.Data {
            R.dataHeader = R.plugProcIHeader procI,
            R.dataStatus = R.plugProcIMetaStatus $ R.plugProcIMeta procI},
        R.plugProcOURLs = links}


reqLimDef :: Int64
reqLimDef = 2097152 -- 2 MB = (1 + .5) * (4/3) MB
