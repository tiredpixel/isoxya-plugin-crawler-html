module ISX.Pick.CrawlerHTML.Zone.Common.Data (
    create
    ) where


import              Data.Aeson
import              ISX.Pick.CrawlerHTML.Parser
import              PVK.Com.API.Resource.ISXPickSnap        ()
import              Snap.Core
import              Snap.Extras.JSON
import              System.Environment                      (lookupEnv)
import qualified    ISX.Pick.CrawlerHTML.Resource.Common    as  R
import qualified    PVK.Com.API.Req                         as  Req
import qualified    PVK.Com.API.Res                         as  Res
import qualified    PVK.Com.API.Resource.ISXPick            as  R


create :: Snap ()
create = do
    reqLim_ <- liftIO $ join <$> (fmap . fmap) readMaybe (lookupEnv "REQ_LIM")
    let reqLim = fromMaybe reqLimDef reqLim_
    req_      <- Req.getBoundedJSON' reqLim >>= Req.validateJSON
    Just rock <- Res.runValidate req_
    let links = parse rock
    writeJSON R.Ore {
        R.oreData = toJSON R.DataStatus {
            R.dataStatusCode = R.rockMetaStatusCode $ R.rockMeta rock},
        R.oreUrls = links}


reqLimDef :: Int64
reqLimDef = 2097152 -- 2 MB = (1 + .5) * (4/3) MB
