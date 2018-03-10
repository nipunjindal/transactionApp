//
//  ViewController.swift
//  expenseSharingApp
//
//  Created by njindal on 3/10/18.
//  Copyright © 2018 adobe. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userExpense: UILabel!
    @IBOutlet weak var tableVIew: UITableView!
    
    var objectArray = [PaidInfo]()

    fileprivate func reload() {
        DispatchQueue.main.async {[weak self] in
            self?.tableVIew.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        userName.text = FKTestModel.shared.userName
        userExpense.text = String.init(format: "%f", FKTestModel.shared.paidInfo[FKTestModel.shared.userName]!)
        
        for (key, value) in FKTestModel.shared.paidInfo {
            objectArray.append(PaidInfo.init(user: key, value: value))
        }

        // Do any additional setup after loading the view.
        tableVIew.dataSource = self
        tableVIew.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func handleTransaction(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "TransactionViewController") as! TranscationViewController
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableIdentifier", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = objectArray[indexPath.row].user
        cell.detailTextLabel?.text = objectArray[indexPath.row].value.toString()
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController: TransactionControllerDelegate {
    func didDismiss() {
        objectArray = [PaidInfo]()
        for (key, value) in FKTestModel.shared.paidInfo {
            objectArray.append(PaidInfo.init(user: key, value: value))
        }
        self.reload()
    }
}
