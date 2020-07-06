//
//  DataStore.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/07/07.
//

import Foundation

protocol Repository {
    associatedtype Item
    func update(item: Item)
    func remove(id: Int)
    func get(id: Int) -> Item?
}

struct DataStore<R: Repository> {
    
    let repository: R
    
    init(repository: R) {
        self.repository = repository
    }
    
}

struct Tyosa {
    let id: Int
    let title: String
    let content: String
}

class InMemoryRepository: Repository {
    typealias Item = Tyosa
    
    let tyosa1 = Tyosa(id: 0, title: "Title1", content: "content")
    let tyosa2 = Tyosa(id: 1, title: "Title2", content: "content")
    let tyosa3 = Tyosa(id: 2, title: "Title3", content: "content")
    lazy var items = [tyosa1, tyosa2, tyosa3]
    
    func update(item: Tyosa) {
        items.append(item)
    }
    func remove(id: Int){
        items.removeAll(where: {$0.id == id})
    }
    func get(id: Int) -> Tyosa? {
        return items.first(where: {$0.id == id})
    }
}

let r = InMemoryRepository()
let dataStore = DataStore(repository: r)
