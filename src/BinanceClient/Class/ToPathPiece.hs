module BinanceClient.Class.ToPathPiece
  ( ToPathPiece (..),
  )
where

import BinanceClient.Data.Kind
import BinanceClient.Data.Type
import BinanceClient.Import.External

class ToPathPiece a where
  toPathPiece :: a -> Text

instance ToPathPiece (Rpc 'AvgPrice) where
  toPathPiece Rpc = "avgPrice"
