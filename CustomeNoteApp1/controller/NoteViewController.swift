//
//  NoteViewController.swift
//  CustomeNoteApp1
//
//  Created by Admin on 28/11/22.
//

import UIKit
import FirebaseCore
//import Firebase
import FirebaseDatabase

protocol AddContactDelegate {
    func addContact(item: Item)
}

class NoteViewController: UIViewController {
    
    var dbReference = DatabaseReference()

    var delegate: AddContactDelegate?
    
    let textField: UITextField = {
        let name = UITextField()
        name.placeholder = "Enter here"
        name.textAlignment = .center
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
  //  @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var fieldView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dbReference = Database.database().reference().child("Note")
        
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSaveButton))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancelButton))
        view.addSubview(textField)
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textField.widthAnchor.constraint(equalToConstant: view.frame.width - 64).isActive = true
        textField.becomeFirstResponder()
    }
    
    @objc func handleSaveButton(){
        
        guard let fullName = textField.text, textField.hasText else {
            print("Handle error")
            return}
        guard  let id = dbReference.childByAutoId().key else {return}
        let item = Item(title: textField.text!, id: id)
        print(item.title)
        
        //delegate?.addContact(item: item, id: <#T##Item#>)
        let note = [ "id": id,
                     "NoteHeading": textField.text! as String
        ]
        dbReference.child(id).setValue(note)
        delegate?.addContact(item: item)
    }
    
    
    
    @objc func handleCancelButton(){
        self.dismiss(animated: true,completion: nil)
    }


}
