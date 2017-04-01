//
//  WebsocketsTransport.swift
//  SignalRClient
//
//  Created by Pawel Kadluczka on 2/23/17.
//  Copyright © 2017 Pawel Kadluczka. All rights reserved.
//

import Foundation
import SocketRocket

public class WebsocketsTransport: NSObject, Transport, SRWebSocketDelegate {

    var webSocket: SRWebSocket? = nil
    public weak var delegate: TransportDelegate! = nil

    public func start(url:URL, query: String) {
        var queryComponents = URLComponents(url: url.appendingPathComponent("ws"), resolvingAgainstBaseURL: false)!
        queryComponents.percentEncodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        self.webSocket = SRWebSocket(url: queryComponents.url!)
        self.webSocket!.delegate = self
        self.webSocket!.open();
    }

    // TODO: message type?
    public func send(data: Data) throws {
        try webSocket?.send(data)
    }

    public func close() {
        webSocket?.close()
    }

    public func webSocketDidOpen(_ webSocket: SRWebSocket) {
        delegate?.transportDidOpen()
    }

    public func webSocket(_ webSocket: SRWebSocket, didReceiveMessageWith data: Data) {
        delegate?.transportDidReceiveData(data)
    }

public func webSocket(_ webSocket: SRWebSocket!, didReceiveMessage message: Any!) {
    if let message = message as? String {
        delegate?.transportDidReceiveData(message.data(using: .utf8)!)
    }

    }

    public func webSocket(_ webSocket: SRWebSocket, didCloseWithCode code: Int, reason: String?, wasClean: Bool) {
        // TODO: Handle error codes
        delegate?.transportDidClose(nil)
    }

    public func webSocket(_ webSocket: SRWebSocket, didFailWithError error: Error) {
        delegate?.transportDidClose(error)
    }  
}
