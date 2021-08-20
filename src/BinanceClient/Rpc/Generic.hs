{-# LANGUAGE GADTs #-}

module BinanceClient.Rpc.Generic
  ( pubGet,
  )
where

import BinanceClient.Import
import qualified Data.Text as T
import qualified Network.HTTP.Client as Web
import qualified Network.HTTP.Client.TLS as Tls
import qualified Network.HTTP.Types.Status as Web

baseUrl :: Text
baseUrl = "https://api.binance.com/api/v3"

pubGet ::
  ( MonadIO m,
    ToPathPiece rpc,
    FromRpc method req res,
    rpc ~ Rpc method
  ) =>
  rpc ->
  req ->
  [SomeQueryString] ->
  ExceptT Error m res
pubGet rpc req qs =
  ExceptT . liftIO $
    this
      `catch` (\(x :: HttpException) -> pure . Left $ ErrorWebException x)
  where
    this = do
      manager <-
        Web.newManager Tls.tlsManagerSettings
      webReq <-
        Web.parseRequest
          . T.unpack
          $ baseUrl <> "/" <> toPathPiece rpc
      webRes <-
        Web.httpLbs
          (Web.setQueryString (toQueryString <$> qs) webReq)
          manager
      pure $
        if Web.responseStatus webRes == Web.ok200
          then fromRpc rpc req $ Web.responseBody webRes
          else Left $ ErrorWebResponse webRes
