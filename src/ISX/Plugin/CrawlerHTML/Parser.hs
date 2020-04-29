module ISX.Plugin.CrawlerHTML.Parser (parse) where


import              Text.HandsomeSoup
import              Text.XML.HXT.Core
import qualified    Data.Map                                as  M
import qualified    Data.Set                                as  S
import qualified    Data.Text                               as  T
import qualified    Network.URI                             as  URI
import qualified    PVK.Com.API.Ext.URI                     as  URI
import qualified    PVK.Com.API.Resource.ISXPick            as  R


parse :: R.Rock -> S.Set R.OreUrl
parse rock = S.fromList $ normalizeLinks m base links
    where
        m = R.rockMeta rock
        h = R.rockHeader rock
        b = R.rockBody rock
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


isHeaderNoFollow :: R.RockHeader -> Bool
isHeaderNoFollow h = "nofollow" `S.member` robots
    where
        robots = case M.lookup "X-Robots-Tag" h of
            Just v  -> S.fromList $ T.strip <$> splitTag v
            Nothing -> S.empty
        splitTag t = case T.breakOnEnd ":" t of
            ("", v) -> T.splitOn "," v
            _ -> []

isHeaderRedirect :: R.RockMeta -> Bool
isHeaderRedirect m = case R.rockMetaStatusCode m of
    Just s  -> s `S.member` statusCodeRedirects
    Nothing -> False

isMetaNoFollow :: [Text] -> Bool
isMetaNoFollow metaRobots = "nofollow" `S.member` robots
    where
        robots = case listToMaybe metaRobots of
            Just v  -> S.fromList $ T.strip <$> T.splitOn "," v
            Nothing -> S.empty

normalizeLinks :: R.RockMeta -> Maybe URI.URIAbsolute -> [Text] -> [R.OreUrl]
normalizeLinks m base es =
    URI.URIReference . flip URI.relativeTo baseUrl <$>
        mapMaybe (URI.parseURIReference . toString) es
    where
        baseUrl = URI.unURIAbsolute $ fromMaybe (R.rockMetaUrl m) base

statusCodeRedirects :: S.Set Integer
statusCodeRedirects = S.fromList [301, 302, 303, 307, 308]
