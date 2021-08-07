module BinanceClient.Class.FromRpc
  ( FromRpc (..),
  )
where

import BinanceClient.Data.Kind
import BinanceClient.Data.Type
import BinanceClient.Import.External

class FromRpc (method :: Method) req res where
  fromRpc :: Rpc method -> req -> ByteString -> res

instance FromRpc 'AvgPrice CurrencyPair ExchangeRate where
  --
  -- TODO : !!!
  --
  fromRpc Rpc req _ = ExchangeRate req 0
