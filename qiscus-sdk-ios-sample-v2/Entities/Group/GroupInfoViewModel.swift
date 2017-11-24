//
//  GroupInfoViewModel.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/17/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation
import UIKit

protocol GroupInfoViewDelegate {
    func groupNameDidChanged(_ name: String)
    func groupAvatarDidChanged()
    func participantDidChanged(_ participants: [Contact])
    func participantDidUpdated()
}

enum GroupInfoViewModelItemType {
    case infoGroup
    case buttonSetImage
    case participants
}

protocol GroupInfoViewModelItem {
    var type: GroupInfoViewModelItemType { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
}

class GroupInfoViewModel: NSObject {
    var delegate: GroupInfoViewDelegate?
    var items = [GroupInfoViewModelItem]()
    var itemSelecteds = [Contact]() {
        didSet {
            delegate?.participantDidChanged(itemSelecteds)
        }
    }
    var groupName: String = ""
    var avatarURL: UIImage? {
        didSet {
            delegate?.groupAvatarDidChanged()
        }
    }
    fileprivate var pickerView = UIImagePickerView()
    
    func loadData() {
        pickerView.delegate = self
        items.removeAll()
        
        // info group
        let infoGroupItem = GroupInfoViewModelInfoItem()
        items.append(infoGroupItem)
        
        // set image button
        let setImageItem = GroupInfoViewModelButtonSetImageItem()
        items.append(setImageItem)
        
        // participants
        let participantItem = GroupInfoViewModelParticipantsItem(participants: itemSelecteds)
        items.append(participantItem)
        
        delegate?.participantDidUpdated()
    }
    
    func alertRemoveParticipants() {
        let alertController = UIAlertController(title: "Confirmation",
                                                message: "Are you sure want to remove participant and go back?",
            preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: { (action) -> Void in
                                        self.itemSelecteds.removeAll()
                                        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                                            popViewController()
                                        })
        })
        
        let cancelButton = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: { (action) -> Void in
                                            print("Cancel button tapped")
        })
        
        alertController.addAction(okButton)
        alertController.addAction(cancelButton)
        alertController.preferredAction = okButton
        
        presentViewController(alertController)
    }
    
    func pickImage() -> Void {
        let alertController = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        
        let takeButton = UIAlertAction(title: "Take Photo",
                                       style: .default,
                                       handler: { (action) -> Void in
                                        print("take photo...")
                                        self.pickerView.openImagePicker(.camera)
        })
        let chooseButton = UIAlertAction(title: "Choose Photo",
                                         style: .default,
                                         handler: { (action) -> Void in
                                            print("choose photo...")
                                            self.pickerView.openImagePicker(.photoLibrary)
        })
        
        let cancelButton = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: { (action) -> Void in
                                            print("Cancel button tapped")
        })
        
        alertController.addAction(takeButton)
        alertController.addAction(chooseButton)
        alertController.addAction(cancelButton)
        
        presentViewController(alertController)
    }
}

extension GroupInfoViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.section]
        switch item.type {
        case .infoGroup:
            break
            
        case .buttonSetImage:
            self.pickImage()
            // self.delegate?.imagePickerDidTap()
            
        case .participants:
            if self.itemSelecteds.count > 2 {
                self.itemSelecteds.remove(at: indexPath.row)
                
            } else {
                self.alertRemoveParticipants()
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title   = items[section].sectionTitle
        let view    = UIView.headerInTableView(title)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let item = items[section]
        switch item.type {
        case .participants:
            return 50.0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.section]
        switch item.type {
        case .participants:
            if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
                cell.separatorInset = UIEdgeInsets(top: 0, left: 75, bottom: 0, right: 0)
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = items[indexPath.section]
        switch item.type {
        case .infoGroup:
            return 128.0
        case .buttonSetImage:
            return 44.0
        case .participants:
            return 76.0
        }
    }
    
}

extension GroupInfoViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section]
        switch item.type {
        case .infoGroup:
            if let cell = tableView.dequeueReusableCell(withIdentifier: GroupInfoCell.identifier, for: indexPath) as? GroupInfoCell {
                cell.delegate = self
                guard let avatarURL = self.avatarURL else {
                    cell.item = GroupInfo(name: self.groupName, avatarURL: UIImage(named: "ic_default_avatar")!, participants: self.itemSelecteds)
                    return cell
                }
                
                cell.item = GroupInfo(name: self.groupName, avatarURL: avatarURL, participants: self.itemSelecteds)
                return cell
            }
            
        case .buttonSetImage:
            if let cell = tableView.dequeueReusableCell(withIdentifier: SetGroupPhotoCell.identifier, for: indexPath) as? SetGroupPhotoCell {
                
                tableView.tableFooterView = UIView()
                
                return cell
            }
            
        case .participants:
            if let item = item as? GroupInfoViewModelParticipantsItem, let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as? ContactCell {
                let contact = item.participants[indexPath.row]
                cell.item   = contact
                
                cell.accessoryView  = UIImageView.removeImage()
    
                tableView.tableFooterView = UIView()
    
                return cell
            }
        }
        
        return UITableViewCell()
    }
}

extension GroupInfoViewModel: GroupInfoCellViewDelegate {
    func fieldNameDidChanged(_ text: String?) {
        if let text = text {
            self.groupName = text
            delegate?.groupNameDidChanged(text)
        }
    }
}

extension GroupInfoViewModel: UIImagePickerViewDelegate {
    func didFinishPickImage(of image: UIImage) {
        self.avatarURL = image
    }
}

class GroupInfoViewModelInfoItem: GroupInfoViewModelItem {
    var type: GroupInfoViewModelItemType {
        return .infoGroup
    }
    
    var sectionTitle: String {
        return ""
    }
    
    var rowCount: Int {
        return 1
    }
}

class GroupInfoViewModelButtonSetImageItem: GroupInfoViewModelItem {
    var type: GroupInfoViewModelItemType {
        return .buttonSetImage
    }
    
    var sectionTitle: String {
        return ""
    }
    
    var rowCount: Int {
        return 1
    }
}

class GroupInfoViewModelParticipantsItem: GroupInfoViewModelItem {
    var type: GroupInfoViewModelItemType {
        return .participants
    }
    
    var sectionTitle: String {
        return "PARTICIPANTS"
    }
    
    var rowCount: Int {
        return participants.count
    }
    
    var participants: [Contact]
    
    init(participants: [Contact]) {
        self.participants = participants
    }
}

