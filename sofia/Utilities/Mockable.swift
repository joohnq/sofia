//
//  Mockable.swift
//  sofia
//
//  Created by Henrique on 05/03/25.
//
public protocol Mockable {
    associatedtype MockType

    static var mock: MockType { get }
    static var mockList: [MockType] { get }
}

public extension Mockable{
    static var mock: MockType{
        mockList[0]
    }
    
    static var mockList: [MockType]{
        []
    }
}
