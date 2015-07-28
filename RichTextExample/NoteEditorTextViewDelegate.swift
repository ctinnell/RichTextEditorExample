//
//  NoteEditorTextViewDelegate.swift
//  RichTextExample
//
//  Created by Clay Tinnell on 7/27/15.
//  Copyright (c) 2015 Clay Tinnell. All rights reserved.
//

import UIKit
import Foundation

class NoteEditorTextViewDelegate: NSObject {
    
    var maxTagLength = 0
    var tags: [String] {
        didSet {
            maxTagLength = 0
            for tag in tags {
                let countWords = count(tag.componentsSeparatedByWhiteSpace())
                maxTagLength = countWords > maxTagLength ? countWords : maxTagLength
            }
        }
    }
    
    override init() {
        tags = ["how are you", "you", "weather", "or cold"]
    }
    
    func isStringATag(text: String) -> (Bool, Int) {
        let tag = tags.filter({$0.lowercaseString == text})
        let isTag = count(tag) > 0
        var numberOfWords = 0
        
        if isTag {
            let components = text.componentsSeparatedByWhiteSpace()
            numberOfWords = count(components)
        }
        return (isTag,numberOfWords)
    }
}

extension NoteEditorTextViewDelegate : UITextViewDelegate {
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text.isAWordTerminator() {
            println(textView.text.stripSpecialCharacters().trimExtraWhiteSpace())
        }
        return true
    }
}

private extension String {
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



