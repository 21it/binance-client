{-# LANGUAGE GADTs #-}

module BinanceClient.Rpc.Generic
  ( pubGet,
    prvPost,
  )
where

import BinanceClient.Import
import qualified Data.Text as T
import qualified Network.HTTP.Client as Web
import qualified Network.HTTP.Client.TLS as Tls
import qualified Network.HTTP.Types as Web

baseUrl :: Text
baseUrl = "https://api.binance.com/api/v3"

catchWeb ::
  (MonadIO m) =>
  IO (Either Error a) ->
  ExceptT Error m a
catchWeb this =
  ExceptT . liftIO $
    this
      `catch` (\(x :: HttpException) -> pure . Left $ ErrorWebException x)

pubGet ::
  ( MonadIO m,
    ToPathPieces rpc,
    FromRpc method req res,
    rpc ~ Rpc method
  ) =>
  rpc ->
  req ->
  [SomeQueryParam] ->
  ExceptT Error m res
pubGet rpc req qs = catchWeb $ do
  manager <-
    Web.newManager Tls.tlsManagerSettings
  webReq <-
    Web.parseRequest
      . T.unpack
      . T.intercalate "/"
      $ baseUrl : toPathPiece rpc
  webRes <-
    Web.httpLbs
      (Web.setQueryString (toQueryParam <$> qs) webReq)
      manager
  pure $
    if Web.responseStatus webRes == Web.ok200
      then fromRpc rpc req $ Web.responseBody webRes
      else Left $ ErrorWebResponse webRes

prvPost ::
  ( MonadIO m,
    ToPathPieces rpc,
    FromRpc method req res,
    rpc ~ Rpc method
  ) =>
  rpc ->
  req ->
  [SomeQueryParam] ->
  ExceptT Error m res
prvPost rpc req qs = catchWeb $ do
  manager <-
    Web.newManager Tls.tlsManagerSettings
  webReq <-
    Web.parseRequest
      . T.unpack
      . T.intercalate "/"
      $ baseUrl : toPathPiece rpc
  webRes <-
    Web.httpLbs
      ( webReq
          { Web.method = "POST",
            Web.requestBody = Web.RequestBodyBS query
          }
      )
      manager
  pure $
    if Web.responseStatus webRes == Web.ok200
      then fromRpc rpc req $ Web.responseBody webRes
      else Left $ ErrorWebResponse webRes
  where
    query = Web.renderQuery False $ toQueryParam <$> qs
