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
    
    func characterIsAWordTerminator(text: String) -> Bool {
        return text == " " || text == "." || text == "," || text == ":" || text == ";" || text == "\n" || text == "!" || text == "?"
    }
    
    func stripSpecialCharacters(text: String) -> [String]? {
        let strippedLowerCaseText = " ".join(text.componentsSeparatedByCharactersInSet(NSCharacterSet.letterCharacterSet().invertedSet)).lowercaseString
        let trimmedWhiteSpace = strippedLowerCaseText.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).filter({!isEmpty($0)})
        return trimmedWhiteSpace
    }
    
}

extension NoteEditorTextViewDelegate : UITextViewDelegate {
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        println("text changed: \(text)")
        if characterIsAWordTerminator(text) {
            println("word terminator")
            if let strippedText = stripSpecialCharacters(textView.text) {
                println(",".join(strippedText))
            }
        }
        return true
    }
}
