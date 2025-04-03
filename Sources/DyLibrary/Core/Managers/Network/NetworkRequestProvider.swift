//
//  NetworkRequestProvider.swift
//  DyLibrary
//
//  Created by Miri Kutainer on 02/12/2024.
//

import Foundation

protocol NetworkRequestProvider {
    associatedtype Request: NetworkRequest
    func create(timeoutInterval: TimeInterval?) -> Request
}
