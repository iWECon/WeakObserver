//
//  File.swift
//  
//
//  Created by iWw on 2020/12/17.
//

import UIKit

public class NotificationWeakObserver: WeakObserver {
    
    public private(set) var name: Notification.Name
    public private(set) var using: ((_: Notification) -> Void)?
    public private(set) var object: Any?
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: name, object: object)
    }
    
    @objc func doObserver(x: Notification) {
        self.using?(x)
    }
    
    required public init(_ observer: AnyObject, name: Notification.Name, object: Any? = nil, using: ((_: Notification) -> Void)?) {
        self.name = name
        super.init()
        
        self.target = observer
        self.using = using
        self.object = object
        
        NotificationCenter.default.addObserver(self, selector: #selector(doObserver(x:)), name: name, object: object)
    }
}
