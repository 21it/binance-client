module BinanceClient (avgPrice) where

import BinanceClient.Import
import qualified BinanceClient.Rpc.Generic as GenericRpc

avgPrice :: MonadIO m => CurrencyPair -> ExceptT Error m SomeExchangeRate
--ExchangeRate
avgPrice x =
  GenericRpc.pubGet rpc [SomeQueryString x] >>= except . fromRpc rpc x
  where
    rpc = Rpc :: Rpc 'AvgPrice
