module Lib
    ( someFunc
    ) where
import Test.QuickCheck

someFunc :: IO ()
someFunc = generate (arbitrary:: Gen MyJson) >>= print

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
        let arbitrary' 0 =
                oneof [ pure MyNull
                      , MyBool <$> arbitrary
                      , MyString <$> arbitrary
                      , MyInt <$> arbitrary
                      ]
            arbitrary' i = 
                oneof [ pure MyNull
                      , MyBool <$> arbitrary
                      , MyString <$> arbitrary
                      , MyInt <$> arbitrary
                      , MyArray <$> resize (i `div` 2) arbitrary
                      , MyDict <$> resize (i `div` 2) arbitrary
                      ]
        in
            sized arbitrary'
