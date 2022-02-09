module Isoxya.Plugin.CrawlerHTML.Parser (parse) where


import qualified Data.Map                           as M
import qualified Data.Set                           as S
import qualified Data.Text                          as T
import           Network.URI
import           Text.HandsomeSoup
import           Text.XML.HXT.Core
import           TiredPixel.Common.Isoxya.Processor
import           TiredPixel.Common.URI


parse :: ProcessorI -> S.Set ProcessorOURL
parse rx = S.fromList $ normalizeLinks m base links
    where
        m = processorIMeta rx
        h = processorIHeader rx
        b = processorIBody rx
        body = fromRight "" $ decodeUtf8' b
        doc p = runLA (hread >>> p) $ toString body
        base = URIAbsolute <$> (parseAbsoluteURI =<< listToMaybe (
            doc $ css "base" ! "href"))
        pageLinks = doc $ css "a" >>> neg (css "a[rel~=\"nofollow\"]") ! "href"
        metaRobots = doc $ css "meta[name=\"robots\"]" ! "content"
        links
            | isHeaderRedirect m = maybeToList $ M.lookup "Location" h
            | isHeaderNoFollow h = []
            | isMetaNoFollow (toText <$> metaRobots) = []
            | otherwise = toText <$> pageLinks


isHeaderNoFollow :: ProcessorIHeader -> Bool
isHeaderNoFollow h = "nofollow" `S.member` robots
    where
        robots = case M.lookup "X-Robots-Tag" h of
            Just v  -> S.fromList $ T.strip <$> splitTag v
            Nothing -> S.empty
        splitTag t = case T.breakOnEnd ":" t of
            ("", v) -> T.splitOn "," v
            _       -> []

isHeaderRedirect :: ProcessorIMeta -> Bool
isHeaderRedirect m = case processorIMetaStatus m of
    Just s  -> s `S.member` statusRedirects
    Nothing -> False

isMetaNoFollow :: [Text] -> Bool
isMetaNoFollow metaRobots = "nofollow" `S.member` robots
    where
        robots = case listToMaybe metaRobots of
            Just v  -> S.fromList $ T.strip <$> T.splitOn "," v
            Nothing -> S.empty

normalizeLinks :: ProcessorIMeta -> Maybe URIAbsolute -> [Text] ->
    [ProcessorOURL]
normalizeLinks m base es =
    URIReference . flip relativeTo baseURL <$>
        mapMaybe (parseURIReference . toString) es
    where
        baseURL = unURIAbsolute $ fromMaybe (processorIMetaURL m) base

statusRedirects :: S.Set Integer
statusRedirects = S.fromList [301, 302, 303, 307, 308]
