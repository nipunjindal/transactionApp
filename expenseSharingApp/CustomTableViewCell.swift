//
//  CustomTableViewCell.swift
//  expenseSharingApp
//
//  Created by njindal on 3/10/18.
//  Copyright © 2018 adobe. All rights reserved.
//

import UIKit

protocol InfoAddedHandler: NSObjectProtocol {
    func changePaidAmount(id: Int, amout: CGFloat)
    func changeShareAmount(id: Int, amout: CGFloat)
    func remove(id: Int)
}

class CustomTableViewCell: UITableViewCell {

    public var id: Int = 0
    weak var delegate: InfoAddedHandler?
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var paidView: UITextField!
    @IBOutlet weak var shareView: UITextField!
    
    var paid: CGFloat = 0.0 {
        didSet {
            paidView.text = String.init(format: "%f", paid)
        }
    }
    
    var share: CGFloat = 0.0 {
        didSet {
            shareView.text = String.init(format: "%f", share)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        paidView.delegate = self
        shareView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func handleShareAmount(_ sender: Any) {
        if let value = shareView.text,
            let n = NumberFormatter().number(from: value) {
            // Uppercase string.
            // ... Use it as the label text.
            share = CGFloat(n)
            delegate?.changeShareAmount(id: id, amout: CGFloat(n))
        }
    }
    
    @IBAction func handlePaidAmount(_ sender: Any) {
        if let value = paidView.text,
            let n = NumberFormatter().number(from: value) {
            // Uppercase string.
            // ... Use it as the label text.
            paid = CGFloat(n)
            delegate?.changePaidAmount(id: id, amout: CGFloat(n))
        }
    }
    
    @IBAction func handleRemove(_ sender: Any) {
        delegate?.remove(id: id)
    }
}

extension CustomTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
    {
        textField.resignFirstResponder()
        return true
    }
}
