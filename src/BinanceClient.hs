module BinanceClient (avgPrice) where

import BinanceClient.Import
import qualified BinanceClient.Rpc.Generic as GenericRpc

avgPrice :: MonadIO m => CurrencyPair -> ExceptT Error m ByteString
--ExchangeRate
avgPrice x = GenericRpc.pubGet (Rpc :: Rpc 'AvgPrice) [SomeQueryString x]
