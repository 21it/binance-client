module BinanceClient.Class.FromRpc
  ( FromRpc (..),
  )
where

import BinanceClient.Data.Kind
import BinanceClient.Data.Type
import BinanceClient.Import.External
import qualified Data.Aeson as A
import qualified Data.Aeson.Types as A
import qualified Data.Text as T

class FromRpc (method :: Method) req res where
  fromRpc :: Rpc method -> req -> ByteString -> Either Text res

instance FromRpc 'AvgPrice CurrencyPair SomeExchangeRate where
  --
  -- TODO : !!!
  --
  fromRpc Rpc req raw = do
    obj <- first T.pack $ A.eitherDecode raw
    price <- first T.pack $ A.parseEither parser obj
    maybeToRight "AvgPrice WrongExchangeRate" $
      mkSomeExchangeRate
        (coerce $ currencyPairBase req)
        (coerce $ currencyPairQuote req)
        price
    where
      parser =
        A.withObject "AvgPrice" (A..: "price")
