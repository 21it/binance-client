module BinanceClient.Class.ToPathPieces
  ( ToPathPieces (..),
  )
where

import BinanceClient.Data.Kind
import BinanceClient.Data.Type
import BinanceClient.Import.External

class ToPathPieces a where
  toPathPiece :: a -> [Text]

instance ToPathPieces (Rpc 'AvgPrice) where
  toPathPiece Rpc = ["avgPrice"]

instance ToPathPieces (Rpc 'OrderTest) where
  toPathPiece Rpc = ["order", "test"]
