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
        if let tagParser = noteEditorTextFieldDelegate.tagParser {
            tagListTextField.text = ",".join(tagParser.tags)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController : UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == tagListTextField {
            if let tagParser = noteEditorTextFieldDelegate.tagParser {
                tagParser.tags = tagListTextField.text.componentsSeparatedByString(",")
                noteEditorTextFieldDelegate.formatTextView()
            }
        }
        return true
    }
}

