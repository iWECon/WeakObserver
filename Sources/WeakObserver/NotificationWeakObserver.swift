//
//  File.swift
//  
//
//  Created by iWw on 2020/12/17.
//

import UIKit

public class NotificationWeakObserver: WeakObserver {
    
    public typealias Object = AnyObject
    
    public private(set) var name: Notification.Name
    public private(set) var using: ((_: Notification) -> Void)?
    public private(set) var weakifyUsing: ((_: Object, _: Notification) -> Void)?
    public private(set) var object: Any?
    public private(set) weak var weakifyObject: Object?
    private var weakifyObserver: NSObjectProtocol?
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: name, object: object)
        guard let wo = weakifyObserver else { return }
        NotificationCenter.default.removeObserver(wo, name: name, object: object)
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
    
    required public init(weakify weakifyObject: Object, observer: AnyObject, name: Notification.Name, object: Any? = nil, queue operationQueue: OperationQueue = .main, using: ((_: Object, _: Notification) -> Void)?) {
        self.name = name
        super.init()
        
        self.target = observer
        self.weakifyUsing = using
        self.weakifyObject = weakifyObject
        self.object = object
        
        self.weakifyObserver = NotificationCenter.default.addObserver(forName: name, object: object, queue: operationQueue) { [weak weakifyObject] (nofity) in
            guard let wo = weakifyObject else { return }
            using?(wo, nofity)
        }
    }
}
