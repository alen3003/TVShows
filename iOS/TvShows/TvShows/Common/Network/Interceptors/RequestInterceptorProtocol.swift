import Foundation

protocol RequestInterceptorProtocol {

    var interceptHeaders: [String: String] { get }

    func saveHeaders(from response: HTTPURLResponse?)

}
