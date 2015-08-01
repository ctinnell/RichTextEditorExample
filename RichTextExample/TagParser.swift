//
//  TagParser.swift
//  RichTextExample
//
//  Created by Clay Tinnell on 7/30/15.
//  Copyright (c) 2015 Clay Tinnell. All rights reserved.
//

import UIKit

class TagParser: NSObject {
 
    var maxTagLength = 0
    var tags: [String] {
        didSet {
            configureMaxTagLength()
        }
    }
    
    init(tags: [String]) {
        self.tags = tags
    }
    
    private func configureMaxTagLength() {
        maxTagLength = 0
        for tag in tags {
            let countWords = tag.componentsSeparatedByWhiteSpace().count
            maxTagLength = countWords > maxTagLength ? countWords : maxTagLength
        }
    }
    
    private func isStringATag(text: String) -> (Bool, Int) {
        let tag = tags.filter({$0.lowercaseString == text})
        let isTag = count(tag) > 0
        var numberOfWords = 0
        
        if isTag {
            let components = text.componentsSeparatedByWhiteSpace()
            numberOfWords = count(components)
        }
        return (isTag,numberOfWords)
    }
    
    func parseTags(text: String) -> [String] {
        if maxTagLength == 0 { configureMaxTagLength() } //annoyance with didSet not called in init

        var matchedTags: [String] = []
        
        let strArray = text.stripSpecialCharacters().trimExtraWhiteSpace().componentsSeparatedByWhiteSpace()
        var tagMatches: [String] = []
        for (var outerCounter = 0; outerCounter<strArray.count; outerCounter++) {
            let word = strArray[outerCounter]
            let wordsRemaining = strArray.count - outerCounter
            let numberOfWordsToConsider = (wordsRemaining >= maxTagLength) ? maxTagLength : wordsRemaining
            
            var wordsToConsider: [String] = []
            for (var innerCounter = outerCounter; innerCounter<(outerCounter+numberOfWordsToConsider); innerCounter++) {
                wordsToConsider.append(strArray[innerCounter])
            }
            
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
        
        if tagMatches.count > 0 {
            matchedTags = tagMatches
        }
        
        return matchedTags
    }
}

extension String {
    func isAWordTerminator() -> Bool {
        return self == " " || self == "." || self == "," || self == ":" || self == ";" || self == "\n" || self == "!" || self == "?" || self == ""
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