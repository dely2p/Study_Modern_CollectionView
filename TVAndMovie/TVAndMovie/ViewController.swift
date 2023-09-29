//
//  ViewController.swift
//  TVAndMovie
//
//  Created by elly on 2023/09/28.
//

import UIKit
import SnapKit
import RxSwift

// Layout 기준
enum Section: Hashable {
    case double
}

// Cell 기준
enum Item: Hashable {
    case normal(TV)
}

class ViewController: UIViewController {

    let buttonView = ButtonView()
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.register(NormalCollectionViewCell.self, forCellWithReuseIdentifier: NormalCollectionViewCell.id)
        return collectionView
    }()
    
    let viewModel = ViewModel()
    
    let disposeBag = DisposeBag()
    let tvTrigger = PublishSubject<Void>()
    let movieTrigger = PublishSubject<Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bindViewModel()
        bindView()
        tvTrigger.onNext(())
    }

    private func setUI() {
        self.view.addSubview(buttonView)
        self.view.addSubview(collectionView)
        
        buttonView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(80)
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(buttonView.snp.bottom)
        }
    }
    
    private func bindViewModel() {
        let input = ViewModel.Input(tvTrigger: tvTrigger.asObserver(), movieTrigger: movieTrigger.asObserver())
        let output = viewModel.transform(input: input)
        output.tvList.bind { tvList in
            print("TV \(tvList)")
        }.disposed(by: disposeBag)
        output.movieList.bind { movieResult in
            print("Movie \(movieResult)")
        }.disposed(by: disposeBag)
    }
    
    private func bindView() {
        buttonView.tvButton.rx.tap.bind { [weak self] in
            self?.tvTrigger.onNext(Void())
        }.disposed(by: disposeBag)
        
        buttonView.movieButton.rx.tap.bind { [weak self] in
            self?.movieTrigger.onNext(Void())
        }.disposed(by: disposeBag)
    }
}

