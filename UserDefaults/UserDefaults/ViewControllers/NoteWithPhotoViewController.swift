//
//  NoteWithPhotoViewController.swift
//  UserDefaults
//
//  Created by Daniil Chemaev on 08.12.2022.
//


import UIKit

class NoteWithPhotoViewController: UIViewController {

    private let mockData = MockData()
    public var note: Note?
    public var index: Int?

    private let titleTextField: UITextField = {
        let textField = UITextField.init(frame: .zero)
        textField.placeholder = "Title"
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let saveButton = UIBarButtonItem.init(title: "Save", style: .plain, target: Any?.self, action: #selector(saveButtonDidTap))
    private let addPhotoButton = UIBarButtonItem.init(title: "Add photo", style: .plain, target: Any?.self, action: #selector(addPhotoButtonDidTap))

    @objc func saveButtonDidTap(_ sender: UIButton!) {
        print(3263456)
    }

    @objc func addPhotoButtonDidTap(_ sender: UIButton!) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }

    private var titleStackView = UIStackView()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setConstraints()

        if let note {
            titleTextField.text = note.title
//            noteTextView.text = note.content
        }
    }

    func setupUI() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItems = [saveButton, addPhotoButton]
        view.backgroundColor = .systemGray6

        view.addSubview(imageView)
    }

    func setConstraints() {
        titleStackView = UIStackView(
            arrangedSubviews: [titleTextField]
        )
        titleStackView.axis = .horizontal
        titleStackView.translatesAutoresizingMaskIntoConstraints = false

        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleStackView)

        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),

            imageView.leadingAnchor.constraint(equalTo: titleStackView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: titleStackView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 10),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }

}

extension NoteWithPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)

    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
