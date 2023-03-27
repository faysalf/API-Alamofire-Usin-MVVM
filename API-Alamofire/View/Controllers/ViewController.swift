//
//  ViewController.swift
//  API-Alamofire
//
//  Created by Md. Faysal Ahmed on 21/3/23.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    // MARK: - Private Methods
    @IBOutlet weak var tableView: UITableView!
    
    var listGetPageNo = 2
    let singleGetPoint = "api/users/2"
    let singUserNotFound = "/api/users/23"  // 404
    var listGetPoint: String?
    let putPoint = "api/users/2"            // replace entire resources
    let postPoint = "api/users"             // Create
    let patchPoint = "api/users/2"          // replace a part of resources
    let deletePoint = "api/users/2"         // Delete
    let registerUnsuccessful = "/api/register"// 400
    let delayedResponse = "api/users?delay=3" // 200
    let loginSuccessful = "api/login"
    
    var dataSource = [UserInfo]()
    let httpMethods = HTTPMethodsCustomization()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableViewCell()
        httpMethods.delegate = self
        httpMethods.delegateS = self
        httpMethods.delegateLogin = self
    }
    
    func setupTableViewCell() {
        let nib = UINib(nibName: "CustomTableTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Button Actions
    @IBAction func singleGetAction(_ sender: UIButton) {
        httpMethods.singleMethodGet(endPoint: singleGetPoint)
    }
    
    @IBAction func listGetAction(_ sender: UIButton) {
        listGetPoint = "api/users?page=\(listGetPageNo)" ?? ""
        httpMethods.listMethodGet(endPoint: listGetPoint!)
    }
    
    @IBAction func patchAction(_ sender: UIButton) {
        httpMethods.patchMethod(endPoint: patchPoint)
    }
    
    @IBAction func postAction(_ sender: UIButton) {
        let user = PostModel(roll: 54, name: "Md. Faysal Ahmed", email: "mdfaysal@gmail.com", password: "mdfaysal")
        httpMethods.postMethod(endPoint: postPoint, parameter: user)
    }
    
    @IBAction func putButtonAction(_ sender: UIButton) {
        let param: [String: Any] = [
            "Email": "faysal.ahmed@reserveitbd.com",
            "Name": "Faysal Ahmed",
            "Password": "faysalf123"
        ]
        httpMethods.putMethod(endPoint: putPoint, parameter: param as NSDictionary)
    }
    
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        httpMethods.deleteMethod(endPoint: deletePoint)
    }
    
    @IBAction func singleUserNFAction(_ sender: UIButton) {
        httpMethods.singleMethodGet(endPoint: singUserNotFound)
    }
    
    @IBAction func registerUnsuccessfulAction(_ sender: UIButton) {
        let user = PostModel(roll: nil, name: "Faysal Ahmed", email: "mdfaysal@gmail.com", password: nil)
        httpMethods.postMethod(endPoint: registerUnsuccessful, parameter: user)
    }
    
    @IBAction func delayedResponseAction(_ sender: UIButton) {
        httpMethods.singleMethodGet(endPoint: delayedResponse)
    }
    
    @IBAction func loginSuccessfulAction(_ sender: UIButton) {
        let user = LoginPostModel(email: "eve.holt@reqres.in", password: "cityslicka")
        httpMethods.loginPostMethod(endPoint: loginSuccessful, parameter: user)
    }

    
}

// MARK: TableViewDelegate & TableViewDelegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath) as! CustomTableTableViewCell
        cell.configure(value: dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
}

// MARK: - Protocol Staff
extension ViewController: listValueTF, singleValueTF, loginToken {
    
    func dataForTransfer(value: SingleGetModel) {
        let val = value.data
        let user = UserInfo(img: val.avatar, id: val.id, name: val.firstName+val.lastName)
        self.dataSource = [user]
        
        self.tableView.reloadData()
    }
    
    func dataForTransfer(value: ListGetModel) {
        let num = value.data.count
        
        self.dataSource = [UserInfo]()
        
        for i in 0..<num {
            let val = value.data[i]
            let user = UserInfo(img: val.avatar, id: val.id, name: val.firstName+val.lastName)
            self.dataSource.append(user)
        }
        self.tableView.reloadData()
    }
    
    func token(value: LoginPostStatusModel) {
        print("Login Access Token:-", value.token!)
        
        UserDefaults.standard.set(value.token ?? "", forKey: "token")
        print("Saved Token:- \(UserDefaults.standard.string(forKey: "token") ?? "")")
    }
  
    
}


