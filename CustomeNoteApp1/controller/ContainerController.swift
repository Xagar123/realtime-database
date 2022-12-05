//
//  ContainerController.swift
//  CustomeNoteApp1
//
//  Created by Admin on 27/11/22.
//

import UIKit

class ContainerController: UITableViewController, HomeControllerDelegate {

    
    var delegate:ContainerController!
    var isExpended = false
    var menuController: MenuController!
    var centerController: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureHomeController()
        
    }
    
    func configureHomeController(){
        let homeController = HomeController()
        homeController.delegate = self
        centerController = UINavigationController(rootViewController: homeController)
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }

    func handleMenuToggle(forMenuOption menuOption: MenuOption?) {
        if !isExpended {
            configureMenuController()
        }
        
        isExpended = !isExpended
        animatePanelController(shouldExpand: isExpended, menuOption: menuOption)
    }
    
    func configureMenuController(){
        if menuController == nil {
            //add our menu controller here
            menuController = MenuController()
            menuController.delegate = self
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
            print("did add menu controller")
        }
    }
    
    
    func animatePanelController(shouldExpand: Bool, menuOption: MenuOption?){
        if shouldExpand{
            //show menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0,options: .curveEaseOut) {
                
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80
            }
        }else{
            //hide menu
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0,options: .curveEaseOut) {
//
//
//            }
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0,options: .curveEaseOut) {
                self.centerController.view.frame.origin.x = 0
            }completion: { (_ ) in
                guard let menuOption = menuOption else {return}
                self.didSelectMenuOption(menuOption: menuOption)
            }
        }
        animateStatusBar()
    }
    
    
    func animateStatusBar(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0,options: .curveEaseOut) {
            
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    func didSelectMenuOption(menuOption: MenuOption){
        switch menuOption{
            
        case .Home:
            print("Navigatae to home")
        case .Language:
            print("navigate to language page")
        case .Download:
            print("Navigate to download page")
        case .Setting:
            print("navigate to Setting page")
        }
    }
    
   
    
    // MARK: - Table view data source

   

}
