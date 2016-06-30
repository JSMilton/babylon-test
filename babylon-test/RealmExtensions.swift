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
//                tableView.beginUpdates()
//                tableView.insertRowsAtIndexPaths(insertions.map { NSIndexPath(forRow: $0, inSection: 0) },
//                    withRowAnimation: .Fade)
//                tableView.deleteRowsAtIndexPaths(deletions.map { NSIndexPath(forRow: $0, inSection: 0) },
//                    withRowAnimation: .Fade)
//                tableView.reloadRowsAtIndexPaths(modifications.map { NSIndexPath(forRow: $0, inSection: 0) },
//                    withRowAnimation: .Fade)
//                tableView.endUpdates()
                
                tableView.reloadData()
                
                // So Realm sends a modification update for every object, regardless of whether or not it has
                // changed. Seems that reloading that many rows causes afwul performance in the tables reloading
                // animation. That's why the above code is commented. Doing a full reload has excellent performance.
                // Probably a way around it, but I haven't had a chance to find it yet.
                break
            case .Error(let err):
                fatalError("\(err)")
                break
            }
        }
    }
}

