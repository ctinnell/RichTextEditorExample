//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
var text = "Hello This Is A     Test   To see how THIS WORKS"

func stripSpecialCharacters(text: String) -> [String]? {
    let strippedLowerCaseText = " ".join(text.componentsSeparatedByCharactersInSet(NSCharacterSet.letterCharacterSet().invertedSet)).lowercaseString
//    let trimmedWhiteSpace = strippedLowerCaseText.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).filter({!isEmpty($0)})
    
    let trimmedWhiteSpace = strippedLowerCaseText.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    
    return trimmedWhiteSpace
}

stripSpecialCharacters(text)

