//
//  ContactListViewModel.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/9/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation
import UIKit
import Qiscus

class ContactListViewModel: NSObject, UITableViewDataSource {
    var items = [Contact]()
    
    override init() {
        super.init()

        QChatService.roomList(withLimit: 100,
                              page: 1,
                              onSuccess: { (listRoom, totalRoom, currentPage, limit) in
                                
            listRoom.forEach({ (data) in
                for p in data.participants {
                    guard let user = p.user else { return }
                    let contact = Contact(data: user)
                    let arrUnique = self.items.contains(where: { $0.id == user.id })
                    if !arrUnique { self.items.append(contact!) }
                }
            })
                                
        }, onFailed: { (err) in
            print("Failed load chats: \(err)")
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as? ContactCell {
            cell.item = self.items[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
}
