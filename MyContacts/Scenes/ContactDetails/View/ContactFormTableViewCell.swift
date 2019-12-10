//
//  ContactFormTableViewCell.swift
//  MyContacts
//
//  Created by Mustafa Saify on 12/5/19.
//  Copyright © 2019 Mustafa Saify. All rights reserved.
//

import UIKit

protocol ContactFormTableViewCellDelegate : class {
    func contactFormCell(cell: ContactFormTableViewCell, didEnteredText text: String?)
}

class ContactFormTableViewCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return "\(self)"
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    
    weak var delegate: ContactFormTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with viewModel: ContactDetailsViewModel.FormItem) {
        titleLabel.text = viewModel.type.title
        valueTextField.text = viewModel.value
        valueTextField.isEnabled = viewModel.isEditable
    }

}

extension ContactFormTableViewCell : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.contactFormCell(cell: self, didEnteredText: textField.text)
    }
}
