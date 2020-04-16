import UIKit

protocol ChoseIconDelegate: NSObject {
    func choseIcon(iconString: String)
}

class IconCollectionViewController: UICollectionViewController {

    let iconsData = Database.icons
    weak var delegate: ChoseIconDelegate?
    var chosenIcon: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        setCollection()
    }
    
    func setNavigation() {
        collectionView.backgroundColor = ._app_background
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
    }
    
    func setCollection() {
        self.collectionView!.register(UINib(nibName: "IconCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "IconCollectionViewCell")
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return iconsData.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IconCollectionViewCell", for: indexPath) as! IconCollectionViewCell
    
        cell.setup(iconString: iconsData[indexPath.row])
        cell.normalStatus()
        
        if let icon = chosenIcon {
            if iconsData[indexPath.row] == icon {
                cell.chosenStatus()
            }
        }
        
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.choseIcon(iconString: iconsData[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
}
