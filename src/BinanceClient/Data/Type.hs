module BinanceClient.Data.Type
  ( LogFormat (..),
    CurrencyCode (..),
    CurrencyPair (..),
    Rpc (..),
    Error (..),
    PrvKey (..),
    ApiKey (..),
  )
where

import BinanceClient.Data.Kind
import BinanceClient.Import.External
import qualified Network.HTTP.Client as Web
import qualified Prelude

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

data Error
  = ErrorWebException HttpException
  | ErrorWebResponse (Web.Response ByteString)
  | ErrorFromRpc Text
  deriving (Show)

newtype PrvKey
  = PrvKey Text
  deriving (Eq, Ord, Read, IsString)

instance Prelude.Show PrvKey where
  show = const "SECRET"

newtype ApiKey
  = ApiKey Text
  deriving (Eq, Ord, Read, IsString)

instance Prelude.Show ApiKey where
  show = const "SECRET"
