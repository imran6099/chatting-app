//
//  XMPPService.swift
//  chatting-app
//
//  Created by Imran Abdullah on 02/09/23.
//

import Foundation
import XMPPFramework

enum XMPPServiceError: Error {
    case wrongUserJID
    case failedToConnect
    case authenticationFailed
}

class XMPPService: NSObject {
    static let shared = XMPPService()
    
    var isXmppConnected: Bool = false
    private var stream: XMPPStream!
    private var userPassword: String?
    private var xmppReconnect: XMPPReconnect!
    
    public var completion: ((Bool, XMPPServiceError?) -> Void)?

    private override init() {
        super.init()
        stream = XMPPStream()
        stream.addDelegate(self, delegateQueue: DispatchQueue.main)
        
        xmppReconnect = XMPPReconnect()
        xmppReconnect.activate(stream)
        xmppReconnect.addDelegate(self, delegateQueue: DispatchQueue.main)
    }
    
    func connect(hostName: String, port: UInt16, username: String, password: String, completion: @escaping (Bool, XMPPServiceError?) -> Void) {
        
        if isXmppConnected {
            completion(true, nil)
            return
        }

        self.completion = completion
        self.userPassword = password
        
        stream.hostName = hostName
        stream.hostPort = port
        stream.myJID = XMPPJID(string: username)
        
        do {
            try stream.connect(withTimeout: XMPPStreamTimeoutNone)
        } catch {
            completion(false, .failedToConnect)
        }
    }
    
    func sendMessage(to recipientJID: String, content: String) {
        print("Sending Message to \(recipientJID)")
        let message = XMPPMessage(type: "chat", to: XMPPJID(string: recipientJID))
        message.addBody(content)
        stream.send(message)
    }
    
    func disconnect() {
        stream.disconnect()
        isXmppConnected = false
    }
}

extension XMPPService: XMPPStreamDelegate {
    func xmppStreamDidConnect(_ stream: XMPPStream) {
        guard let password = userPassword else {
            completion?(false, .authenticationFailed)
            return
        }

        do {
            try stream.authenticate(withPassword: password)
        } catch {
            completion?(false, .authenticationFailed)
        }
    }
    
    func xmppStreamDidAuthenticate(_ sender: XMPPStream) {
        isXmppConnected = true
        completion?(true, nil)
    }
        
    func xmppStream(_ sender: XMPPStream, didNotAuthenticate error: DDXMLElement) {
        completion?(false, .authenticationFailed)
    }
    
    func xmppStream(_ sender: XMPPStream, didSend message: XMPPMessage) {
        print("Message sent successfully!")
    }

    func xmppStream(_ sender: XMPPStream, didFailToSend message: XMPPMessage, error: Error) {
        print("Failed to send message with error: \(error.localizedDescription)")
    }
    
    // Optionally handle XMPPReconnect delegate methods, if required:
    func xmppReconnect(_ sender: XMPPReconnect, didDetectAccidentalDisconnect connectionFlags: SCNetworkConnectionFlags) {
        print("Detected accidental disconnect.")
    }

    func xmppReconnect(_ sender: XMPPReconnect, shouldAttemptAutoReconnect connectionFlags: SCNetworkConnectionFlags) -> Bool {
        print("Attempting auto reconnect.")
        return true
    }
}

