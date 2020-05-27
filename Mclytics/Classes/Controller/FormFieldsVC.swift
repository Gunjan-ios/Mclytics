//
//  FormFieldsVC.swift
//  Mclytics
//
//  Created by Krishna  on 21/05/20.
//  Copyright © 2020 Gunjan Raval. All rights reserved.
//

import UIKit
import SwiftyJSON
import MobileCoreServices

class FormFieldsVC: ParentClass,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIDocumentPickerDelegate   {
    
    fileprivate var headerview:UIView!
    fileprivate var buttonBack: UIButton!
    fileprivate var buttonMenu: UIButton!
    fileprivate var yPosition: Int!
    var lblTitle: String!
    fileprivate var scrlView: UIScrollView!

    private var currentPage = 1
    private var totalPage = 1
    
    //
    private var stackView:UIView!
    private var attacheFile:CustomeAttacheFile!
    var imagePicker = UIImagePickerController()
    var picker:UIImagePickerController!

    private var StarRatingView: StarRateView!

    private var signatureView: YPDrawSignatureView!
    private var signClearButton:CustomButton!

    
    fileprivate var importMenuForDocuments:UIDocumentPickerViewController!
    fileprivate var importMenuForImages:UIDocumentPickerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        loadHeaderView()
        setupRatingView()

