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
import ReCaptcha
import RxCocoa
import RxSwift

class FormFieldsVC: ParentClass,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIDocumentPickerDelegate   {
    
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
    var type : String?
    var arrayList : JSON!
    var arrayfield : JSON!
    var answerfield : [JSON] = [JSON]()
    var tempAraay : [JSON] = [JSON]()
    var editData : [JSON] = [JSON]()
    
    private var StarRatingView: StarRateView!

    private var signatureView: YPDrawSignatureView!
    private var signClearButton:CustomButton!

    
    fileprivate var importMenuForDocuments:UIDocumentPickerViewController!
    fileprivate var importMenuForImages:UIDocumentPickerViewController!
    
    
    //krishna code

    @IBOutlet weak var scrollSideBySide: UIScrollView!
    @IBOutlet weak var vSideBySide: UIView!
    @IBOutlet weak var btnSide1: UIButton!
    @IBOutlet weak var btnSide2: UIButton!
    @IBOutlet weak var btnSide3: UIButton!
    @IBOutlet weak var btnSide4: UIButton!
    @IBOutlet weak var btnSide5: UIButton!
    @IBOutlet weak var btnSide6: UIButton!
    @IBOutlet weak var btnSide7: UIButton!
    @IBOutlet weak var btnSide8: UIButton!
    @IBOutlet weak var btnSide9: UIButton!
    @IBOutlet weak var btnSide10: UIButton!
    @IBOutlet weak var lblLeftName: UILabel!
    @IBOutlet weak var lblRightName: UILabel!

    @IBOutlet weak var vSliderSelection: UIView!
    @IBOutlet weak var sliderSelection: UISlider!

    //captch
    private struct Constants {
        static let webViewTag = 123
        static let testLabelTag = 321
    }
    
    private var recaptcha: ReCaptcha!
    private var disposeBag = DisposeBag()
    private var locale: Locale?
    private var endpoint = ReCaptcha.Endpoint.default
    
    @IBOutlet weak var visibleChallengeSwitch: UISwitch!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    private weak var endpointSegmentedControl: UISegmentedControl!

    @IBOutlet weak var vCaptcha: UIControl!
    
    var name : String = ""
    var slug : String = ""
    var created : Double = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if type == "Edit"{
            arrayfield = arrayList["fields"]
            
            for tampAry1 in arrayfield.arrayValue{
                self.tempAraay.append(tampAry1)
            }
            name =  arrayList["data"]["name"].stringValue
            slug =  arrayList["data"]["slug"].stringValue
            created = arrayList["data"]["created_at"].doubleValue
        }
        else{
            arrayfield = arrayList["fields"]
            
            for tampAry1 in arrayfield.arrayValue{
                var tamp : JSON = JSON()
                tamp = tampAry1
                tamp["Ans"].string = ""
                self.tempAraay.append(tamp)
            }
            name =  arrayList["name"].stringValue
            slug =  arrayList["slug"].stringValue
            created = arrayList["created_at"].doubleValue
        }
    
    
//        let params : JSON = ["data": ["name":name,"slug":slug,"created_at":created],"fields": self.tempAraay]
//
//        answerfield.append(params)
//        print(answerfield)

