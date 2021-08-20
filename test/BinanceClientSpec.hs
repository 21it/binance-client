module BinanceClientSpec
  ( spec,
  )
where

import qualified BinanceClient as Binance
import BinanceClient.Import
import Test.Hspec

spec :: Spec
spec = do
  it "AvgPrice succeeds" $ do
    x <- runExceptT . Binance.avgPrice $ CurrencyPair "ADA" "BTC"
    x `shouldSatisfy` isRight
  it "AvgPrice fails" $ do
    x <- runExceptT . Binance.avgPrice $ CurrencyPair "BTC" "BTC"
    x `shouldSatisfy` isLeft
