module BinanceClient.Class.FromRpc
  ( FromRpc (..),
    parseRational,
  )
where

import BinanceClient.Data.Kind
import BinanceClient.Data.Type
import BinanceClient.Import.External
import qualified Data.Aeson as A
import qualified Data.Aeson.Types as A
import qualified Data.Text as T

class FromRpc (method :: Method) req res where
  fromRpc :: Rpc method -> req -> ByteString -> Either Error res

instance FromRpc 'AvgPrice CurrencyPair SomeExchangeRate where
  fromRpc Rpc req raw = do
    obj <- fstError $ A.eitherDecode raw
    rawPrice <- fstError $ A.parseEither parser obj
    price <- parseRational rawPrice
    first ErrorFromRpc
      . maybeToRight "AvgPrice WrongExchangeRate"
      $ mkSomeExchangeRate
        (coerce $ currencyPairBase req)
        (coerce $ currencyPairQuote req)
        price
    where
      parser = A.withObject "AvgPrice" (A..: "price")
      fstError = first $ ErrorFromRpc . T.pack

instance FromRpc 'OrderTest CurrencyPair SomeExchangeRate where
  fromRpc Rpc req raw = do
    obj <- fstError $ A.eitherDecode raw
    rawPrice <- fstError $ A.parseEither parser obj
    price <- parseRational rawPrice
    first ErrorFromRpc
      . maybeToRight "AvgPrice WrongExchangeRate"
      $ mkSomeExchangeRate
        (coerce $ currencyPairBase req)
        (coerce $ currencyPairQuote req)
        price
    where
      parser = A.withObject "AvgPrice" (A..: "price")
      fstError = first $ ErrorFromRpc . T.pack

parseRational :: Text -> Either Error Rational
parseRational raw =
  case rational $ strip raw of
    Right (success, "") ->
      Right success
    Right (_, rem0) ->
      Left . ErrorFromRpc $ "Unexpected rem " <> rem0 <> " from " <> raw
    Left e ->
      Left . ErrorFromRpc $ T.pack e
