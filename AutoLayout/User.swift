//
//  User.swift
//  AutoLayout
//
//  Created by Ingenieria y Software on 21/10/15.
//  Copyright © 2015 Ingenieria y Software. All rights reserved.
//

import Foundation
struct User
{
    let name: String
    let company: String
    let login: String
    let password: String
    static func login(login:String, password:String) -> User?
    {
        if let user = database[login]{
            if user.password == password
            {
                return user
            }
        }
        return nil
    }
    static let database: Dictionary<String, User>= {
        var theDatabase = Dictionary<String, User>()
        for user in [
            User(name: "Jonh this is a long text", company:"Udea", login: "jdavid", password:"jdavid"),
            User(name: "Jonh Of the udea a coder with a lot of garbage", company:"Udea", login: "jdavid1", password:"jdavid")
        ]
        {
            theDatabase[user.login] = user
        }
        return theDatabase
    }()
}