module Lib
    ( someFunc
    ) where
import Test.QuickCheck

someFunc :: IO ()
someFunc = putStrLn "someFunc"

data MyJson =
      MyNull
    | MyBool Bool
    | MyString String
    | MyInt Int
    | MyArray [MyJson]
    | MyDict [(String,MyJson)]
    deriving (Show,Eq)
instance Arbitrary MyJson where
    arbitrary =
        oneof [
            return MyNull,
            MyBool <$> arbitrary,
            MyString <$> arbitrary,
            MyInt <$> arbitrary,
            MyArray <$> arbitrary,
            MyDict <$> arbitrary
        ]
