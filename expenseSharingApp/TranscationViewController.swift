//
//  TranscationViewController.swift
//  expenseSharingApp
//
//  Created by njindal on 3/10/18.
//  Copyright © 2018 adobe. All rights reserved.
//

import UIKit

protocol TransactionControllerDelegate: NSObjectProtocol {
    func didDismiss()
}

class TranscationViewController: UIViewController {

    weak var delegate: TransactionControllerDelegate?
    var userList = [ParticipantInfo]()
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate func reload() {
        DispatchQueue.main.async {[weak self] in
            self?.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "contact" {
            let controller = segue.destination as! ContactTableViewController
            controller.delegate = self
        }
    }
    
    @IBAction func handleBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func handleAddParticipant(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ContactViewController") as! ContactTableViewController
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func handleAddTransaction(_ sender: Any) {
        ExpenseHelper.addToFKModel(infos: userList)
        delegate?.didDismiss()
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension TranscationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "participantInfo", for: indexPath) as! CustomTableViewCell
        
        // Configure the cell...
        cell.id = indexPath.row
        cell.userName.text = userList[indexPath.row].name
        cell.delegate = self
        return cell
    }
}

extension TranscationViewController: UITableViewDelegate {
    
}

extension TranscationViewController: ContactSelected {
    func addContact(name: String) {
        userList.append(ParticipantInfo.init(name: name, paid: 0.0, share: 0.0))
        reload()
    }
}

extension TranscationViewController: InfoAddedHandler {
    func remove(id: Int) {
        userList.remove(at: id)
        reload()
    }
    
    func changePaidAmount(id: Int, amout: CGFloat) {
        userList[id].paid = amout
        reload()
    }
    
    func changeShareAmount(id: Int, amout: CGFloat) {
        userList[id].share = amout
        reload()
    }
}
