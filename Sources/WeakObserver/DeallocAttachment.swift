//
//  File.swift
//  
//
//  Created by iWw on 2020/12/17.
//

import UIKit

public class DeallocAttachment {
    
    private static var associatedObjectKey: String = "WeakObserver.DeallocAttachment.associatedObjectKey"
    
    public var deallocCallback: () -> Void
    
    required public init(observer: Any, _ callback: @escaping () -> Void) {
        self.deallocCallback = callback
        
        objc_setAssociatedObject(observer, Self.associatedObjectKey, self, .OBJC_ASSOCIATION_RETAIN)
    }
    
    deinit {
        self.deallocCallback()
    }
}
