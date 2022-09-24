//
//  HomeViewController.swift
//  SideMenuHW
//
//  Created by Вадим Сайко on 23.09.22.
//

import UIKit
import SnapKit

// MARK: - protocols
protocol HomeViewControllerDelegate: AnyObject {
    func didTapMenuButton()
}
protocol TopViewDelegate: AnyObject {
    func textFieldResignFirstResponder(_ textField: UITextField)
}
protocol BottomViewDelegate: AnyObject {
    func addTextToTextView (_ button: UIButton)
}

class HomeViewController: UIViewController, TopViewDelegate, BottomViewDelegate {
    weak var delegate: HomeViewControllerDelegate?
    var text: String = ""
    lazy var profileInfoView = ProfileInfoView()
    lazy var bottomButtonsView = BottomButtonsView()
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.text = "Enter your notes:"
        textView.textColor = UIColor.black
        textView.backgroundColor = .gray
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        profileInfoView.topViewDelegate = self
        bottomButtonsView.bottomViewDelegate = self
        view.backgroundColor = .systemBackground
        title = "Profile"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "list.dash"),
            style: .done,
            target: self,
            action: #selector(didTapMenuButton))
        addSubviews()
        makeConstraints()
        initializeHideKeyboard()
    }
    
    func addSubviews() {
        self.view.addSubview(profileInfoView)
        self.view.addSubview(bottomButtonsView)
        self.view.addSubview(textView)
    }
    func makeConstraints() {
        profileInfoView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(85)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(self.view.frame.height * 0.162)
        }
        bottomButtonsView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(self.view.frame.height * 0.08)
        }

        textView.snp.makeConstraints { make in
            make.bottom.equalTo(bottomButtonsView.snp.top)
            make.top.equalTo(profileInfoView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    func textFieldResignFirstResponder(_ textField: UITextField) {
        self.text += " " + (textField.text ?? "")
    }
    func addTextToTextView(_ button: UIButton) {
        textView.text += self.text
        self.text = ""
    }
    func initializeHideKeyboard() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissMyKeyboard() {
        view.endEditing(true)
    }
    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }
}

// MARK: - topView of profile
class ProfileInfoView: UIView, UITextFieldDelegate {
    weak var topViewDelegate: TopViewDelegate?
    lazy var mainTopStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = NSLayoutConstraint.Axis.horizontal
        stack.alignment = UIStackView.Alignment.center
        return stack
    }()
    lazy var stackForLabels: UIStackView = {
        let stack = UIStackView()
        stack.axis = NSLayoutConstraint.Axis.vertical
        stack.distribution = UIStackView.Distribution.fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    lazy var stackForTextFields: UIStackView = {
        let stack = UIStackView()
        stack.axis = NSLayoutConstraint.Axis.vertical
        stack.distribution = UIStackView.Distribution.fillEqually
        stack.spacing = 6
        return stack
    }()
    lazy var avatar: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "avatar"))
        return imageView
    }()
    lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.text = "First"
        return label
    }()
    lazy var middleLabel: UILabel = {
        let label = UILabel()
        label.text = "Middle"
        return label
    }()
    lazy var lastLabel: UILabel = {
        let label = UILabel()
        label.text = "Last"
        return label
    }()
    lazy var firstTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter First Name"
        textField.borderStyle = .roundedRect
        return textField
    }()
    lazy var middleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Middle Name"
        textField.borderStyle = .roundedRect
        return textField
    }()
    lazy var lastTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Last Name"
        textField.borderStyle = .roundedRect
        return textField
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        firstTextField.delegate = self
        middleTextField.delegate = self
        lastTextField.delegate = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func updateConstraints() {
        mainTopStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        avatar.snp.makeConstraints { make in
            make.width.equalTo(mainTopStack.snp.height)
        }
        stackForLabels.snp.makeConstraints { make in
            make.width.equalTo((superview?.frame.width ?? 0) * 0.14)
            make.height.equalTo(mainTopStack.snp.height)
        }
        stackForTextFields.snp.makeConstraints { make in
            make.height.equalTo(mainTopStack.snp.height)
        }
        super.updateConstraints()
    }
    
    func addSubviews() {
        stackForLabels.addArrangedSubview(firstLabel)
        stackForLabels.addArrangedSubview(middleLabel)
        stackForLabels.addArrangedSubview(lastLabel)
        stackForTextFields.addArrangedSubview(firstTextField)
        stackForTextFields.addArrangedSubview(middleTextField)
        stackForTextFields.addArrangedSubview(lastTextField)
        mainTopStack.addArrangedSubview(avatar)
        mainTopStack.addArrangedSubview(stackForLabels)
        mainTopStack.addArrangedSubview(stackForTextFields)
        addSubview(mainTopStack)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        topViewDelegate?.textFieldResignFirstResponder(textField)
    }
}

// MARK: - bottomView of profile
class BottomButtonsView: UIView {
    weak var bottomViewDelegate: BottomViewDelegate?
    lazy var bottomButtonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = NSLayoutConstraint.Axis.horizontal
        stack.distribution = UIStackView.Distribution.fillEqually
        stack.alignment = UIStackView.Alignment.center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(saveButtonTap(button:)), for: .touchUpInside)
        return button
    }()
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTap), for: .touchUpInside)
        return button
    }()
    lazy var cleanButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clean", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(cleanButtonTap), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func updateConstraints() {
        bottomButtonsStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        super.updateConstraints()
    }
    
    func addSubviews() {
        bottomButtonsStack.addArrangedSubview(saveButton)
        bottomButtonsStack.addArrangedSubview(cancelButton)
        bottomButtonsStack.addArrangedSubview(cleanButton)
        addSubview(bottomButtonsStack)
    }
    @objc func saveButtonTap(button: UIButton) {
        bottomViewDelegate?.addTextToTextView(saveButton)
    }
    @objc func cancelButtonTap() {
    }
    
    @objc func cleanButtonTap() {
    }
}
