# WeakObserver

A simple weak observer for Notification.

## How to use?

```swift
import WeakObserver

class Controller: UIViewController {
    
    var keyboardWeakObserver: NotificationWeakObserver?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // No need to call `Notification.default.removeObserver(_:)`
        keyboardWeakObserver = NotificationWeakObserver(self, name: UIResponder.WillChangeFrameNotification) { (notify) in 
            // do something
        }
    }
}
```


## Install

#### Swift Package Manager
```swift
.package("https://github.com/iWECon/WeakObserver", from: "2.0.0")
```
