module ISX.Pick.CrawlerHTML.Zone.Common.Data (
    create
    ) where


import              Data.Aeson
import              ISX.Pick.CrawlerHTML.Parser
import              PVK.Com.API.Resource.ISXPickSnap        ()
import              Snap.Core
import              Snap.Extras.JSON
import qualified    PVK.Com.API.Req                         as  Req
import qualified    PVK.Com.API.Res                         as  Res
import qualified    PVK.Com.API.Resource.ISXPick            as  R


create :: Snap ()
create = do
    req_      <- Req.getBoundedJSON' s >>= Req.validateJSON
    Just rock <- Res.runValidate req_
    let links = parse rock
    writeJSON $ R.Ore {
        R.oreData = Null,
        R.oreUrls = links}
    where
        s = 50000000 -- 50 MB
