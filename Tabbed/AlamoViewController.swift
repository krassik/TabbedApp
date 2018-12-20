import UIKit

class AlamoViewController: UICollectionViewController {

    private lazy var networkController = OVNetworkController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        networkController.fetchAll(url: "https://orangevalleycaa.org/api/videos", completionHandler: { videos in
                print (videos as? [Video] ?? "no info")
        })
        
    }
}

