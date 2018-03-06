//
//  LandingSceneVCViewController.swift
//  ProjectWLT
//
//  Created by Saleh Masum on 3/6/18.
//  Copyright (c) 2018 Selise. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol LandingSceneVCDisplayLogic: class
{
  func displaySomething(viewModel: LandingSceneVC.Something.ViewModel)
  func displayUserInformation(viewModel: LandingSceneVC.UserDetail.ViewModel)
}

class LandingSceneViewController: UIViewController, LandingSceneVCDisplayLogic
{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var lastNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    
    
  var interactor: LandingSceneVCBusinessLogic?
  var router: (NSObjectProtocol & LandingSceneVCRoutingLogic & LandingSceneVCDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = LandingSceneVCInteractor()
    let presenter = LandingSceneVCPresenter()
    let router = LandingSceneVCRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    doSomething()
    showRequestForUserInformation()
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
  
  func doSomething()
  {
    let request = LandingSceneVC.Something.Request()
    interactor?.doSomething(request: request)
  }
  
  func showRequestForUserInformation()
  {
    interactor?.showRequestForUserInformation()
  }
    
  func displaySomething(viewModel: LandingSceneVC.Something.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
   
  func displayUserInformation(viewModel: LandingSceneVC.UserDetail.ViewModel)
  {
    print("\(viewModel.userInfo)")
    self.firstNameLbl.text = viewModel.userInfo.firstName
    self.lastNameLbl.text  = viewModel.userInfo.lastName
    self.emailLbl.text     = viewModel.userInfo.email
    
    
  }
  //  //  //
}