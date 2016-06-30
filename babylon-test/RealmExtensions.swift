//
//  RealmExtensions.swift
//  babylon-test
//
//  Created by James Milton on 30/06/2016.
//  Copyright © 2016 james milton. All rights reserved.
//

import Foundation
import RealmSwift

extension Results {
    
     func setupNotificationBlock(tableView: UITableView) -> NotificationToken {
        return self.addNotificationBlock { (changes: RealmCollectionChange) in
            switch changes {
            case .Initial:
                tableView.reloadData()
                break
            case .Update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRowsAtIndexPaths(insertions.map { NSIndexPath(forRow: $0, inSection: 0) },
                    withRowAnimation: .Automatic)
                tableView.deleteRowsAtIndexPaths(deletions.map { NSIndexPath(forRow: $0, inSection: 0) },
                    withRowAnimation: .Automatic)
                tableView.reloadRowsAtIndexPaths(modifications.map { NSIndexPath(forRow: $0, inSection: 0) },
                    withRowAnimation: .Automatic)
                tableView.endUpdates()
                break
            case .Error(let err):
                fatalError("\(err)")
                break
            }
        }
    }
}

