module BinanceClient.Rpc.Generic (pubGet) where

import BinanceClient.Import
import qualified Data.Text as T
import qualified Network.HTTP.Client as Http
import qualified Network.HTTP.Client.TLS as Tls

--import qualified Network.HTTP.Types.Status as Http

baseUrl :: Text
baseUrl = "https://api.binance.com/api/v3"

pubGet ::
  ( ToPathPiece (Rpc (a :: Method)),
    MonadIO m
  ) =>
  Rpc (a :: Method) ->
  [SomeQueryString] ->
  ExceptT Error m ByteString
pubGet rpc qs =
  ExceptT . liftIO $
    this
      `catch` (\(x :: Http.HttpException) -> pure . Left $ ErrorHttp x)
  where
    this = do
      manager <-
        Http.newManager Tls.tlsManagerSettings
      req <-
        Http.parseRequest
          . T.unpack
          $ baseUrl <> "/" <> toPathPiece rpc
      res <-
        Http.httpLbs
          (Http.setQueryString (toQueryString <$> qs) req)
          manager
      let body = Http.responseBody res
      pure $ Right body
