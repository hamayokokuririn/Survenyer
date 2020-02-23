//
//  InputAppliable.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/02/23.
//

import Foundation

protocol InputAppliable {
    associatedtype Input
    func apply(input: Input)
}
