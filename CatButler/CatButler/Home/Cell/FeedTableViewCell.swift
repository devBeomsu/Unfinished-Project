import UIKit

class FeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewUserProfile: UIImageView!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var imageViewFeed: UIImageView!
    @IBOutlet weak var heartIsEmpty: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var markIsEmpty: UIButton!
    
    @IBAction func heartIsFill(_ sender: UIButton) {
        if heartIsEmpty.isSelected {
            heartIsEmpty.isSelected = false
        } else {
            heartIsEmpty.isSelected = true
        }
    }
    
    @IBAction func markIsFill(_ sender: UIButton) {
        if markIsEmpty.isSelected {
            markIsEmpty.isSelected = false
        } else {
            markIsEmpty.isSelected = true
        }
    }
    
    @IBAction func actionIsShare(_ sender: UIButton) {
//        guard let image = imageViewFeed.transFromToImage() else {
//            return
//        }
//        
//        let vc = UIActivityViewController(activityItems: [image], applicationActivities: nil)
//        vc.excludedActivityTypes = [.saveToCameraRoll]
//        
//        vc.completionWithItemsHandler = { (activity, success, items, error) in
//            if success {
//                print("성공")
//           }  else  {
//               print("실패")
//           }
//        }
//        
//        self.present(vc, animated: true)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

//extension UIView {
//    func transFromToImage() -> UIImage? {
//        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
//        defer {
//            UIGraphicsEndImageContext()
//        }
//        if let context = UIGraphicsGetCurrentContext() {
//            layer.render(in: context)
//            return UIGraphicsGetImageFromCurrentImageContext()
//        }
//            return nil
//    }
//}
