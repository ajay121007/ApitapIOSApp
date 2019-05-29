//
//  chatView.swift
//  GruntWork
//
//  Created by Appzorro on 01/12/17.
//  Copyright © 2017 Appzorro. All rights reserved.
//

import UIKit
//import JSQMessagesViewController
class chatView: UIViewController{
//var messages = [JSQMessage]()

    
    
//    lazy var outgoingBubble: JSQMessagesBubbleImage = {
//        return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
//    }()
//    
//    lazy var incomingBubble: JSQMessagesBubbleImage = {
//        return JSQMessagesBubbleImageFactory()!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
//    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //dismisViewControler
       // let leftButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(self.someFunc))
      //  self.navigationItem.leftBarButtonItem = leftButton

        

        // Do any additional setup after loading the view.
      //  senderId = "1234"
      //  senderDisplayName = "harish"
        
        ////replace *senderid*//////
        
        
//        let defaults = UserDefaults.standard
//        
//        if  let id = defaults.string(forKey: "jsq_id"),
//            let name = defaults.string(forKey: "jsq_name")
//        {
//            senderId = id
//            senderDisplayName = name
//        }
//        else
//        {
//            senderId = String(arc4random_uniform(999999))
//            senderDisplayName = ""
//            
//            defaults.set(senderId, forKey: "jsq_id")
//            defaults.synchronize()
//            
//            showDisplayNameDialog()
//        }
//        
//        title = "Chat: \(senderDisplayName!)"
//        
//        //uncomment for tap add tap guster
//      /*  let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showDisplayNameDialog))
//        tapGesture.numberOfTapsRequired = 1
//        
//        navigationController?.navigationBar.addGestureRecognizer(tapGesture) */
//        
//        
//        
//        ////replace *senderid*//////
//        
//        
//        
//       // senderId:
//        inputToolbar.contentView.leftBarButtonItem = nil
//        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
//        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
//        
//        //new data
//        let query = Constants.refs.databaseChats.queryLimited(toLast: 10)
//        
//        _ = query.observe(.childAdded, with: { [weak self] snapshot in
//            
//            if  let data        = snapshot.value as? [String: String],
//                let id          = data["sender_id"],
//                let name        = data["name"],
//                let text        = data["text"],
//                !text.isEmpty
//            {
//                if let message = JSQMessage(senderId: id, displayName: name, text: text)
//                {
//                    self?.messages.append(message)
//                    
//                    self?.finishReceivingMessage()
//                }
//            }
//        })
        
    }
    
    
    
    
    //multipul user
    @objc func showDisplayNameDialog()
    {

    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
