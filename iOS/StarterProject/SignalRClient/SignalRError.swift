//
//  SignalRError.swift
//  SignalRClient
//
//  Created by Pawel Kadluczka on 3/9/17.
//  Copyright © 2017 Pawel Kadluczka. All rights reserved.
//

import Foundation

enum SignalRError : Error {
    case invalidState
    case webError(statusCode: Int)
    case hubInvocationError(message: String)
    case hubInvocationCancelled
    case unexpectedMessage
    case unsupportedType
}
