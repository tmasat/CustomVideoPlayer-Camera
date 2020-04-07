//
//  VideoSelectorViewController.swift
//  videoPlayer
//
//  Created by Çağrı Tuğberk Masat on 7.04.2020.
//  Copyright © 2020 Çağrı Tuğberk Masat. All rights reserved.
//

import UIKit

class VideoSelectorViewController: UIViewController {
    
    @IBOutlet weak var TableViewList: UITableView!
    let videoNamesArray = ["Video1", "Video2", "Video3", "Video4"]
    let videoUrlListArray = ["http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4", "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4", "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TableViewList.delegate = self
        self.TableViewList.dataSource = self
        self.TableViewList.reloadData()
    }
}

//MARK:- UITableViewDataSource Extension
extension VideoSelectorViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoNamesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.videoNamesText.text = videoNamesArray[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let DvC = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        DvC.getUrl = videoUrlListArray[indexPath.row]
        DvC.getName = videoNamesArray[indexPath.row]
        self.navigationController?.pushViewController(DvC, animated: true)
    }
}
