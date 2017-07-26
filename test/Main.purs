module Test.Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Eff.Console as Console

import Data.Generic
import Data.Argonaut (class EncodeJson, class DecodeJson, encodeJson, decodeJson)
import Data.Argonaut.Parser (jsonParser)
import Data.Argonaut.Generic.Argonaut as Argonaut
import Data.Argonaut.Generic.Options as Argonaut
import Data.Argonaut.Core as Json
import Data.Argonaut.Core (Json, fromString)
import Data.Argonaut.Generic.Encode (genericEncodeJson)
import Data.Argonaut.Generic.Decode (genericDecodeJson, genericUserDecodeJson')

data Foo = Foo Bar
data Bar = Bar

derive instance genericFoo :: Generic Foo
derive instance genericBar :: Generic Bar

instance encodeJsonFoo :: EncodeJson Foo where
  encodeJson = genericEncodeJson Argonaut.options

instance encodeJsonBar :: EncodeJson Bar where
  encodeJson _ = fromString "yippie"

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = Console.log $ Json.stringify $ encodeJson $ Foo Bar
