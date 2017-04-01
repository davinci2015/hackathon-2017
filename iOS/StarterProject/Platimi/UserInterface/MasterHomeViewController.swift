//
//  MasterHomeViewController.swift
//  Platimi
//
//  Created by Božidar on 31/03/2017.
//  Copyright © 2017 Božidar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MasterHomeViewController: UIViewController {

    fileprivate var mode: Mode?
    fileprivate var navigationService: NavigationService?
    @IBOutlet weak var collectionView: UICollectionView!
    private let disposeBag = DisposeBag()

    @IBOutlet weak var image: UIImageView!

    convenience init(mode: Mode, navigationService: NavigationService) {
        self.init()
        self.mode = mode
        self.navigationService = navigationService
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()

        navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(self.backTapped))

    }

    func backTapped(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: false)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let layout = collectionView.collectionViewLayout as? MasterViewLayout {
            layout.invalidateLayout()
        }
    }

    

    private func setupCollectionView() {
        collectionView.collectionViewLayout = MasterViewLayout()


        let nib = UINib(nibName: String(describing: ItemCollectionViewCell.self), bundle: nil)

        collectionView.register(nib, forCellWithReuseIdentifier: String(describing: ItemCollectionViewCell.self))

         collectionView.isPagingEnabled = true

        collectionView.rx.contentOffset.subscribe(onNext: { [weak self] offset in
            self?.collectionView.collectionViewLayout.invalidateLayout()
        }).addDisposableTo(disposeBag)

        collectionView.delegate = self
        collectionView.dataSource = self
    }



}

extension MasterHomeViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if mode == .story {
            self.navigationService?.pushStory()
        } else {
            if indexPath.section == 0 {
                navigationService?.pushQuizFirst()
            } else if indexPath.section == 1 {
                navigationService?.pushMemory()
            }
            // push quiz, za prvu sekciju bilo koji item odaberi kviz... za drugu sekciju bilo koji item odaberi memory
        }

        print("tapped item at: \(indexPath)")
    }
}

extension MasterHomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ItemCollectionViewCell.self), for: indexPath) as! ItemCollectionViewCell

        cell.setup(index: indexPath.row + 1, section: indexPath.section)
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }


}
