import UIKit

class ChatViewController: UIViewController {

    private lazy var tableView = Self.createTableView()
    private let messageInputField = UITextField()
    private let sendButton = UIButton()

    private var messages: [Message] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

// MARK: - Private

private extension ChatViewController {
    func configureUI() {

        view.backgroundColor = .systemBackground

        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)
        view.addSubview(messageInputField)
        view.addSubview(sendButton)
        setLayout()
    }

    func setLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        messageInputField.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: messageInputField.topAnchor),
            
            messageInputField.leftAnchor.constraint(equalTo: view.leftAnchor),
            messageInputField.rightAnchor.constraint(equalTo: sendButton.leftAnchor),
            messageInputField.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            messageInputField.heightAnchor.constraint(equalToConstant: 50),
            
            sendButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            sendButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 80),
            sendButton.heightAnchor.constraint(equalTo: messageInputField.heightAnchor)
        ])

        sendButton.setTitle("Send", for: .normal)
        sendButton.backgroundColor = .systemBlue
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
    }
    
    @objc func sendButtonTapped() {
        if let messageText = messageInputField.text, !messageText.isEmpty {
            let message = Message(text: messageText, isIncoming: Bool.random())
            messages.append(message)
            tableView.reloadData()
            messageInputField.text = ""
        }
    }

    static func createTableView() -> UITableView {
        let tableView = UITableView(frame: .zero, style: .plain)

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.register(
            ChatCell.self,
            forCellReuseIdentifier: String(describing: ChatCell.self))
        
        return tableView
    }
}

//MARK: - DataSource

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChatCell.self),
                                                       for: indexPath) as? ChatCell
        else {
            return .init()
        }

        let message = messages[indexPath.row]
        cell.configure(with: message.text, isIncoming: message.isIncoming)
        return cell
    }
}


private extension String {
//    static var
}
