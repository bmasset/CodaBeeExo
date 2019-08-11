//
//  AnswerController.swift
//  CodaBee
//
//  Created by B Masset on 08/08/2019.
//  Copyright © 2019 Bernard Masset. All rights reserved.
//

import UIKit

class AnswerController: MoveableController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var profiIV: RoundIV!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var questionLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var zoneDeTexteView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var libraryBtn: UIButton!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var question: Question?
    var imagePicker = UIImagePickerController()
    var answers: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if question != nil {
            questionLbl.text = question!.questionString
            dateLbl.text = question!.date.IlYa()
            topView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
            textView.layer.cornerRadius = 15
            textView.delegate = self
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            tableView.delegate = self
            tableView.dataSource = self
            FirebaseHelper().getUser(question!.userId) { (user) in
                DispatchQueue.main.async {
                    // Anomalie : si j'ai if let beeUser = user
                    // j'ai : Initializer for conditional binding must have Optional type, not 'BeeUser'
                    
                    let beeUser = user
                    self.profiIV.download(string: beeUser.imageUrl)
                    self.usernameLbl.text = beeUser.username

                    /*
                    if let beeUser = user {
                        self.profiIV.download(string: beeUser.imageUrl)
                        self.usernameLbl.text = beeUser.username
 
                     } */
                }
            }
        }
        FirebaseHelper().getAnswer(ref: question!.ref) { (answer) in
            DispatchQueue.main.async {
                self.answers.append(answer)
                self.tableView.reloadData()
            }
        }
    }

    override func showKey(notification: Notification) {
        super.showKey(notification: notification)
        let safeArea = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        // différent / à vidéo 280: -height
        let totalHeight = height + safeArea
        animation(totalHeight, bottomConstraint)
    }
    
    override func hideKey(notification: Notification) {
        super.hideKey(notification: notification)
        animation(0, bottomConstraint)
    }
    
    @IBAction func libraryPressed(_ sender: Any) {
            imagePicker.sourceType = .photoLibrary
            present(imagePicker,animated: true,completion: nil)
    }
    
    
    @IBAction func cameraPressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker,animated: true,completion: nil)
        }
    }
    
    
    @IBAction func validatePressed(_ sender: Any) {
        if question != nil {
            if textView.text != "" {
                FirebaseHelper().saveAnswer(ref: question!.ref, texte: textView.text, image: nil, height: nil)
                textView.text = ""
                animateIn(false)
                animation(40, heightConstraint)
                view.endEditing(true)
            }
        }
    }
    
}

extension AnswerController: UITextViewDelegate {
    
    func animateIn(_ bool: Bool) {
        libraryBtn.isHidden = bool
        cameraBtn.isHidden = bool
        let constante:CGFloat = bool ? 8 : 90
        animation(constante, leadingConstraint)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text == "" {
            // Zone de texte = 40 + boutons visibles + leading 90
            animation(40, heightConstraint)
            animateIn(false)
        } else {
            // Zone de texte s'adapte + boutons cachés + leading 8
            let textHeight = textView.text.height(textView.frame.width, font: UIFont.systemFont(ofSize: 15) ) + 25
            animation(textHeight, heightConstraint)
            animateIn(true)
        }
    }
    
}

extension AnswerController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            let imageSize = image.size
            let heightRatio = imageSize.width / imageSize.height
            if let data = image.jpegData(compressionQuality: 0.4) {
                FirebaseHelper().addImageAnswer(data: data) { (urlString) in
                    if urlString != nil, self.question != nil {
                        FirebaseHelper().saveAnswer(ref: self.question!.ref, texte: nil, image: urlString!, height: heightRatio)
                    }
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //
    }
    
    
}

extension AnswerController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell") as? AnswerCell {
            cell.setup(answers[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
