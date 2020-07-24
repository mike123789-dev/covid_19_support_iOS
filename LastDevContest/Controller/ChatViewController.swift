//
//  ChatViewController.swift
//  LastDevContest
//
//  Created by 강병민 on 2020/07/24.
//  Copyright © 2020 강병민. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController : UIViewController {
    
    var serviceID : String = ""
    let db = Firestore.firestore()

    var messages : [Message] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMessages()
    }
    @IBAction func pressedSend(_ sender: Any) {
        db.collection("chatting").document(serviceID).collection("message").addDocument(data: ["제목" : "test", "내용" :  "test" , "시간" : Date().timeIntervalSince1970 * 1000])
    }
    
    func loadMessages(){
        db.collection("chatting").document(serviceID).collection("message").addSnapshotListener(){ (querySnapshot, Error) in
            
            
            if let e = Error{
                print("there was error when getting data from fire store : \(e)")
            }else{
                if let snapshotDocuments = querySnapshot?.documents{
                    for doc in snapshotDocuments{
                        let data = doc.data()
                        if let messageTitle = data["제목"] as? String, let messageBody = data["내용"] as? String{
                            print(messageTitle)
                            let newMessage = Message(title: messageTitle, body: messageBody)
                            self.messages.append(newMessage)
                            DispatchQueue.main.async {
//                                print(self.messages)
                            }
                        }
                        
                    }
                }
            }
            
        }
    }
    
    
}
