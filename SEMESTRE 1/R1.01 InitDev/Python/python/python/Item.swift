//
//  Item.swift
//  python
//
//  Created by Basbunar Ahmet on 10/9/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date

    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
