module BinanceClient (avgPrice) where

import BinanceClient.Import
import qualified BinanceClient.Rpc.Generic as GenericRpc

avgPrice :: MonadIO m => CurrencyPair -> ExceptT Error m SomeExchangeRate
avgPrice x = GenericRpc.pubGet (Rpc :: Rpc 'AvgPrice) x [SomeQueryString x]
