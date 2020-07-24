//
//  ChatViewController.swift
//  LastDevContest
//
//  Created by 강병민 on 2020/07/24.
//  Copyright © 2020 강병민. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController : UIViewController  {
    
    var serviceID : String = ""
    let db = Firestore.firestore()

    var messages : [Message] = []

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "ReusableCell2")
        
        loadMessages()
    }
    @IBAction func pressedSend(_ sender: Any) {
        print("send message")
        db.collection("chatting")
            .document(serviceID).collection("message")
            .addDocument(data: ["제목" : titleTextField.text!, "내용" :  bodyTextField.text! , "시간" : Date().timeIntervalSince1970 * 1000])
    }
    
    func loadMessages(){
        db.collection("chatting").document(serviceID).collection("message").order(by: "시간").addSnapshotListener(){ (querySnapshot, Error) in
            self.messages = []

            
            if let e = Error{
                print("there was error when getting data from fire store : \(e)")
            }else{
                if let snapshotDocuments = querySnapshot?.documents{
                    for doc in snapshotDocuments{
                        let data = doc.data()
                        if let messageTitle = data["제목"] as? String, let messageBody = data["내용"] as? String{
//                            print(messageTitle)
                            let newMessage = Message(title: messageTitle, body: messageBody)
                            self.messages.append(newMessage)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1 , section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
//                                print(self.messages)
                            }
                        }
                        
                    }
                }
            }
            
        }
    }
    
    
}
extension ChatViewController : UITableViewDelegate{
    
}

extension ChatViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell2", for: indexPath) as! MessageCell
        cell.titleLabel.text = message.title
        cell.bodyLabel.text = message.body
        
        return cell
    }
    
    
}
