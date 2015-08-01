//
//  ViewController.swift
//  RichTextExample
//
//  Created by Clay Tinnell on 7/27/15.
//  Copyright (c) 2015 Clay Tinnell. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var tagListTextField: UITextField!
    @IBOutlet var noteEditorTextFieldDelegate: NoteEditorTextViewDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        tagListTextField.addTarget(self, action: "tagTextFieldChanged:", forControlEvents: UIControlEvents.EditingChanged)
        if let tagParser = noteEditorTextFieldDelegate.tagParser {
            tagListTextField.text = ",".join(tagParser.tags)
        }
        
    }
    
    func tagTextFieldChanged(sender:UITextField) {
        if let tagParser = noteEditorTextFieldDelegate.tagParser {
            tagParser.tags = tagListTextField.text.componentsSeparatedByString(",")
            noteEditorTextFieldDelegate.formatTextView()
        }
    }
}