        loadHeaderView()
        dataSetupformAPI()
        
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
        
    }
    
    
    func dataSetupformAPI() {
        
        scrlView = UIScrollView (frame: CGRect (x: 0, y: yPosition, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - yPosition))
        scrlView.backgroundColor = .white
        
        var yposition : Int! = X_PADDING
        
        for var object in tempAraay{
            
//            let data = Field.init(fromJson: object)
            
            let dataType = object["type"].stringValue
            
            if dataType == DATATYPE_HEADING{
                
                let buttonAddImage = CustomLabel(frame: CGRect(x: X_PADDING, y: yposition, width: SCREEN_WIDTH - X_PADDING*2 , height: CUSTOM_BUTTON_HEIGHT))
                buttonAddImage.text = object["text"].stringValue
                buttonAddImage.tag = TAG1
                scrlView.addSubview(buttonAddImage)
                
                yposition += X_PADDING + CUSTOM_BUTTON_HEIGHT
                
            } else if dataType == DATATYPE_PARAGRAPH {
                
                let txtField = InsideTextView (frame: CGRect (x: X_PADDING, y: yposition , width: SCREEN_WIDTH - X_PADDING*2 , height: 100))
                txtField.text =  object["text"].stringValue
                txtField.attributedText = txtField.text.htmlToAttributedString
                txtField.isUserInteractionEnabled = false
                scrlView.addSubview(txtField)
                
                yposition += X_PADDING + Int(txtField.bounds.height)
         
            } else if dataType == DATATYPE_TEXT {
                
                let name = CustomInputFieldView(frame: CGRect(x: X_PADDING, y: yposition, width: SCREEN_WIDTH - X_PADDING*2 , height: controls_height))
                name.delegateAppForm = self
                name.initDesign(pName: object["label"].stringValue.htmlToString , pTag: UploadTAG109, pPlaceHolder: object["placeholder"].stringValue, str_id: object["id"].stringValue)
                print(object["Ans"].stringValue)
                name.txtField.text =  object["Ans"].stringValue
                scrlView.addSubview(name)
                
                yposition += X_PADDING + Int(name.bounds.height)
           
            } else if dataType == DATATYPE_Email{
                
                let email = CustomInputFieldView(frame: CGRect(x: X_PADDING, y: yposition, width: SCREEN_WIDTH - X_PADDING*2 , height: controls_height))
                email.initDesign(pName: object["label"].stringValue.htmlToString, pTag: TAG4, pPlaceHolder: object["placeholder"].stringValue, str_id: object["id"].stringValue)
                email.delegateAppForm = self
                email.txtField.keyboardType = .emailAddress
                scrlView.addSubview(email)
                    
              yposition += X_PADDING + Int(email.bounds.height)
            
            } else if dataType == DATATYPE_PHONE{
            let phone = CustomInputFieldView(frame: CGRect(x: X_PADDING, y: yposition, width: SCREEN_WIDTH - X_PADDING*2 , height: controls_height))
                phone.initDesign(pName: object["label"].stringValue.htmlToString, pTag: TAG4, pPlaceHolder: object["placeholder"].stringValue, str_id: object["id"].stringValue)
            phone.delegateAppForm = self
            phone.txtField.keyboardType = .phonePad
            scrlView.addSubview(phone)
            yposition += X_PADDING + Int(phone.bounds.height)

            } else if dataType == DATATYPE_TEXTAREA{
                
                let districtView = CustomInputTextView(frame: CGRect(x: X_PADDING, y: yposition, width:  SCREEN_WIDTH - X_PADDING*2, height: 125))
                districtView.delegateAppForm = self
                districtView.initDesign(pName:  object["label"].stringValue.htmlToString, pTag: 13, pPlaceHolder: object["predefinedValue"].stringValue)
                scrlView.addSubview(districtView)
                
                yposition += X_PADDING  + 125
                
            }else if dataType == DATATYPE_DATE{
                
                let UnitEstablishmentDate = CustomComboBoxView(frame: CGRect(x: X_PADDING, y: yposition, width: Int(scrlView.frame.size.width)  - (X_PADDING * 2), height: controls_height))
                UnitEstablishmentDate.initDesign(pName:object["label"].stringValue.htmlToString, pTag: TAG8, pOptions: [],pPlaceHolder: object["placeholder"].stringValue)
                UnitEstablishmentDate.setDatePicker()
                scrlView.addSubview(UnitEstablishmentDate)
                
                yposition += X_PADDING + Int( UnitEstablishmentDate.bounds.height)
                
            }else if dataType == DATATYPE_SELECTLIST{
                
                let titleComboBox = CustomComboBoxView(frame: CGRect(x: X_PADDING, y: yposition, width: SCREEN_WIDTH - X_PADDING*2, height: controls_height))
                var strOption : [String] = [String]()
                for (_, value) in object["options"] {
                    strOption.append(value["label"].stringValue)
                }
                titleComboBox.initDesign(pName: object["label"].stringValue.htmlToString, pTag: 12, pOptions: strOption,pPlaceHolder: "")
                scrlView.addSubview(titleComboBox)

                yposition += X_PADDING + Int( titleComboBox.bounds.height)
                
            }else if dataType == DATATYPE_RADIO{
                
                let genderView = GenderView(frame:  CGRect(x: X_PADDING, y: yposition, width: Int(scrlView.frame.size.width) - X_PADDING*2, height: controls_height))
                var strOption : [String] = [String]()
                for (_, value) in object["options"] {
                    strOption.append(value["label"].stringValue)
                }
                genderView.initDesign(pName:object["label"].stringValue.htmlToString, pTag: 6, pOptions: strOption)
                genderView.frame = genderView.resetHeight()
                genderView.layer.cornerRadius = radius
                genderView.layer.borderWidth = borderWidth
                genderView.layer.borderColor =  UIColor.lightGray.cgColor
                scrlView.addSubview(genderView)

                yposition += X_PADDING + Int( genderView.bounds.height)
         
            }else if dataType == DATATYPE_CHECKBOX{
                
                let multiple = MarginSelectView(frame:  CGRect(x: X_PADDING, y: yposition, width: Int(scrlView.frame.size.width) - X_PADDING*2, height: controls_height))
                var strOption : [String] = [String]()
                for (_, value) in object["options"] {
                    strOption.append(value["label"].stringValue)
                }
                multiple.initDesign(pName: object["label"].stringValue.htmlToString, pTag: 122, pOptions: strOption)
                multiple.frame = multiple.resetHeight()
                multiple.layer.cornerRadius = radius
                multiple.layer.borderWidth = borderWidth
                multiple.layer.borderColor =  UIColor.lightGray.cgColor
                scrlView.addSubview(multiple)
                
                yposition += X_PADDING + Int( multiple.bounds.height)
                
            }else if dataType == DATATYPE_RANKINGSCALE{
                
                var strOption : [String] = [String]()
                
                let ranks = object["ranks"].intValue
               
                for n in 1...ranks {
                    strOption.append("\(n)")
                }
                
                let title = PaddingLabel (frame: CGRect (x: X_PADDING, y: yposition, width: SCREEN_WIDTH - X_PADDING*2, height: 25))
                title.text = object["label"].stringValue.htmlToString
                title.font = UIFont(name: APP_FONT_NAME, size: 17)
                title.textColor = colorSubHeading_76
                let rectShape = CAShapeLayer()
                rectShape.path = UIBezierPath(roundedRect: title.bounds, byRoundingCorners: [ .topRight , .topLeft], cornerRadii: CGSize(width: radius, height: radius)).cgPath
                rectShape.strokeColor = UIColor.lightGray.cgColor
                rectShape.fillColor = UIColor.clear.cgColor
                rectShape.lineWidth = borderWidth
                rectShape.frame = title.bounds
                title.layer.mask =   rectShape
                title.layer.addSublayer(rectShape)
                scrlView.addSubview(title)
                
                yposition +=  Int( title.bounds.height)
                
                let vv1 = UIView(frame: CGRect(x: X_PADDING, y: yposition, width: Int(self.view.frame.size.width) - X_PADDING*2, height: 90))
                vv1.layer.cornerRadius = radius
                vv1.layer.borderWidth = borderWidth
                vv1.layer.borderColor = buttonBorderColor.cgColor
                
                var y_Internal_position : Int! = X_PADDING

                for (_, value) in object["options"] {
             
                   let  titleComboBox = RankingView(frame: CGRect(x: X_PADDING, y: y_Internal_position, width: Int(scrlView.frame.size.width) - X_PADDING*2 , height: 35))
                    titleComboBox.initDesign(pName: value["label"].stringValue, pTag: TAG18, pOptions: strOption,pPlaceHolder: "")
                    vv1.addSubview(titleComboBox)
                    
                    y_Internal_position +=  X_PADDING +  Int( titleComboBox.bounds.height)
                }
                
                let optionsCount = object["options"].count
                vv1.frame =  CGRect(x: X_PADDING, y: yposition, width: Int(self.view.frame.size.width) - X_PADDING*2, height: 35*optionsCount + X_PADDING*(optionsCount+1))
                scrlView.addSubview(vv1)
                
                yposition +=  X_PADDING +  Int( vv1.bounds.height)

            }
            else if dataType == DATATYPE_SIDEBYSIDE{
                //controller SidebySide
                vSideBySide.frame = CGRect(x: X_PADDING, y: yposition, width: Int(self.view.frame.size.width) - X_PADDING*2, height: 128)
                vSideBySide.layer.borderColor = UIColor.lightGray.cgColor
                vSideBySide.layer.borderWidth = borderWidth
                vSideBySide.layer.cornerRadius = radius
                scrollSideBySide.showsHorizontalScrollIndicator = false
                scrollSideBySide.showsVerticalScrollIndicator = false
                scrollSideBySide.contentSize = CGSize(width: vSideBySide.frame.size.width, height: 60)
                scrlView.addSubview(vSideBySide)
                
                sideBySideDisplay(display: object["ranks"].intValue, leftName: object["side1"].stringValue, rightName: object["side2"].stringValue)
                
                yposition += X_PADDING +  Int(vSideBySide.bounds.height)
                
                
            }else if dataType == DATATYPE_RATING{
                //Rating view
                 let inputType = object["inputType"].stringValue
                
                var strOption : [String] = [String]()
                for (_, value) in object["options"] {
                    strOption.append(value["label"].stringValue)
                }
                if inputType == "star" {
                    
                    let vv = UIView(frame: CGRect(x: X_PADDING, y: yposition, width: Int(self.view.frame.size.width) - X_PADDING*2, height: 90))
                    vv.layer.cornerRadius = radius
                    vv.layer.borderWidth = borderWidth
                    vv.layer.borderColor = buttonBorderColor.cgColor
                    
                    let lblSelectChoise = PaddingLabel(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.size.width) - X_PADDING, height: 29))
                    lblSelectChoise.text = object["label"].stringValue.htmlToString
                    lblSelectChoise.font = UIFont(name: APP_FONT_NAME, size: 17)
                    lblSelectChoise.textColor = colorSubHeading_76
                    
                    let line = UIView(frame: CGRect(x: 0, y: Int(lblSelectChoise.bounds.height), width: Int(vv.frame.size.width), height: 1))
                    line.backgroundColor = buttonBorderColor
                    
        
                    StarRatingView = StarRateView(frame: CGRect(x: X_PADDING, y: 40, width: 40, height: 40))
                    StarRatingView.maxCount = strOption.count
                    vv.addSubview(lblSelectChoise)
                    vv.addSubview(line)
                    vv.addSubview(StarRatingView)
                    scrlView.addSubview(vv)
                    StarRatingView.frame = CGRect (x: X_PADDING, y: 40, width: 40*strOption.count, height: 40)
                    yposition += X_PADDING +  Int( vv.bounds.height)
                    
                    setupRatingView()
                }
                else{
                    //Slider selection
                    vSliderSelection.frame = CGRect(x: X_PADDING, y: yposition, width: Int(self.view.frame.size.width) - X_PADDING*2, height: 100)
                    vSliderSelection.layer.borderColor = UIColor.lightGray.cgColor
                    vSliderSelection.layer.borderWidth = borderWidth
                    vSliderSelection.layer.cornerRadius = radius

                    scrlView.addSubview(vSliderSelection)
                    
                    yposition += X_PADDING +  Int(vSliderSelection.bounds.height)
                }

            }else if dataType == DATATYPE_IMAGE{
                
                //image file
                        let iconImage:UIImage? = UIImage(named: "Fill-Black-Form")
                let attacheFile2 = CustomeAttacheFile(frame: CGRect(x: X_PADDING, y: yposition, width: 110, height: 110))
                attacheFile2.setTitle(object["label"].stringValue.htmlToString, for: .normal)
                attacheFile2.setImage(iconImage, for: .normal)
                attacheFile2.addTarget(self, action: #selector(openGallary), for: .touchUpInside)
                scrlView.addSubview(attacheFile2)
                
                yposition += X_PADDING + 110
            }else if dataType == DATATYPE_VIDEO{
                //video file
                let iconImage1:UIImage? = UIImage(named: "Fill-Black-Form")
                let attacheFile1 = CustomeAttacheFile(frame: CGRect(x: X_PADDING, y: yposition, width: 110, height: 110))
                attacheFile1.setTitle(object["label"].stringValue.htmlToString, for: .normal)
                attacheFile1.setImage(iconImage1, for: .normal)
                attacheFile1.addTarget(self, action: #selector(openCamera), for: .touchUpInside)
                scrlView.addSubview(attacheFile1)
                
                yposition += X_PADDING + 110
            }else if dataType == DATATYPE_FILE{
                //Attche file
                let iconImage:UIImage? = UIImage(named: "Fill-Black-Form")
                attacheFile = CustomeAttacheFile(frame: CGRect(x: X_PADDING, y: yposition, width: 110, height: 110))
                self.attacheFile.setTitle(object["label"].stringValue.htmlToString, for: .normal)
                self.attacheFile.setImage(iconImage, for: .normal)
                self.attacheFile.addTarget(self, action: #selector(openAttchementFile(_:)), for: .touchUpInside)
                scrlView.addSubview(attacheFile)
                
                yposition += X_PADDING + 110

            }else if dataType == DATATYPE_SIGNATURE{
                
                //SignatureView

                signatureView = YPDrawSignatureView(frame:CGRect(x: X_PADDING, y: yposition, width: Int(self.view.frame.size.width) - X_PADDING*2, height: 200))
                signatureView.backgroundColor = UIColor.clear
                signatureView.layer.cornerRadius = radius
                signatureView.layer.borderWidth = borderWidth
                signatureView.layer.borderColor = buttonBorderColor.cgColor
                scrlView.addSubview(signatureView)
                
                signClearButton = CustomButton(frame: CGRect(x: Int(signatureView.frame.size.width - 70), y: Int(signatureView.frame.size.height - 45), width: 60, height: 32))
                signClearButton.backgroundColor = UIColor.gray
                signClearButton.setTitleColor(.white, for: .normal)
                signClearButton.layer.cornerRadius = radius
                self.signClearButton.setTitle("Clear", for: .normal)
                signClearButton.addTarget(self, action: #selector(signClearPressed), for: .touchUpInside)
                signatureView.addSubview(signClearButton)
                
                signatureView.delegate = self
                
                yposition += X_PADDING +  Int( signatureView.bounds.height)
                
            }else if dataType == DATATYPE_RECAPTCHA{
                
                //Captch
                vCaptcha.frame = CGRect(x: X_PADDING, y: yposition, width: Int(self.view.frame.size.width) - X_PADDING*2, height: 90)
                vCaptcha.layer.borderColor = UIColor.lightGray.cgColor
                vCaptcha.layer.borderWidth = 1
                vCaptcha.layer.cornerRadius = 4
                scrlView.addSubview(vCaptcha)
                
                setupReCaptcha()
                
                yposition += X_PADDING +  Int( vCaptcha.bounds.height)
            }
    }
        let buttonREFRESH = CustomButton(frame: CGRect(x: X_PADDING, y: yposition, width: SCREEN_WIDTH - (X_PADDING*2), height: CUSTOM_BUTTON_HEIGHT))
        buttonREFRESH.setTitle("SUBMIT", for: .normal)
        //            buttonREFRESH.addTarget(self, action: #selector(onRefreshPressed), for: .touchUpInside)
        scrlView.addSubview(buttonREFRESH)
        self.view.addSubview(scrlView)
        
        yposition += X_PADDING +  Int( buttonREFRESH.bounds.height)

        scrlView.contentSize = CGSize (width: SCREEN_WIDTH, height: yposition )

    }
    @objc func goToBack()  {
        
        let params : JSON = ["data": ["name":name,"slug":slug,"created_at":created],"fields": tempAraay]
        
        ParentClass.sharedInstance.editListArray1.append(params)
        
        let str = Utils.stringFromJson(object: ParentClass.sharedInstance.editListArray1)
        print(str)
        ParentClass.sharedInstance.setData(strData: str, strKey: EDIT_BLANK_ARRAY)
        
        self.navigationController?.popViewController(animated: true)

    }
    
   
    func  getTextfield(textField :UITextField , str_id : String){
            for var obejct in tempAraay{
                var tamp : JSON = JSON()
                tamp = obejct
                if  str_id ==  obejct["id"].stringValue{
                    tamp["Ans"].string = textField.text
                    let updated = try? obejct.merged(with:tamp)
                    if (updated != nil){
                        tempAraay.append(updated!)
                        print(tempAraay)
                    }
                }
            }
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
//-------------------------------------------------- KRISHNA CODE--------------------------------------------------------------
      //Captcha
        private func setupReCaptcha() {
            // swiftlint:disable:next force_try
            recaptcha = try! ReCaptcha(endpoint: endpoint, locale: locale)
    //        recaptcha = try! ReCaptcha(endpoint: endpoint, locale: Locale(identifier: "zh-CN"))

            recaptcha.configureWebView { [weak self] webview in
                webview.frame = self?.view.bounds ?? CGRect.zero
                webview.tag = Constants.webViewTag

                // For testing purposes
                // If the webview requires presentation, this should work as a way of detecting the webview in UI tests
                self?.view.viewWithTag(Constants.testLabelTag)?.removeFromSuperview()
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
                label.tag = Constants.testLabelTag
                label.accessibilityLabel = "webview"
                self?.view.addSubview(label)
            }
        }
        
        //Captcha
        @IBAction func captcha_tapped(_ sender: UIControl) {
            disposeBag = DisposeBag()

            recaptcha.rx.didFinishLoading
                .debug("did finish loading")
                .subscribe()
                .disposed(by: disposeBag)

            let validate = recaptcha.rx.validate(on: view, resetOnError: false)
                .catchError { error in
                    return .just("Error \(error)")
                }
                .debug("validate")
                .share()

            let isLoading = validate
                .map { _ in false }
                .startWith(true)
                .share(replay: 1)

            isLoading
                .bind(to: spinner.rx.isAnimating)
                .disposed(by: disposeBag)

            let isEnabled = isLoading
                .map { !$0 }
                .catchErrorJustReturn(false)
                .share(replay: 1)

            isEnabled
                .bind(to: sender.rx.isEnabled)
                .disposed(by: disposeBag)

    //        isEnabled
    //            .bind(to: endpointSegmentedControl.rx.isEnabled)
    //            .disposed(by: disposeBag)

            validate
                .map { [weak self] _ in
                    self?.view.viewWithTag(Constants.webViewTag)
                }
                .subscribe(onNext: { subview in
                    subview?.removeFromSuperview()
                })
                .disposed(by: disposeBag)
                print("validate")
            validate
                .bind(to: label.rx.text)
                .disposed(by: disposeBag)

            visibleChallengeSwitch.rx.value
                .subscribe(onNext: { [weak recaptcha] value in
                    recaptcha?.forceVisibleChallenge = value
                })
                .disposed(by: disposeBag)
                print("validate")
        }
        
        
        //Slider select a choise
        @IBAction func timeSliderChanged(sender: UISlider) {
            let newValue = Int(sender.value/25) * 25
            sender.setValue(Float(newValue), animated: false)
        }
        
        //SideBySide buttons actions
        @IBAction func sideBySide_tapped(_ sender: UIButton) {
            if sender.tag == 101{
                btnSide1.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
                btnSide2.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide3.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide4.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide5.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide6.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide7.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide8.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide9.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide10.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)

            } else if sender.tag == 102 {
                btnSide1.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide2.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
                btnSide3.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide4.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide5.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide6.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide7.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide8.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide9.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide10.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
            } else if sender.tag == 103 {
                btnSide1.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide2.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide3.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
                btnSide4.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide5.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide6.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide7.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide8.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide9.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide10.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
            } else if sender.tag == 104 {
                btnSide1.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide2.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide3.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide4.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
                btnSide5.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide6.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide7.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide8.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide9.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide10.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
            } else if sender.tag == 105 {
                btnSide1.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide2.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide3.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide4.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide5.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
                btnSide6.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide7.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide8.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide9.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide10.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
            } else if sender.tag == 106 {
                btnSide1.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide2.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide3.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide4.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide5.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide6.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
                btnSide7.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide8.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide9.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide10.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
            } else if sender.tag == 107 {
                btnSide1.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide2.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide3.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide4.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide5.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide6.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide7.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
                btnSide8.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide9.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide10.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
            } else if sender.tag == 108 {
                btnSide1.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide2.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide3.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide4.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide5.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide6.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide7.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide8.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
                btnSide9.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide10.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
            } else if sender.tag == 109 {
                btnSide1.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide2.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide3.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide4.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide5.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide6.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide7.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide8.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide9.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
                btnSide10.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
            } else if sender.tag == 110 {
                btnSide1.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide2.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide3.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide4.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide5.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide6.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide7.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide8.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide9.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
                btnSide10.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
            }
            
        }
        
        func sideBySideDisplay(display: Int, leftName: String, rightName: String){
                    
            btnSide1.isHidden = true
            btnSide2.isHidden = true
            btnSide3.isHidden = true
            btnSide4.isHidden = true
            btnSide5.isHidden = true
            btnSide6.isHidden = true
            btnSide7.isHidden = true
            btnSide8.isHidden = true
            btnSide9.isHidden = true
            btnSide10.isHidden = true
            
            lblLeftName.text = leftName
            lblRightName.text = rightName
            
//            lblLeftName.font = UIFont(name: APP_FONT_NAME, size: 12)
//            lblLeftName.textColor = colorSubHeading_76
//            
//            lblRightName.font = UIFont(name: APP_FONT_NAME, size: 12)
//            lblRightName.textColor = colorSubHeading_76
            
            if display == 2{
                btnSide1.isHidden = false
                btnSide2.isHidden = false
            } else if display == 3 {
                btnSide1.isHidden = false
                btnSide2.isHidden = false
                btnSide3.isHidden = false
            } else if display == 4 {
                btnSide1.isHidden = false
                btnSide2.isHidden = false
                btnSide3.isHidden = false
                btnSide4.isHidden = false
            } else if display == 5 {
                btnSide1.isHidden = false
                btnSide2.isHidden = false
                btnSide3.isHidden = false
                btnSide4.isHidden = false
                btnSide5.isHidden = false
            } else if display == 6 {
                btnSide1.isHidden = false
                btnSide2.isHidden = false
                btnSide3.isHidden = false
                btnSide4.isHidden = false
                btnSide5.isHidden = false
                btnSide6.isHidden = false
            } else if display == 7 {
                btnSide1.isHidden = false
                btnSide2.isHidden = false
                btnSide3.isHidden = false
                btnSide4.isHidden = false
                btnSide5.isHidden = false
                btnSide6.isHidden = false
                btnSide7.isHidden = false
            } else if display == 8 {
                btnSide1.isHidden = false
                btnSide2.isHidden = false
                btnSide3.isHidden = false
                btnSide4.isHidden = false
                btnSide5.isHidden = false
                btnSide6.isHidden = false
                btnSide7.isHidden = false
                btnSide8.isHidden = false
            } else if display == 9 {
                btnSide1.isHidden = false
                btnSide2.isHidden = false
                btnSide3.isHidden = false
                btnSide4.isHidden = false
                btnSide5.isHidden = false
                btnSide6.isHidden = false
                btnSide7.isHidden = false
                btnSide8.isHidden = false
                btnSide9.isHidden = false
            } else if display == 10 {
                btnSide1.isHidden = false
                btnSide2.isHidden = false
                btnSide3.isHidden = false
                btnSide4.isHidden = false
                btnSide5.isHidden = false
                btnSide6.isHidden = false
                btnSide7.isHidden = false
                btnSide8.isHidden = false
                btnSide9.isHidden = false
                btnSide10.isHidden = false
            }
            
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
