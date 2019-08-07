//
//  QuestionCell.swift
//  CodaBee
//
//  Created by B Masset on 07/08/2019.
//  Copyright © 2019 Bernard Masset. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var questionLbl: UILabel!
    
    var question: Question!
    
    func setup(_ question:Question) {
        setup()
        self.question = question
        dateLbl.text = self.question.date.IlYa()
        questionLbl.text = self.question.questionString
    }
}

