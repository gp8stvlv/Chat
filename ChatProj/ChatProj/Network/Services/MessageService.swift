import Foundation

protocol IMessageService {
    func connectToWebSocket()
}

final class MessageService {

    private init() {}

    static let shared: IMessageService = MessageService()
    let webSocketTask = URLSession(configuration: .default).webSocketTask(with: URL(string: "wss://ТУТ_ВАШ_АДРЕС")!)
}

extension MessageService: IMessageService {
    func connectToWebSocket() {
        webSocketTask.resume()
    }
}
