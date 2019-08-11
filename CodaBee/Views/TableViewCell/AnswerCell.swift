//
//  AnswerCell.swift
//  CodaBee
//
//  Created by B Masset on 11/08/2019.
//  Copyright © 2019 Bernard Masset. All rights reserved.
//

import UIKit

class AnswerCell: UITableViewCell {

    @IBOutlet weak var profileIV: RoundIV!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var answerLbl: UILabel!
    @IBOutlet weak var answerIV: UIImageView!
    
    var answer: Answer!
    
    func setup(_ answer: Answer) {
        answerIV.isHidden = true
        answerLbl.isHidden = true
        self.answer = answer


        dateLbl.text = self.answer.date
        FirebaseHelper().getUser(self.answer.id) { (user) in
            DispatchQueue.main.async {
// le user est optionnel
//                if let bee = user {
//                    self.profileIV.download(string: bee.imageUrl)
//                    self.usernameLbl.text = bee.username
// Pb déjà rencontré (erreur potentielle à l'éxécution)
                self.profileIV.download(string: user.imageUrl)
                self.usernameLbl.text = user.username
//                }
            }
        }
        if let string = self.answer.texte {
            answerIV.isHidden = false
            answerLbl.text = string
        }
        if let image = self.answer.imageUrl {
            answerIV.isHidden = false
            answerIV.download(string: image)
        }
    }

}
