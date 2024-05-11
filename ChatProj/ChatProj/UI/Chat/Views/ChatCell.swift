import UIKit

final class ChatCell: UITableViewCell {

    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    var isIncoming: Bool = true {
        didSet {
            updateUI()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        updateUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Internal

extension ChatCell {
    func configure(with text: String, isIncoming: Bool) {
        label.text = text
        self.isIncoming = isIncoming
    }
}

// MARK: - Private

private extension ChatCell {

    private func setupUI() {
        addSubview(containerView)
        containerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            containerView.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
        ])
        
        if isIncoming {
            NSLayoutConstraint.activate([
                containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
            ])
        } else {
            NSLayoutConstraint.activate([
                containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 150),
                containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
            ])
        }
    }

    private func updateUI() {
        if isIncoming {
            containerView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
            label.textAlignment = .left
        } else {
            containerView.backgroundColor = UIColor.yellow
            label.textAlignment = .right
        }
    }
}
