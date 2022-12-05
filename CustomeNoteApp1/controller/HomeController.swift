//
//  HomeController.swift
//  Side Menu Bar prog
//
//  Created by Admin on 25/11/22.
//

import UIKit
import FirebaseCore
import Firebase
import FirebaseDatabase

struct Item {
    var title: String = ""
    var note: String = ""
    var id: String = ""
}

class HomeController: UITableViewController {
    

    var dbReference = DatabaseReference()
    var delegate:HomeControllerDelegate!
    
    var itemArray = [Item]()
    var textField:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        //view.backgroundColor = .gray
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        dbReference = Database.database().reference().child("Note")
        retrievingDataFromDB()
//        var newItem = Item()
//        newItem.title = "hello"
//        newItem.note = "world"
//        //self.itemArray.append((title:newItem, note:newItem))
//        self.itemArray.append(newItem)
        
        self.navigationItem.title = "Note Data"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddContact))
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    @objc func handleAddContact(){
        let controller = NoteViewController()
        controller.delegate = self
        self.present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
        print("item added")
//        let vc = storyboard?.instantiateViewController(identifier: "NoteViewController") as! NoteViewController
//        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func retrievingDataFromDB(){
        dbReference.observe(.value, with: { snapshot in
            if snapshot.childrenCount > 0 // it means we have some data in firebase so it will fetch all data
            {
                self.itemArray.removeAll()
                // we will run a loop
                for itemlist in snapshot.children.allObjects as! [DataSnapshot]
                {
                    let noteObject = itemlist.value as? [String: AnyObject]
                    let noteID = noteObject?["id"]
                    print("id \(noteID)")
                    let noteTitle = noteObject?["NoteHeading"]
                    
                    //creating item model
                    let newitemlists = Item(title:noteTitle as! String? ?? "" , id: noteID as! String )
                        self.itemArray.append(newitemlists)
                }
                print("list loaded")
                self.tableView.reloadData()
            }
        })
    }

    func configureNavigationBar(){
        print("navigation bar")
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.barStyle = .black
        navigationItem.title = "Side Menu"
        var menubtn = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .done, target: self, action: #selector(handleMenuToggle))
        self.navigationItem.leftBarButtonItem = menubtn
        menubtn.tintColor = UIColor.black
    }
    @objc func handleMenuToggle(){
        print("menu button clicked")
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    

    

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title as? String
        cell.detailTextLabel?.text = itemArray[indexPath.row].note as? String
        cell.imageView?.tintColor = .systemGreen
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let controller = UpdateViewController()
//        controller.delegate = self
//        self.present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
      
        let currentNote = itemArray[indexPath.row]
        let alert = UIAlertController(title: currentNote.title, message: "Give new value to update", preferredStyle: .alert)
        //we required two ation one for update and other for delete
        
        
        let updateAction = UIAlertAction(title: "Update", style: .default){ [self]_ in
            let id = currentNote.id
            let name = alert.textFields?[0].text
          //  let note = alert.textFields?[1].text
            updateItem(id: id, name: name!)
            tableView.reloadData()
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default){_ in
            self.deleteItem(id: currentNote.id)
        }
        //adding text field
        

        alert.addTextField { textField in
            textField.text = currentNote.title
            
        }
        
        alert.addAction(updateAction)
        alert.addAction(deleteAction)
        
        present(alert, animated: true, completion: nil)
    }
    func deleteItem(id: String){
        dbReference.child(id).setValue(nil)
    }
    func updateItem(id: String, name:String){
        let newItem = [
            "id": id,
            "NoteHeading":name
        ]
        dbReference.child(id).setValue(newItem)
        print("item updated")
    }

}

extension HomeController: AddContactDelegate{
    func addContact(item: Item) {
        self.dismiss(animated: true) {
           
        }
    }
}
