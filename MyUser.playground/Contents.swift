//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

protocol MyVCProtocol {
    var failed: Bool { get set }
}

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(label)
        self.view = view
    }
}

public struct user: MyVCProtocol {
    var failed: Bool
    
    mutating func yourCode() {
        failed = true
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
