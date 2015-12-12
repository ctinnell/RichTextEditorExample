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
    
    func formatTextView() {
        let cursorLocation = textView.selectedRange

        //let lowercaseText = textView.text.lowercaseString
        let attributedText = NSMutableAttributedString(string: textView.text)
        
        if let tagParser = tagParser {
            let (tags, locations) = tagParser.parseTags(textView.text)
            for location in locations {
                attributedText.addAttributes([NSForegroundColorAttributeName: UIColor.blueColor(),
                    NSBackgroundColorAttributeName: UIColor.yellowColor(),
                    NSFontAttributeName: textView.font!,
                    NSUnderlineStyleAttributeName: 1], range: location)
            }
        }
        
        textView.attributedText = attributedText

        //This is necessary, because cursor position is sent to end of document when editing in the middle of the text field
        //as a side-effect of setting attributed text.
        textView.selectedRange = cursorLocation
    }
}

extension NoteEditorTextViewDelegate : UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        formatTextView()
    }
}



