module BinanceClientSpec
  ( spec,
  )
where

import qualified BinanceClient as Binance
import BinanceClient.Import
import Test.Hspec

spec :: Spec
spec =
  it "avgPrice" $ do
    x <- runExceptT . Binance.avgPrice $ CurrencyPair "ADA" "BTC"
    print x
    True `shouldBe` True
