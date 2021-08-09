module BinanceClient.Data.Type
  ( LogFormat (..),
    CurrencyCode (..),
    CurrencyPair (..),
    Rpc (..),
    Error (..),
  )
where

import BinanceClient.Data.Kind
import BinanceClient.Import.External

data LogFormat
  = Bracket
  | Json
  deriving (Eq, Ord, Show, Read)

newtype CurrencyCode (a :: CurrencyRelation)
  = CurrencyCode Text
  deriving newtype (Eq, Ord, Show, Read, IsString)

data CurrencyPair
  = CurrencyPair
      { currencyPairBase :: CurrencyCode 'Base,
        currencyPairQuote :: CurrencyCode 'Quote
      }
  deriving (Eq, Ord, Show, Read)

data Rpc (method :: Method)
  = Rpc

newtype Error
  = ErrorHttp HttpException
  deriving (Show)
