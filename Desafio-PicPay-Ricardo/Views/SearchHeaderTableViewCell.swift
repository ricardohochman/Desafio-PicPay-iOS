//
//  SearchHeaderTableViewCell.swift
//  Desafio-PicPay-Ricardo
//
//  Created by Ricardo Hochman on 10/04/19.
//  Copyright © 2019 Ricardo Hochman. All rights reserved.
//

import UIKit

protocol SearchHeaderDelegate: class {
    func textDidChange(_ text: String)
}

class SearchHeaderTableViewCell: UITableViewCell {

    @IBOutlet private weak var searchBar: UISearchBar!
    
    weak var delegate: SearchHeaderDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        searchBar.delegate = self
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
    }
    
    func setup(text: String?, delegate: SearchHeaderDelegate) {
        self.searchBar.text = text
        self.delegate = delegate
        if text != nil {
//            self.searchBar.becomeFirstResponder()
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.0)
            UIView.setAnimationDelay(0.0)
            self.searchBar.becomeFirstResponder()
            UIView.commitAnimations()

        }
    }
}

extension SearchHeaderTableViewCell: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.textDidChange(searchText)
    }
}
