module ISX.Pick.CrawlerHTML.Parser (parse) where


import              Text.HandsomeSoup
import              Text.XML.HXT.Core
import qualified    Data.Set                                as  S
import qualified    Network.URI                             as  URI
import qualified    PVK.Com.API.Ext.URI                     as  URI
import qualified    PVK.Com.API.Resource.ISXPick            as  R


parse :: R.Rock -> S.Set R.OreUrl
parse rock = S.fromList $ normalizeLinks (R.rockMeta rock) links
    where
        body = fromRight "" $ decodeUtf8' $ R.rockBody rock
        doc p = runLA (hread >>> p) $ toString body
        pageLinks = doc $ css "a" ! "href"
        links = toText <$> pageLinks


normalizeLinks :: R.RockMeta -> [Text] -> [R.OreUrl]
normalizeLinks m es =
    URI.URIReference . flip URI.relativeTo baseUrl <$>
        mapMaybe (URI.parseURIReference . toString) es
    where
        baseUrl = URI.unURIAbsolute $ R.rockMetaUrl m
