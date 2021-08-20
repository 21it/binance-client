module BinanceClient.Class.ToQueryString
  ( ToQueryString (..),
    SomeQueryString (..),
  )
where

import BinanceClient.Data.Type
import BinanceClient.Import.External
import qualified Data.ByteString as BS

class ToQueryString a where
  toQueryString :: a -> (BS.ByteString, Maybe BS.ByteString)

data SomeQueryString
  = forall a. ToQueryString a => SomeQueryString a

instance ToQueryString CurrencyPair where
  toQueryString x =
    ( "symbol",
      Just $
        encodeUtf8 (coerce $ currencyPairBase x :: Text)
          <> encodeUtf8 (coerce $ currencyPairQuote x :: Text)
    )

instance ToQueryString SomeQueryString where
  toQueryString (SomeQueryString x) = toQueryString x
