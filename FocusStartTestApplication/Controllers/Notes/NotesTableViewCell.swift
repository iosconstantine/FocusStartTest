//
//  NotesTableViewCell.swift
//  FocusStartTestApplication
//
//  Created by KONSTANTIN TISHCHENKO on 11.10.2021.
//

import UIKit

class NotesTableViewCell: UITableViewCell {
    
    static let identifier = "NotesTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(note: Note) {
        titleLabel.text = note.title
        descriptionLabel.text = note.descriptionText
    }
    
}
