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
    var tagParser: TagParser?
    
    // inHighlightMode forces an additional call to formatTextView in order to turn off the tag highlighting.
    var inHighlightMode = false
    
    override init() {
        self.tagParser = TagParser(tags: ["sunny", "day", "the weather", "happy", "how are you"])
    }
    
    private func formatTextView(textView: UITextView, tagList:[String]) {
        let lowercaseText = textView.text.lowercaseString
        var attributedText = NSMutableAttributedString(string: textView.text)
        
        inHighlightMode = false
        for tag in tagList {
            var range = NSRange(location: 0, length: attributedText.length)
            while (range.location != NSNotFound) {
                let tagPattern = "\\b\(tag)\\b" //regular expression - word boundary of tag
                range = (lowercaseText as NSString).rangeOfString(tagPattern, options: .RegularExpressionSearch, range: range)
                if (range.location != NSNotFound) {
                    attributedText.addAttributes([NSForegroundColorAttributeName: UIColor.blueColor(),
                                                  NSBackgroundColorAttributeName: UIColor.yellowColor(),
                                                             NSFontAttributeName: textView.font,
                                                   NSUnderlineStyleAttributeName: 1], range: range)
                    
                    // we are in highlight mode if the last word is a tag
                    if range.location + range.length == attributedText.length { inHighlightMode = true } else { inHighlightMode = false }
                        
                    range = NSRange(location: range.location + range.length, length: attributedText.length - (range.location + range.length))
                }
            }
        }
        textView.attributedText = attributedText
    }
}

extension NoteEditorTextViewDelegate : UITextViewDelegate {
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text.isAWordTerminator() || inHighlightMode {
            if let tagParser = tagParser,
                        tags = tagParser.parseTags(textView.text) {
                println(tags)
                formatTextView(textView, tagList: tags)
            }
        }
        return true
    }

}



