//
//  GISImageDataTypeView.swift
//  TestSpatialite
//
//  Created by Gaurav on 29/08/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import UIKit

enum FileType {
    case Image
    case Document
    case Audio
    case Video
}
/*
    This class is used for Image, document, audio and video
*/
class GISImageDataTypeView: UIView {
    
    var imagesArray = Array<GISDownloadedImage>()
    var deletedImagesArray = Array<GISDownloadedImage>()
    
//    var delegate:InspectionFormViewController!
    var isDelete = false
    var type:FileType!
    private let testColor = UIColor.clear
    private let tagStaticCountForViews = 10000
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func reloadImagesInView() {
        
        var index  = 1;
        var yPosition = 68
        
        for item in imagesArray {
            
//            let smView = self.viewWithTag(index)
            let smView = self.view(withId:String(index + tagStaticCountForViews))
            
            if smView != nil {
                // already added image
                smView?.frame = CGRect(x: 0, y: yPosition, width: Int(self.frame.size.width), height: 50)
                // smView!.tag = index
                
                index += 1
                yPosition += 50
                continue
            } else if self.isDelete {
                // deleted image
                
                index += 1
                
                let smView2 = self.view(withId:String(index + tagStaticCountForViews))
                
                if smView2 != nil {
                    // already added image
                    smView2?.frame = CGRect(x: 0, y: yPosition, width: Int(self.frame.size.width), height: 50)
                    smView2!.tag = (index + tagStaticCountForViews) - 1
                    
                    let btn = smView2?.viewWithTag(index)
                    btn?.tag = index - 1
                    
                    yPosition += 50
                    continue
                }
                
                continue
                
            }
            
            let smallView = UIView(frame: CGRect(x: 0, y: yPosition, width: Int(self.frame.size.width), height: 50))
            smallView.tag = index + tagStaticCountForViews
            
            let imgIcon = UIImageView(frame: CGRect(x: 10, y: 5, width: 40, height: 40))
            imgIcon.backgroundColor = UIColor.clear
            if self.type == FileType.Image {
                print(item.path!)
                imgIcon.image = UIImage(contentsOfFile: item.path!)
            } else if self.type == FileType.Document {
                imgIcon.image = UIImage(named: DATATYPE_DOCUMENT_ICON)
            } else if self.type == FileType.Audio {
                imgIcon.image = UIImage(named: DATATYPE_AUDIO_ICON)
            } else if self.type == FileType.Video {
                imgIcon.image = UIImage(named: DATATYPE_VIDEO_ICON)
            }
            
            smallView.addSubview(imgIcon)
            
            let lblName = UILabel(frame: CGRect(x: 60, y: 13, width: Int(self.frame.size.width - (60 + 100 + 50)), height: 24))
            lblName.text = item.name
            lblName.textColor = UIColor.black
            lblName.textAlignment = .left
            lblName.backgroundColor = testColor
            lblName.font = UIFont(name:HEADER_LABEL_FONT_NAME, size: 10)
            smallView.addSubview(lblName)
            
            let lblSize = UILabel(frame: CGRect(x: Int(self.frame.size.width - (80 + 50)), y: 13, width: 80, height: 24))
            lblSize.text = item.size
            lblSize.textColor = UIColor.black
            lblSize.textAlignment = .right
            lblSize.backgroundColor = testColor
            lblSize.font = UIFont(name:HEADER_LABEL_FONT_NAME, size: 10)
            smallView.addSubview(lblSize)
            
            let simpleProgress = UIProgressView()
            print("height \(simpleProgress.frame.height)")
            
            simpleProgress.frame = CGRect(x: 60, y: 40, width: Int(self.frame.size.width - (60 + 50)), height: 24)
            simpleProgress.progress = 1.0
            smallView.addSubview(simpleProgress)
            
            let buttonCancel = UIButton(frame: CGRect(x: Int(self.frame.size.width - 50), y: 5, width: 40, height: 40))
            buttonCancel.setImage(UIImage(named: "cancelButton"), for: .normal)
            buttonCancel.setTitleColor(UIColor.black, for: .normal)
            buttonCancel.backgroundColor = UIColor.clear
            buttonCancel.tag = index
            buttonCancel.addTarget(self, action: #selector(cancelBtnPressed(sender:)), for: .touchUpInside)
            smallView.addSubview(buttonCancel)
            
            self.addSubview(smallView)
            
            index += 1
            yPosition += 50
        }
        
    }
    
    @objc func cancelBtnPressed(sender:UIButton) {

        let imageItem = self.imagesArray[(sender.tag-1)]

        if imageItem.isFromTable == true {
            // not from edit from
            self.deletedImagesArray.append(imageItem)

        } else {
            // add form
            let filemanager = FileManager.default

            // delete / remove image from folder
            do {

                let fileManager = FileManager.default
                if let tDocumentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {

                    // check layer id folder name
                    let layerPath =  tDocumentDirectory.appendingPathComponent("\(101)")

                    if self.type == FileType.Image {
                        let imageFolderPath =  layerPath.appendingPathComponent("\(IMAGES_FOLDER_NAME)")
                        let imagePath =  imageFolderPath.appendingPathComponent("\(imageItem.name!)")
                        print("deleted \(imagePath.path)")
                        try filemanager.removeItem(atPath: imagePath.path)

                    } else if self.type == FileType.Document {

                        let imageFolderPath =  layerPath.appendingPathComponent("\(DOCUMENTS_FOLDER_NAME)")
                        let imagePath =  imageFolderPath.appendingPathComponent("\(imageItem.name!)")
                        print("deleted \(imagePath.path)")
                        try filemanager.removeItem(atPath: imagePath.path)

                    } else if self.type == FileType.Audio {

                        let imageFolderPath =  layerPath.appendingPathComponent("\(AUDIO_FOLDER_NAME)")
                        let imagePath =  imageFolderPath.appendingPathComponent("\(imageItem.name!)")
                        print("deleted \(imagePath.path)")
                        try filemanager.removeItem(atPath: imagePath.path)

                    } else if self.type == FileType.Video {

                        let imageFolderPath =  layerPath.appendingPathComponent("\(VIDEO_FOLDER_NAME)")
                        let imagePath =  imageFolderPath.appendingPathComponent("\(imageItem.name!)")
                        print("deleted \(imagePath.path)")
                        try filemanager.removeItem(atPath: imagePath.path)

                    }

                }


            } catch {
                NSLog("Couldn't delete image")
            }

            // delete image from database
//            Layer_MultiMedia.deleteImageOrDocumentData(pImageName: imageItem.name!)

        }


        // remove from view /  screen
        let smView = self.view(withId: String(sender.tag + tagStaticCountForViews))
//        print("deleted img view \(smView?.tag)")
        smView?.removeFromSuperview()

        // remove from array
        self.imagesArray.remove(at: (sender.tag-1))

        if self.imagesArray.count > 0 {
            self.isDelete = true
        }

        // reload
//        self.delegate.reloadForm()
    }
    
    
    
}

