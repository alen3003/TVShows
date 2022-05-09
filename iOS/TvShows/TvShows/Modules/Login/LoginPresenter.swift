import RxSwift
import RxCocoa

final class LoginPresenter {

    // MARK: - Private properties -

    private unowned let view: LoginViewInterface
    private let interactor: LoginInteractorInterface
    private let wireframe: LoginWireframeInterface
    private let disposeBag = DisposeBag()

    // MARK: - Lifecycle -

    init(
        view: LoginViewInterface,
        interactor: LoginInteractorInterface,
        wireframe: LoginWireframeInterface
    ) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: - Extensions -

extension LoginPresenter: LoginPresenterInterface {
    func configure(with output: Login.ViewOutput) -> Login.ViewInput {
        handle(
            login: output.login,
            output.email,
            output.password
        )
        handle(
            register: output.register,
            output.email,
            output.password
        )

        let areButtonsAvailable = onButtonsAvailable(email: output.email, password: output.password)
        return Login.ViewInput(areButtonsAvailable: areButtonsAvailable)
    }
}

extension LoginPresenter {

    private func handle(
        login: Signal<Void>,
        _ email: Driver<String?>,
        _ password: Driver<String?>
    ) {
        let inputs = Driver.combineLatest(email.compactMap { $0 }, password.compactMap { $0 })
        login
            .withLatestFrom(inputs)
            .flatMap { [unowned self] email, password -> Driver<Member> in
                performLogin(email, password)
            }
            .do(onNext: { [unowned view] member in
                view.hideTransient()
                print("Successfully logged in member: \(member)")
                // TODO: Save user
            })
            .drive(onNext: { [unowned wireframe] _ in
                wireframe.navigateToHome()
            })
            .disposed(by: disposeBag)
    }

    private func performLogin(_ email: String, _ password: String) -> Driver<Member> {
        interactor
            .login(with: email, password)
            .observe(on: MainScheduler.instance)
            .do(onError: { [unowned self] error in
                view.hideTransient()
                showValidationError(error)
            }, onSubscribe: { [unowned view] in
                view.showTransient()
            })
            .asDriver(onErrorDriveWith: .never())
    }

    private func handle(
        register: Signal<Void>,
        _ email: Driver<String?>,
        _ password: Driver<String?>
    ) {
        let inputs = Driver.combineLatest(email.compactMap { $0 }, password.compactMap { $0 })
        register
            .withLatestFrom(inputs)
            .flatMap { [unowned self] email, password -> Driver<Member> in
                performRegister(email, password)
            }
            .do(onNext: { [unowned view] member in
                view.hideTransient()
                print("Successfully registered member: \(member)")
                // TODO: Save user
            })
            .drive(onNext: { [unowned wireframe] _ in
                wireframe.navigateToHome()
            })
            .disposed(by: disposeBag)
    }

    private func performRegister(_ email: String, _ password: String) -> Driver<Member> {
        interactor
            .register(with: email, password)
            .observe(on: MainScheduler.instance)
            .do(onError: { [unowned self] error in
                view.hideTransient()
                showValidationError(error)
            }, onSubscribe: { [unowned view] in
                view.showTransient()
            })
            .asDriver(onErrorDriveWith: .never())
    }

    private func onButtonsAvailable(email: Driver<String?>, password: Driver<String?>) -> Driver<Bool> {
        Driver.combineLatest(email.compactMap { $0 }, password.compactMap { $0 })
            .map { email, password in
                !email.isEmpty && !password.isEmpty
            }
            .startWith(false)
    }
}

private extension LoginPresenter {
    private func showValidationError(_ error: Error) {
        wireframe.showAlert(with: "Error", message: error.localizedDescription)
    }
}
