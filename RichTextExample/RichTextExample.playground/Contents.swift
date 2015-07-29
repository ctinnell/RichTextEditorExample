//: Playground - noun: a place where people can play

import UIKit
import Foundation

var str = "Hello, playground, how are you doing today? Is the weather nice, hot, or cold?"

func stripSpecialCharacters(text: String) -> String {
    return " ".join(text.componentsSeparatedByCharactersInSet(NSCharacterSet.letterCharacterSet().invertedSet)).lowercaseString
}

func componentsSeparatedByWhiteSpace(text: String) -> [String] {
    return text.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
}

func trimExtraWhiteSpace(text: String) -> String {
    return " ".join(componentsSeparatedByWhiteSpace(text).filter({!$0.isEmpty}))
}

var maxTagLength = 0
var tags: [String]? {
    didSet {
        maxTagLength = 0
        for tag in tags! {
            let countWords = count(componentsSeparatedByWhiteSpace(tag))
            maxTagLength = countWords > maxTagLength ? countWords : maxTagLength
        }
    }
}



let strArray = componentsSeparatedByWhiteSpace(trimExtraWhiteSpace(stripSpecialCharacters(str)))

//new
func isStringATag(text: String) -> (Bool, Int) {
    let tag = tags!.filter({$0.lowercaseString == text})
    let isTag = count(tag) > 0
    var numberOfWords = 0
    
    if isTag {
        let components = componentsSeparatedByWhiteSpace(text)
        numberOfWords = count(components)
    }
    return (isTag,numberOfWords)
}

tags = ["how are you", "you", "weather", "or cold", "how are you doing"]
println(maxTagLength)
println(isStringATag("how are you doing today"))



for (var outerCounter = 0; outerCounter<strArray.count; outerCounter++) {
    let word = strArray[outerCounter]
    let wordsRemaining = strArray.count - outerCounter
    let numberOfWordsToConsider = (wordsRemaining >= maxTagLength) ? maxTagLength : wordsRemaining
    //build list of words to consider
    var wordsToConsider: [String] = []
    for (var innerCounter = outerCounter; innerCounter<(outerCounter+numberOfWordsToConsider); innerCounter++) {
        wordsToConsider.append(strArray[innerCounter])
    }
    
    println(wordsToConsider)
//    for (var innerCounter = 0; innerCounter<numberOfWordsToConsider; innerCounter++) {
//        
//        let (isTag, tagLength) =
//    }
    
}