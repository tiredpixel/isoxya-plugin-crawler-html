module ISX.Plug.CrawlerHTML.Zone.Common.Data (
    create
    ) where


import              Data.Aeson
import              ISX.Plug.CrawlerHTML.Parser
import              Snap.Core
import              Snap.Extras.JSON
import              System.Environment                      (lookupEnv)
import              TPX.Com.API.Resource.ISX.ProcSnap       ()
import qualified    ISX.Plug.CrawlerHTML.Resource.Common    as  R
import qualified    TPX.Com.API.Req                         as  Req
import qualified    TPX.Com.API.Res                         as  Res
import qualified    TPX.Com.API.Resource.ISX.Proc           as  R


create :: Snap ()
create = do
    reqLim_ <- liftIO $ join <$> (fmap . fmap) readMaybe (lookupEnv "REQ_LIM")
    let reqLim = fromMaybe reqLimDef reqLim_
    req_      <- Req.getBoundedJSON' reqLim >>= Req.validateJSON
    Just procI <- Res.runValidate req_
    let links = parse procI
    writeJSON R.ProcO {
        R.procOData = toJSON R.Data {
            R.dataHeader     = R.procIHeader procI,
            R.dataStatusCode = R.procIMetaStatusCode $ R.procIMeta procI},
        R.procOUrls = links}


reqLimDef :: Int64
reqLimDef = 2097152 -- 2 MB = (1 + .5) * (4/3) MB
