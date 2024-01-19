//
//  ViewController.swift
//  BitenTechincalTask
//
//  Created by Александр Кузьминов on 11.01.24.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UISearchBarDelegate {
    private let layout = HomeLayout()
    private let vm = NatureViewModel()
    
    private var searchBar = UISearchBar()
        lazy var buttonShow:UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
            button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        button.setImage(UIImage(named: "search"), for: .normal)
        return button
    }()
    lazy var chemistry: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Болезни"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    lazy var collectionNature: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.alwaysBounceVertical = false
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsVerticalScrollIndicator = false
        collection.alwaysBounceHorizontal = false
        collection.isScrollEnabled = true
        return collection
    }()
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 111/255, green: 181/255, blue: 75/255, alpha: 1)
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupUI()
        setupLayout()
        vm.resetID()
        loadData()
    }
   
    func loadData() {
        vm.loadMultipleData { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self?.collectionNature.reloadData()
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(backView)
        collectionNature.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "main")
        collectionNature.collectionViewLayout = layout.natureLayout()
        collectionNature.delegate = self
        collectionNature.dataSource = self
        view.addSubview(collectionNature)
        backView.addSubview(chemistry)
        backView.addSubview(buttonShow)
        searchBar.delegate = self
        searchBar.isHidden = true
        view.addSubview(searchBar)
    }
    @objc func searchButtonTapped() {
      
       
            searchBar.isHidden = true
            searchBar.becomeFirstResponder()
        }

        // MARK: - UISearchBarDelegate

        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.isHidden = true
            searchBar.text = nil
            searchBar.resignFirstResponder()
        }

        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            // Обработка нажатия на кнопку "Поиск" (по вашей логике)
            // Здесь вы можете выполнять поиск и обновлять данные в вашем интерфейсе
        }
    func setupSearchBar() {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 16, weight: .regular) as Any
        ]
        searchBar.searchBarStyle = .default
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchTextField.layer.cornerRadius = 18
        searchBar.searchTextField.layer.masksToBounds = true
        searchBar.searchTextField.backgroundColor = UIColor(red: 111/255, green: 181/255, blue: 75/255, alpha: 1)
        searchBar.barTintColor = UIColor(red: 111/255, green: 181/255, blue: 75/255, alpha: 1)
        searchBar.searchTextField.borderStyle = .none
        searchBar.searchTextField.layer.borderWidth = 1
        searchBar.searchTextField.layer.borderColor = UIColor.black.cgColor
        searchBar.searchTextField.tintColor = .white
        searchBar.searchTextField.textColor = .white
        searchBar.tintColor = .white
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Find company or ticker", attributes: attributes)
        searchBar.backgroundColor = .clear
        searchBar.showsCancelButton = false
        searchBar.clearsContextBeforeDrawing = true
    }
//    let attributes: [NSAttributedString.Key: Any] = [
//        .foregroundColor: UIColor(red: 161/255, green: 161/255, blue: 161/255, alpha: 1),
//        .font: UIFont.systemFont(ofSize: 17, weight: .semibold)]
//    searchBar.searchBarStyle = .minimal
//    searchBar.backgroundColor = UIColor(red: 242/255, green: 229/255, blue: 230/255, alpha: 1)
//    searchBar.layer.cornerRadius = 0
//    searchBar.layer.masksToBounds = false
//    searchBar.clipsToBounds = true
//    searchBar.translatesAutoresizingMaskIntoConstraints = false
//    searchBar.searchTextField.translatesAutoresizingMaskIntoConstraints = false
//    searchBar.searchTextField.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1)
//    searchBar.searchTextField.layer.cornerRadius = 15
//    searchBar.searchTextField.layer.borderWidth = 1.5
//
//    searchBar.searchTextField.layer.borderColor = CGColor(red: 0.2, green: 0.11, blue: 0.16, alpha: 1)
//    searchBar.searchTextField.layer.masksToBounds = true
//    searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search for a recipe...", attributes: attributes)
//    searchBar.searchTextField.textColor = .black
//    searchBar.showsCancelButton = false
//    searchBar.backgroundColor = .clear
//    searchBar.barTintColor = UIColor(red: 242/255, green: 229/255, blue: 230/255, alpha: 1)
//    searchBar.layer.borderColor = CGColor(red: 242/255, green: 229/255, blue: 230/255, alpha: 1)
//    searchBar.layer.borderWidth = 0
    func setupLayout() {
        backView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
        }
        collectionNature.snp.makeConstraints { make in
            make.top.equalTo(backView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-32)
        }
        chemistry.snp.makeConstraints { make in
            make.bottom.equalTo(backView).offset(-5)
            make.height.equalTo(20)
            make.left.right.equalToSuperview().inset(50)
        }
        buttonShow.snp.makeConstraints { make in
            make.bottom.equalTo(backView).offset(-5)
            make.right.equalToSuperview().offset(-10)
            make.height.width.equalTo(34)
        }
        searchBar.snp.makeConstraints { make in
            make.bottom.equalTo(backView).offset(-15)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(44)
        }
    }
}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastElementIndex = vm.dataModel.count - 1
        let preloadIndex = max(lastElementIndex - 1, 0)
        
        if indexPath.item >= preloadIndex {
            loadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.numberOfRows()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "main", for: indexPath) as? MainCollectionViewCell else { fatalError("Error main collection") }
        cell.setValue(model: vm.getCats(index: indexPath.row))
        return cell
    }
}
