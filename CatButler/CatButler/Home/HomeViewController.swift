import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrayCat: [FeedModel] = []
    
    let imagePickerViewController = UIImagePickerController()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        let feedNib = UINib(nibName: "FeedTableViewCell", bundle: nil)
        tableView.register(feedNib, forCellReuseIdentifier: "FeedTableViewCell")
        
        let input = FeedAPIInput(limit: 100, page: 10)
        FeedDataManager().feedDataManager(input, self)
        
        imagePickerViewController.delegate = self
    }
    
    @IBAction func buttonGoAlbum(_ sender: UIButton) {
        self.imagePickerViewController.sourceType = .photoLibrary
        self.present(imagePickerViewController, animated: true, completion: nil)
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayCat.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return UITableViewCell()
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as? FeedTableViewCell
            else {
                return UITableViewCell()
            }
            if let urlString = arrayCat[indexPath.row - 1].url {
                let url = URL(string: urlString)
                cell.imageViewFeed.kf.setImage(with: url)
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 10
        } else {
            return 520
        }
    }
}

extension HomeViewController {
    func successAPI(_ result: [FeedModel]) {
        arrayCat = result
        tableView.reloadData()
    }
}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if info[UIImagePickerController.InfoKey.originalImage] is UIImage {
            let imageString = "gs://cat-butler-590ba.appspot.com/cat1.jpg"
            let input = FeedUploadInput(postImgUrl: [imageString])
            FeedUploadDataManager().posts(self, input)

            self.dismiss(animated: true, completion: nil)
        }
    }
}
