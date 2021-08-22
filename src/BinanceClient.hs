module BinanceClient
  ( avgPrice,
    orderTest,
  )
where

import BinanceClient.Import
import qualified BinanceClient.Rpc.Generic as GenericRpc

avgPrice ::
  MonadIO m =>
  CurrencyPair ->
  ExceptT Error m SomeExchangeRate
avgPrice x =
  GenericRpc.pubGet
    (Rpc :: Rpc 'AvgPrice)
    x
    [SomeQueryParam x]

orderTest ::
  MonadIO m =>
  CurrencyPair ->
  ExceptT Error m SomeExchangeRate
orderTest x =
  GenericRpc.prvPost
    (Rpc :: Rpc 'OrderTest)
    x
    [SomeQueryParam x]
