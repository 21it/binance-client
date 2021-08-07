module BinanceClient.Data.Kind
  ( Method (..),
    CurrencyRelation (..),
  )
where

data Method
  = AvgPrice

data CurrencyRelation
  = Base
  | Quote
