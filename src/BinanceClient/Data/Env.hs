module BinanceClient.Data.Env
  ( Env (..),
    newEnv,
  )
where

import BinanceClient.Data.Type
import BinanceClient.Import.External
import Env ((<=<), auto, header, help, keep, nonempty, parse, var)

data Env
  = Env
      { envApiKey :: ApiKey,
        envPrvKey :: PrvKey
      }

newEnv :: MonadIO m => m Env
newEnv =
  liftIO . parse (header "BinanceClient") $
    Env
      <$> var (auto <=< nonempty) "BINANCE_API_KEY" op
      <*> var (auto <=< nonempty) "BINANCE_PRV_KEY" op
  where
    op = keep <> help ""
