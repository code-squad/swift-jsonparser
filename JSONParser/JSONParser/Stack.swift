//
//  Stack.swift
//  JSONParser
//
//  Created by Elena on 26/12/2018.
//  Copyright © 2018 elena. All rights reserved.
//

import Foundation

struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

extension Stack {
    var topElement: Element? {
        return self.items.last
    }
}
