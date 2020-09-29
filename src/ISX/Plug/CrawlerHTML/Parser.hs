module ISX.Plug.CrawlerHTML.Parser (parse) where


import              Text.HandsomeSoup
import              Text.XML.HXT.Core
import qualified    Data.Map                                as  M
import qualified    Data.Set                                as  S
import qualified    Data.Text                               as  T
import qualified    Network.URI                             as  URI
import qualified    TPX.Com.API.Ext.URI                     as  URI
import qualified    TPX.Com.API.Resource.ISX.Proc           as  R


parse :: R.ProcI -> S.Set R.ProcOUrl
parse procI = S.fromList $ normalizeLinks m base links
    where
        m = R.procIMeta procI
        h = R.procIHeader procI
        b = R.procIBody procI
        body = fromRight "" $ decodeUtf8' b
        doc p = runLA (hread >>> p) $ toString body
        base = URI.URIAbsolute <$> (URI.parseAbsoluteURI =<< listToMaybe (
            doc $ css "base" ! "href"))
        pageLinks = doc $ css "a" >>> neg (css "a[rel~=\"nofollow\"]") ! "href"
        metaRobots = doc $ css "meta[name=\"robots\"]" ! "content"
        links
            | isHeaderRedirect m = maybeToList $ M.lookup "Location" h
            | isHeaderNoFollow h = []
            | isMetaNoFollow (toText <$> metaRobots) = []
            | otherwise = toText <$> pageLinks


isHeaderNoFollow :: R.ProcIHeader -> Bool
isHeaderNoFollow h = "nofollow" `S.member` robots
    where
        robots = case M.lookup "X-Robots-Tag" h of
            Just v  -> S.fromList $ T.strip <$> splitTag v
            Nothing -> S.empty
        splitTag t = case T.breakOnEnd ":" t of
            ("", v) -> T.splitOn "," v
            _ -> []

isHeaderRedirect :: R.ProcIMeta -> Bool
isHeaderRedirect m = case R.procIMetaStatusCode m of
    Just s  -> s `S.member` statusCodeRedirects
    Nothing -> False

isMetaNoFollow :: [Text] -> Bool
isMetaNoFollow metaRobots = "nofollow" `S.member` robots
    where
        robots = case listToMaybe metaRobots of
            Just v  -> S.fromList $ T.strip <$> T.splitOn "," v
            Nothing -> S.empty

normalizeLinks :: R.ProcIMeta -> Maybe URI.URIAbsolute -> [Text] -> [R.ProcOUrl]
normalizeLinks m base es =
    URI.URIReference . flip URI.relativeTo baseUrl <$>
        mapMaybe (URI.parseURIReference . toString) es
    where
        baseUrl = URI.unURIAbsolute $ fromMaybe (R.procIMetaUrl m) base

statusCodeRedirects :: S.Set Integer
statusCodeRedirects = S.fromList [301, 302, 303, 307, 308]
