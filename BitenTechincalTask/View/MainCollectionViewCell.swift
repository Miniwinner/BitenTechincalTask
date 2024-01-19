//
//  MainCollectionViewCell.swift
//  BitenTechincalTask
//
//  Created by Александр Кузьминов on 11.01.24.
//

import UIKit
import SnapKit
class MainCollectionViewCell: UICollectionViewCell {
    lazy var favouriteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "Edit"), for: .normal)
        return button
    }()
    lazy var natureImage: CustomImageView = {
        let image = CustomImageView()
        image.backgroundColor = .clear
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    lazy var imageType: CustomImageView = {
        let image = CustomImageView()
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFit
        return image
    }()
    lazy var headerNature: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.backgroundColor = .clear
        return label
    }()
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.683, green: 0.691, blue: 0.712, alpha: 1)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.backgroundColor = .clear
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setValue(model: CustomModel) {
        headerNature.text = model.name
        natureImage.load(urlString: model.image)
        descriptionLabel.text = model.description
        imageType.load(urlString: model.type)
    }
    func setupUI() {
        backgroundColor = .white
        self.addSubview(natureImage)
        self.addSubview(headerNature)
        self.addSubview(descriptionLabel)
        self.addSubview(imageType)
        addSubview(favouriteButton)
        let shadows = UIView()
        shadows.frame = self.frame
        shadows.clipsToBounds = false
        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 8)
        self.layer.shadowPath = shadowPath0.cgPath
        self.layer.shadowColor = UIColor(red: 0.282, green: 0.298, blue: 0.298, alpha: 0.15).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 0, height: 0)

    }
    func setupLayout() {
        natureImage.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(150)
        }
        headerNature.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(20)
            make.bottom.equalTo(descriptionLabel.snp.top)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-3)
        }
        imageType.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(22)
            make.width.equalTo(22)
            make.bottom.equalTo(headerNature.snp.top).offset(-15)
        }
        favouriteButton.snp.makeConstraints { make in
            make.bottom.equalTo(headerNature.snp.top).offset(-15)
            make.trailing.equalToSuperview().offset(-12)
            make.height.equalTo(22)
            make.width.equalTo(22)
        }
    }
}
