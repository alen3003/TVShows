import UIKit
import RxSwift
import RxCocoa

protocol LoginWireframeInterface: WireframeInterface {
}

protocol LoginViewInterface: ViewInterface {
}

protocol LoginPresenterInterface: PresenterInterface {

    func configure(with output: Login.ViewOutput) -> Login.ViewInput

}

protocol LoginInteractorInterface: InteractorInterface {
}

enum Login {

    struct ViewOutput {
    }

    struct ViewInput {
    }

}
