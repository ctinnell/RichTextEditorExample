//: Playground - noun: a place where people can play

import UIKit
import Foundation


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
var tagMatches: [String] = []
var tags: [String]? {
    didSet {
        maxTagLength = 0
        for tag in tags! {
            let countWords = count(componentsSeparatedByWhiteSpace(tag))
            maxTagLength = countWords > maxTagLength ? countWords : maxTagLength
        }
    }
}

var str = "Hello, playground, how are you doing today? Is the weather nice, hot, or cold?"
tags = ["how are you", "you", "weather", "how are you doing", "Hello"]

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


println(maxTagLength)

let strArray = componentsSeparatedByWhiteSpace(trimExtraWhiteSpace(stripSpecialCharacters(str)))
tagMatches = []
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
    
    var y = 0
    while wordsToConsider.count > 0 {
        let (isTag, wordCount) = isStringATag(" ".join(wordsToConsider))
        if isTag {
            tagMatches.append(" ".join(wordsToConsider))
            wordsToConsider.removeAll(keepCapacity: false)
            outerCounter = outerCounter + wordCount - 1
        }
        else {
            wordsToConsider.removeLast()
            y++
        }
    }
}

let finalMatches = tagMatches


