        signatureView.delegate = self
    }
    
    @objc func goToBack()  {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupRatingView() {
        StarRatingView.delegate = self
        StarRatingView.ratingValue = -1
    }
    
   func loadHeaderView() {
           
           headerview = UIView(frame: CGRect(x: 0, y:( STATUS_BAR_HEIGHT + Int(ParentClass.sharedInstance.iPhone_X_Top_Padding)), width: Int(UIScreen.main.bounds.width), height: NAV_HEADER_HEIGHT));
           headerview.backgroundColor = colorPrimary
           self.view.addSubview(headerview)
           
           self.buttonBack = UIButton(frame: CGRect(x: X_PADDING, y: 0, width:NAV_HEADER_HEIGHT , height: NAV_HEADER_HEIGHT))
           self.buttonBack.setImage(UIImage (named: "back"), for: .normal)
           self.buttonBack.contentHorizontalAlignment = .center
           self.buttonBack.backgroundColor = UIColor.clear
           self.buttonBack.addTarget(self, action: #selector(goToBack), for: .touchUpInside)
           
           headerview.addSubview(self.buttonBack)
           
           self.buttonMenu = UIButton(frame: CGRect(x: X_PADDING*2 + Int(buttonBack.frame.width) , y: 0, width: SCREEN_WIDTH - NAV_HEADER_HEIGHT , height: NAV_HEADER_HEIGHT))
           self.buttonMenu.setTitle(lblTitle, for: .normal)
           self.buttonMenu.contentHorizontalAlignment = .left
           self.buttonMenu.backgroundColor = .clear
           headerview.addSubview(self.buttonMenu)
           
           yPosition = Int(headerview.frame.maxY) + Y_PADDING
           
   //        //save button
   //        let buttonREFRESH = CustomButton(frame: CGRect(x: X_PADDING, y: SCREEN_HEIGHT -  CUSTOM_BUTTON_HEIGHT - X_PADDING, width: SCREEN_WIDTH/2 - (X_PADDING*2), height: CUSTOM_BUTTON_HEIGHT))
   //        buttonREFRESH.setTitle("REFRESH", for: .normal)
   //        buttonREFRESH.addTarget(self, action: #selector(onRefreshPressed), for: .touchUpInside)
   //        self.view.addSubview(buttonREFRESH)
   //
   //        //save button
   //        buttonSave = CustomButton(frame: CGRect(x: SCREEN_WIDTH - SCREEN_WIDTH/2 + X_PADDING , y: SCREEN_HEIGHT -  CUSTOM_BUTTON_HEIGHT - X_PADDING, width: SCREEN_WIDTH/2 - (X_PADDING*2), height: CUSTOM_BUTTON_HEIGHT))
   //        buttonSave.setTitle("GET SELECTED", for: .normal)
   //        buttonSave.setTitleColor(.darkGray, for: .disabled)
   //        buttonSave.backgroundColor = UIColor.lightGray
   //        buttonSave.isEnabled = false
   //        //        buttonSave.addTarget(self, action: #selector(btnSavePressed), for: .touchUpInside)
   //        //        buttonSave.tag = 9999
   //        self.view.addSubview(buttonSave)
   //

    initDesign()

    }
    
    private func initDesign(){
        
        scrlView = UIScrollView (frame: CGRect (x: 0, y: yPosition, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - yPosition))
        scrlView.backgroundColor = .clear
        
        var yposition : Int! = X_PADDING

        let buttonAddImage = CustomTextFieldForAttribute(frame: CGRect(x: X_PADDING, y: yposition, width: SCREEN_WIDTH - X_PADDING*2 , height: CUSTOM_BUTTON_HEIGHT))
        buttonAddImage.imgIcon.image = UIImage(named: "showPasswordIcon")
        buttonAddImage.text = "text field"
        buttonAddImage.tag = TAG11
        scrlView.addSubview(buttonAddImage)
        
        yposition += X_PADDING + CUSTOM_BUTTON_HEIGHT
        
        let genderView = GenderView(frame:  CGRect(x: X_PADDING, y: yposition, width: Int(scrlView.frame.size.width), height: controls_height))
        genderView.initDesign(pName: "Gender", pTag: 6, pOptions: ["Male","Female"])
        scrlView.addSubview(genderView)
        
        yposition += X_PADDING + Int( genderView.bounds.height)
        
        let titleComboBox = CustomComboBoxView(frame: CGRect(x: X_PADDING, y: yposition, width: SCREEN_WIDTH - X_PADDING*2, height: controls_height))
        titleComboBox.initDesign(pName: "selection view", pTag: 12, pOptions: ["Mr","Ms","Mrs"],pPlaceHolder: "")
        scrlView.addSubview(titleComboBox)
        
        
        yposition += X_PADDING + Int( titleComboBox.bounds.height)
        
        let UnitEstablishmentDate = CustomComboBoxView(frame: CGRect(x: X_PADDING, y: yposition, width: Int(scrlView.frame.size.width)  - (X_PADDING * 2), height: controls_height))
        UnitEstablishmentDate.initDesign(pName: "Datefield", pTag: TAG8, pOptions: [],pPlaceHolder: "Select Date")
        UnitEstablishmentDate.setDatePicker()
        scrlView.addSubview(UnitEstablishmentDate)
        
        yposition += X_PADDING + Int( UnitEstablishmentDate.bounds.height)
        
        let districtView = CustomInputTextView(frame: CGRect(x: X_PADDING, y: yposition, width:  SCREEN_WIDTH - X_PADDING*2, height: 125))
        districtView.delegateAppForm = self
        districtView.initDesign(pName: "textview", pTag: 13, pPlaceHolder: "TEst")
        scrlView.addSubview(districtView)
        
        yposition += X_PADDING  + 125

        //Attche file
        let iconImage:UIImage? = UIImage(named: "Fill-Black-Form")
        attacheFile = CustomeAttacheFile(frame: CGRect(x: X_PADDING, y: yposition, width: 110, height: 110))
        self.attacheFile.setTitle("Attachement", for: .normal)
        self.attacheFile.setImage(iconImage, for: .normal)
        self.attacheFile.addTarget(self, action: #selector(openAttchementFile(_:)), for: .touchUpInside)
        scrlView.addSubview(attacheFile)
        
        yposition += X_PADDING + 110
        
        //video file
//        let iconImage1:UIImage? = UIImage(named: "Fill-Black-Form")
       let attacheFile1 = CustomeAttacheFile(frame: CGRect(x: X_PADDING, y: yposition, width: 110, height: 110))
        attacheFile1.setTitle("video", for: .normal)
        attacheFile1.setImage(iconImage, for: .normal)
        attacheFile1.addTarget(self, action: #selector(openCamera), for: .touchUpInside)
        scrlView.addSubview(attacheFile1)
        
        yposition += X_PADDING + 110
        
        //image file
//        let iconImage:UIImage? = UIImage(named: "Fill-Black-Form")
       let attacheFile2 = CustomeAttacheFile(frame: CGRect(x: X_PADDING, y: yposition, width: 110, height: 110))
       attacheFile2.setTitle("image", for: .normal)
        attacheFile2.setImage(iconImage, for: .normal)
       attacheFile2.addTarget(self, action: #selector(openGallary), for: .touchUpInside)
        scrlView.addSubview(attacheFile2)
        
        yposition += X_PADDING + 110

        //Rating view
        
        let vv = UIView(frame: CGRect(x: X_PADDING, y: yposition, width: Int(self.view.frame.size.width) - X_PADDING*2, height: 90))
        vv.layer.cornerRadius = 5
        vv.layer.borderWidth = 1
        vv.layer.borderColor = buttonBorderColor.cgColor
        
        
        let lblSelectChoise = UILabel(frame: CGRect(x: X_PADDING, y: 4, width: Int(self.view.frame.size.width) - 20, height: 28))
        lblSelectChoise.text = "Select a choise"
        
        let line = UIView(frame: CGRect(x: 0, y: Int(lblSelectChoise.frame.size.height) + 6, width: Int(vv.frame.size.width), height: 1))
        line.backgroundColor = buttonBorderColor
        StarRatingView = StarRateView(frame: CGRect(x: X_PADDING, y: 28, width: 160, height: 60))
        
        vv.addSubview(lblSelectChoise)
        vv.addSubview(line)
        vv.addSubview(StarRatingView)
        scrlView.addSubview(vv)
        
        yposition += X_PADDING +  Int( vv.bounds.height)

        //SignatureView
        signatureView = YPDrawSignatureView(frame: CGRect(x: 15, y: CGFloat(yposition), width: view.frame.size.width - 30, height: 200))
        signatureView.backgroundColor = UIColor.clear
        signatureView.layer.cornerRadius = 5
        signatureView.layer.borderWidth = 1
        signatureView.layer.borderColor = buttonBorderColor.cgColor
        scrlView.addSubview(signatureView)
        
        signClearButton = CustomButton(frame: CGRect(x: Int(signatureView.frame.size.width - 70), y: Int(signatureView.frame.size.height - 45), width: 60, height: 32))
        signClearButton.backgroundColor = UIColor.gray
        signClearButton.setTitleColor(.white, for: .normal)
        signClearButton.layer.cornerRadius = 6
        self.signClearButton.setTitle("Clear", for: .normal)
        signClearButton.addTarget(self, action: #selector(signClearPressed), for: .touchUpInside)
        signatureView.addSubview(signClearButton)
        
        //
        yposition += X_PADDING +  Int( signatureView.bounds.height)
        
        self.view.addSubview(scrlView)
        
        scrlView.contentSize = CGSize (width: SCREEN_WIDTH, height: yposition )
    }
    
    @objc func signClearPressed(sender:UIButton) {
        signatureView.clear()
    }
    
    @objc func openAttchementFile(_ sender : UIButton){
        print("open gallery")
        
        
        let types = [kUTTypePDF, kUTTypeText, kUTTypeRTF, kUTTypeSpreadsheet, "com.microsoft.word.doc","org.openxmlformats.wordprocessingml.document"] as [Any]
        
        self.importMenuForDocuments = UIDocumentPickerViewController(documentTypes: types as! [String], in: .import)
        // let importMenu = UIDocumentPickerViewController(documentTypes: [String("public.data")], in: .import)
        self.importMenuForDocuments.delegate = self as? UIDocumentPickerDelegate
        self.importMenuForDocuments.modalPresentationStyle = .formSheet
        self.importMenuForDocuments.view.tag = sender.tag
        self.present(self.importMenuForDocuments, animated: true, completion: nil)
        
        
        
//        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
//            imagePicker.delegate = self
//            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary;
//            //imag.mediaTypes = [kUTTypeImage];
//            imagePicker.mediaTypes = ["public.image", "public.movie"]
//            imagePicker.allowsEditing = false
//            self.present(imagePicker, animated: true, completion: nil)
//        }
    }
    @objc func openCamera()
    {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary)){
            picker = UIImagePickerController()
            picker!.allowsEditing = false
            picker?.delegate = self
//            picker!.sourceType = .photoLibrary
            picker!.mediaTypes = [kUTTypeMovie] as [String]
            self.present(picker!, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
   
    
    @objc func openGallary()
    {
        picker = UIImagePickerController()
        picker!.allowsEditing = false
//        picker.view.tag = pTag
        picker?.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        picker!.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(picker!, animated: true, completion: nil)
    }

    
}

extension FormFieldsVC: RatingViewDelegate ,YPSignatureDelegate {
    func updateRatingFormatValue(_ value: Int) {//for rating view
        print("Rating : = ", value)
    }
    
//    //Image
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        print("selected image")
//        let image = info[.originalImage] as? UIImage
//        self.dismiss(animated: true, completion: nil)
//    }
    
    //Signature
    func didStart(_ view : YPDrawSignatureView) {
        print("Started Drawing")
        scrlView.isScrollEnabled = false
    }
    func didFinish(_ view : YPDrawSignatureView) {
        print("Finished Drawing")
        scrlView.isScrollEnabled = true
    }
   
}
