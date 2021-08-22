module BinanceClient.Data.Kind
  ( Method (..),
    CurrencyRelation (..),
  )
where

data Method
  = AvgPrice
  | OrderTest

data CurrencyRelation
  = Base
  | Quote
