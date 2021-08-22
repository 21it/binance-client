module BinanceClient.Class.ToQueryParam
  ( ToQueryParam (..),
    SomeQueryParam (..),
  )
where

import BinanceClient.Data.Type
import BinanceClient.Import.External
import qualified Data.ByteString as BS

class ToQueryParam a where
  toQueryParam :: a -> (BS.ByteString, Maybe BS.ByteString)

data SomeQueryParam
  = forall a. ToQueryParam a => SomeQueryParam a

instance ToQueryParam CurrencyPair where
  toQueryParam x =
    ( "symbol",
      Just $
        encodeUtf8 (coerce $ currencyPairBase x :: Text)
          <> encodeUtf8 (coerce $ currencyPairQuote x :: Text)
    )

instance ToQueryParam SomeQueryParam where
  toQueryParam (SomeQueryParam x) = toQueryParam x
