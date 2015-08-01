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
    
    @IBOutlet var textView: UITextView!
    
    override init() {
        self.tagParser = TagParser(tags: ["sunny", "day", "the weather", "happy", "how are you"])
    }
    
    private func formatTextView(tagList:[String]) {
        let cursorLocation = textView.selectedRange

        let lowercaseText = textView.text.lowercaseString
        var attributedText = NSMutableAttributedString(string: textView.text)
        
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
                                            
                    range = NSRange(location: range.location + range.length, length: attributedText.length - (range.location + range.length))
                }
            }
        }
        textView.attributedText = attributedText

        //This is necessary, because cursor position is sent to end of document when editing in the middle of the text field
        //as a side-effect of setting attributed text.
        textView.selectedRange = cursorLocation
    }
    
    func formatTextView() {
        var tagMatches: [String] = []
        if let tagParser = tagParser {
            tagMatches = tagParser.parseTags(textView.text)
        }
        formatTextView(tagMatches)
    }
}

extension NoteEditorTextViewDelegate : UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        formatTextView()
    }
}



