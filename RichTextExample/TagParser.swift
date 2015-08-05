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
    
    private func matchedTags(text: String) -> [String] {
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
    
    private func locationForTagsInText(tagList: [String], text: String) -> [NSRange] {
        var ranges: [NSRange] = []
        for tag in tagList {
            var range = NSRange(location: 0, length: count(text))
            while (range.location != NSNotFound) {
                let tagPattern = "\\b\(tag)\\b" //regular expression - word boundary of tag
                range = (text.lowercaseString as NSString).rangeOfString(tagPattern, options: .RegularExpressionSearch, range: range)
                if (range.location != NSNotFound) {
                    ranges.append(range)
                    range = NSRange(location: range.location + range.length, length: count(text) - (range.location + range.length))
                }
            }
        }
        return ranges
    }
    
    func parseTags(text: String) -> ([String], [NSRange]) {
        let matchedTags = self.matchedTags(text)
        let tagLocations = self.locationForTagsInText(matchedTags, text: text)
        return (matchedTags, tagLocations)
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