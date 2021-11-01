//
//  TransactionTableViewCell.swift
//  MyApp
//
//  Created by Xuan Trung on 01/11/2021.
//

import UIKit

class TransactionTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var amount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func config(transaction: Transaction) {
        name.text = transaction.content
        amount.text = "- \(transaction.currency.symbol) \(transaction.amount.toCurrencyFormat())"
    }
    
}
