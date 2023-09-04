//
//  UserModel.swift
//  chatting-app
//
//  Created by Imran Abdullah on 02/09/23.
//
import Foundation
import SQLite

struct UserModel: Identifiable {
    let id: Int64
    let name: String
    let number: String
    let XMPPJID: String
    let lastActive: Date
    let isActive: Bool
    
    init(row: Row) {
        self.id = row[Expression<Int64>("id")]
        self.name = row[Expression<String>("name")]
        self.number = row[Expression<String>("number")]
        self.XMPPJID = row[Expression<String>("XMPPJID")]
        self.lastActive = row[Expression<Date>("lastActive")]
        self.isActive = row[Expression<Bool>("isActive")]
    }
    
    init(id: Int64, name: String, number: String, XMPPJID: String, lastActive: Date, isActive: Bool) {
            self.id = id
            self.name = name
            self.number = number
            self.XMPPJID = XMPPJID
            self.lastActive = lastActive
            self.isActive = isActive
        }
}

