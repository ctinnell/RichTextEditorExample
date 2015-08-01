import UIKit
import Foundation


extension String {
    func isAWordTerminator() -> Bool {
        return self == " " || self == "." || self == "," || self == ":" || self == ";" || self == "\n" || self == "!" || self == "?"
    }
    
    func stripSpecialCharacters() -> String {
        return " ".join(self.componentsSeparatedByCharactersInSet(NSCharacterSet.letterCharacterSet().invertedSet)).lowercaseString
    }
    
    func componentsSeparatedByWhiteSpace() -> [String] {
        return self.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    func trimExtraWhiteSpace() -> String {
        return " ".join(self.componentsSeparatedByWhiteSpace().filter({!$0.isEmpty}))
    }
}

var maxTagLength = 0
var tagMatches: [String] = []
var tags: [String]? {
    didSet {
        maxTagLength = 0
        for tag in tags! {
            let countWords = tag.componentsSeparatedByWhiteSpace().count
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
        let components = text.componentsSeparatedByWhiteSpace()
        numberOfWords = count(components)
    }
    return (isTag,numberOfWords)
}


println(maxTagLength)


let strArray = str.stripSpecialCharacters().trimExtraWhiteSpace().componentsSeparatedByWhiteSpace()
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



























