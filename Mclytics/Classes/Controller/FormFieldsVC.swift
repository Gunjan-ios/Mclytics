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
import AVKit

class FormFieldsVC: ParentClass, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentPickerDelegate, UITextViewDelegate   {
    
    fileprivate var headerview:UIView!
    fileprivate var buttonBack: UIButton!
    fileprivate var buttonMenu: UIButton!
    fileprivate var yPosition: Int!
    var lblTitle: String!
    fileprivate var scrlView: UIScrollView!

    private var currentPage = 1
    private var totalPage = 1
    
    private var stackView:UIView!
    private var attacheFile:CustomeAttacheFile!
    var imagePicker = UIImagePickerController()
    var picker:UIImagePickerController!
    var type : String?
//    var arrayList : JSON!
//    var arrayfield : JSON!
//    var answerfield : [JSON] = [JSON]()
//    var tempAraay : [JSON] = [JSON]()
//    var editData : [JSON] = [JSON]()
    var isRatingSet = false
    //Riddhi
    var formArray = [MainFormModal]()
    var selectedFormIndex = 0
    var selectedForm = MainFormModal()
    
    private var StarRatingView: StarRateView!

    private var signatureView: YPDrawSignatureView!
    private var signatureImageView: UIImageView!
    private var signClearButton:CustomButton!
    var imagesFolderName = "\(Date().toMillis()!)"
    
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
    
    var attachImage = CustomeAttacheFile()
    var attachVideo = CustomeAttacheFile()
    
    var name : String = ""
    var slug : String = ""
    var created : Double = 0
    var count : Int = 0
    var buttonPrevious : CustomButton!
    var buttonNext : CustomButton!
    var buttonSubmit: CustomButton!

    
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        name =  selectedForm.name
        slug =  selectedForm.slug
        created = selectedForm.created_at
        
        loadHeaderView()
        
        if ParentClass.sharedInstance.getDataForKey(strKey: USER_INTERFACE) as? Bool == true{
            dataSetupformOnebyOne(object: selectedForm.fields[count])

            buttonPrevious = CustomButton(frame: CGRect(x: X_PADDING, y: SCREEN_HEIGHT - (CUSTOM_BUTTON_HEIGHT*2), width: SCREEN_WIDTH/2 - (X_PADDING*2), height: CUSTOM_BUTTON_HEIGHT))
            buttonPrevious.setTitle("Previous", for: .normal)
            buttonPrevious.setTitleColor(.darkGray, for: .disabled)
            buttonPrevious.backgroundColor = UIColor.lightGray
            buttonPrevious.isEnabled = false
            buttonPrevious.addTarget(self, action: #selector(onPreviousPressed), for: .touchUpInside)
            self.view.addSubview(buttonPrevious)

            buttonNext = CustomButton(frame: CGRect(x: SCREEN_WIDTH - SCREEN_WIDTH/2 + X_PADDING , y: SCREEN_HEIGHT - (CUSTOM_BUTTON_HEIGHT*2), width: SCREEN_WIDTH/2 - (X_PADDING*2), height: CUSTOM_BUTTON_HEIGHT))
            buttonNext.addTarget(self, action: #selector(onNextPressed), for: .touchUpInside)
            buttonNext.setTitle("Next", for: .normal)
            self.view.addSubview(buttonNext)
            
            buttonSubmit = CustomButton(frame: CGRect(x: SCREEN_WIDTH - SCREEN_WIDTH/2 + X_PADDING , y: SCREEN_HEIGHT - (CUSTOM_BUTTON_HEIGHT*2), width: SCREEN_WIDTH/2 - (X_PADDING*2), height: CUSTOM_BUTTON_HEIGHT))
            buttonSubmit.addTarget(self, action: #selector(onSubmitPressed), for: .touchUpInside)
            buttonSubmit.setTitle("Submit", for: .normal)
            buttonSubmit.isHidden = true
            self.view.addSubview(buttonSubmit)


        }else{
            dataSetupformAPI()
        }

        
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
    

    func dataSetupformOnebyOne(object:FieldsModal) {
        
        
        scrlView = UIScrollView (frame: CGRect (x: 0, y: yPosition, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - yPosition - CUSTOM_BUTTON_HEIGHT * 2))
        scrlView.backgroundColor = .white
        scrlView.bounces = false
        
            var yposition : Int! = X_PADDING

            let dataType = object.type
            let required = object.required
            var requiredText : String = ""
        
            if required{
                requiredText =  Utils.requiredText(str: object.label.htmlToString)
            }else{
                requiredText = object.label.htmlToString
            }
        
            if dataType == DATATYPE_HEADING {
                
                let buttonAddImage = CustomLabel(frame: CGRect(x: X_PADDING, y: yposition, width: SCREEN_WIDTH - X_PADDING*2 , height: CUSTOM_BUTTON_HEIGHT))
                buttonAddImage.text = object.text
                buttonAddImage.tag = TAG1
                scrlView.addSubview(buttonAddImage)
                
                
            } else if dataType == DATATYPE_PARAGRAPH {
                
                let txtField = InsideTextView (frame: CGRect (x: X_PADDING, y: yposition , width: SCREEN_WIDTH - X_PADDING*2 , height: 100))
                txtField.text =  object.text
                txtField.attributedText = txtField.text.htmlToAttributedString
                txtField.isUserInteractionEnabled = false
                scrlView.addSubview(txtField)
                
                
            } else if dataType == DATATYPE_TEXT {
                
                let name = CustomInputFieldView(frame: CGRect(x: X_PADDING, y: yposition, width: SCREEN_WIDTH - X_PADDING*2 , height: controls_height))
                name.delegateAppForm = self
                name.initDesign(pName:requiredText , pTag: UploadTAG109, pPlaceHolder: object.placeholder, str_id: object.id)
                name.txtField.text =  object.answer
                scrlView.addSubview(name)
                
                
            } else if dataType == DATATYPE_EMAIL{
                
                let email = CustomInputFieldView(frame: CGRect(x: X_PADDING, y: yposition, width: SCREEN_WIDTH - X_PADDING*2 , height: controls_height))
                email.initDesign(pName:requiredText, pTag: TAG4, pPlaceHolder: object.placeholder, str_id: object.id)
                email.delegateAppForm = self
                email.txtField.keyboardType = .emailAddress
                email.txtField.text = object.answer
                scrlView.addSubview(email)

            } else if dataType == DATATYPE_PHONE{
                let phone = CustomInputFieldView(frame: CGRect(x: X_PADDING, y: yposition, width: SCREEN_WIDTH - X_PADDING*2 , height: controls_height))
                phone.initDesign(pName:requiredText, pTag: TAG4, pPlaceHolder: object.placeholder, str_id: object.id)
                phone.delegateAppForm = self
                phone.txtField.keyboardType = .phonePad
                phone.txtField.text = object.answer
                scrlView.addSubview(phone)
                
            } else if dataType == DATATYPE_TEXTAREA{
                
                let districtView = CustomInputTextView(frame: CGRect(x: X_PADDING, y: yposition, width:  SCREEN_WIDTH - X_PADDING*2, height: 125))
                districtView.delegateAppForm = self
                districtView.initDesign(pName: requiredText, pTag: 13, pPlaceHolder: object.predefinedValue, str_id: object.id)
                districtView.txtField.text = object.answer
                scrlView.addSubview(districtView)
                
                
            }else if dataType == DATATYPE_DATE{
                
                let UnitEstablishmentDate = CustomComboBoxView(frame: CGRect(x: X_PADDING, y: yposition, width: Int(scrlView.frame.size.width)  - (X_PADDING * 2), height: controls_height))
                UnitEstablishmentDate.initDesign(pName:object.label.htmlToString, pTag: TAG8, pOptions: [],pPlaceHolder: object.placeholder, str_id: object.id)
                UnitEstablishmentDate.setDatePicker()
                UnitEstablishmentDate.delegateAppForm = self
                UnitEstablishmentDate.txtField.text = object.answer
                scrlView.addSubview(UnitEstablishmentDate)
                
                
            }else if dataType == DATATYPE_SELECTLIST{
                
                let titleComboBox = CustomComboBoxView(frame: CGRect(x: X_PADDING, y: yposition, width: SCREEN_WIDTH - X_PADDING*2, height: controls_height))
                titleComboBox.delegateAppForm = self
                var strOption : [String] = [String]()
                for option in object.options {
                    strOption.append(option.label)
                }
                titleComboBox.initDesign(pName:requiredText, pTag: 12, pOptions: strOption,pPlaceHolder: "", str_id: object.id)
                titleComboBox.txtField.text = object.answer
                scrlView.addSubview(titleComboBox)
                
                
            }else if dataType == DATATYPE_RADIO{
                print(object.selectedOptions)

                let genderView = GenderView(frame:  CGRect(x: X_PADDING, y: yposition, width: Int(scrlView.frame.size.width) - X_PADDING*2, height: controls_height))
           
                genderView.initDesign(pName:object.label.htmlToString, pTag: 6, pOptions: object.options, str_id: object.id)
                genderView.frame = genderView.resetHeight()
                genderView.layer.cornerRadius = radius
                genderView.layer.borderWidth = borderWidth
                genderView.layer.borderColor =  colorDividerBG_f4.cgColor
                genderView.delegateApp = self
                scrlView.addSubview(genderView)
                
                
            }else if dataType == DATATYPE_CHECKBOX{
                print(object.selectedOptions)
                print(object.options)
                if object.checkbox_answer.count != 0{
                    for mainObejct in selectedForm.fields {
                        if   object.id ==  mainObejct.id {
                            for option in mainObejct.options {
                                if mainObejct.checkbox_answer.contains(option.label) {
                                    option.selected = true
                                }else{
                                    option.selected = false
                                }
                            }
                        }
                    }
                }
                
                let multiple = MarginSelectView(frame:  CGRect(x: X_PADDING, y: yposition, width: Int(scrlView.frame.size.width) - X_PADDING*2, height: controls_height))
                multiple.delegateApp = self
                multiple.initDesign(pName:requiredText, pTag: 122, pOptions: object.options, str_id: object.id)
                multiple.frame = multiple.resetHeight()
                multiple.layer.cornerRadius = radius
                multiple.layer.borderWidth = borderWidth
                multiple.layer.borderColor =  colorDividerBG_f4.cgColor
                scrlView.addSubview(multiple)
                
                //TODO: -----------------------
                
            }else if dataType == DATATYPE_CARRYFORWARD{
                print(object.options)

                let inputType = object.inputType

                if object.checkbox_answer.count == 0 || object.answer == ""{
                    object.options = [OptionsModal]()
                    for mainObejct in selectedForm.fields {
                        if   object.carryforwardsource ==  mainObejct.id {
                            for option in mainObejct.options {
                                if mainObejct.checkbox_answer.contains(option.label) {
                                    option.selected = false
                                    object.options.append(option)
                                }
                            }
                        }
                    }
                }
             
                if inputType == DATATYPE_CHECKBOX{
                    if object.checkbox_answer.count != 0{
                        for option in object.options {
                            if object.checkbox_answer.contains(option.label) {
                                option.selected = true
                            }else{
                                 option.selected = false
                            }
                        }
                    }
                    let multiple = MarginSelectView(frame:  CGRect(x: X_PADDING, y: yposition, width: Int(scrlView.frame.size.width) - X_PADDING*2, height: controls_height))
                    multiple.delegateApp = self
                    multiple.initDesign(pName: requiredText, pTag: 1022, pOptions: object.options, str_id: object.id)
                    multiple.frame = multiple.resetHeight()
                    multiple.layer.cornerRadius = radius
                    multiple.layer.borderWidth = borderWidth
                    multiple.layer.borderColor =  colorDividerBG_f4.cgColor
                    scrlView.addSubview(multiple)
                } else if inputType == DATATYPE_RADIO{
                    if object.answer != ""{
                        for option in object.options {
                            if object.answer == option.label  {
                                option.selected = true
                            } else {
                                option.selected = false
                            }
                          }
                    }
                    
                    let genderView = GenderView(frame:  CGRect(x: X_PADDING, y: yposition, width: Int(scrlView.frame.size.width) - X_PADDING*2, height: controls_height))
                    genderView.initDesign(pName:object.label.htmlToString, pTag: 1023, pOptions: object.options, str_id: object.id)
                    genderView.frame = genderView.resetHeight()
                    genderView.layer.cornerRadius = radius
                    genderView.layer.borderWidth = borderWidth
                    genderView.layer.borderColor =  colorDividerBG_f4.cgColor
                    genderView.delegateApp = self
                    scrlView.addSubview(genderView)
                }
                }else if dataType == DATATYPE_RANKINGSCALE{
                
                var strOption : [String] = [String]()
                
                let ranks = object.ranks
                
                for n in 1...ranks {
                    strOption.append("\(n)")
                }
                
                let title = PaddingLabel (frame: CGRect (x: X_PADDING, y: yposition, width: SCREEN_WIDTH - X_PADDING*2, height: 25))
                title.text = requiredText
                title.font = UIFont(name: APP_FONT_NAME, size: 17)
                title.textColor = colorSubHeading_76
                let rectShape = CAShapeLayer()
                rectShape.path = UIBezierPath(roundedRect: title.bounds, byRoundingCorners: [ .topRight , .topLeft], cornerRadii: CGSize(width: radius, height: radius)).cgPath
                rectShape.strokeColor = colorDividerBG_f4.cgColor
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
                vv1.layer.borderColor = colorDividerBG_f4.cgColor
                
                var y_Internal_position : Int! = X_PADDING
                
                var count = 0
                for option in object.options {
                    
                    let  titleComboBox = RankingView(frame: CGRect(x: X_PADDING, y: y_Internal_position, width: Int(scrlView.frame.size.width) - X_PADDING*2 , height: 35))
                    titleComboBox.initDesign(pName: option.label, pTag: TAG18, pOptions: strOption,pPlaceHolder: "", str_id: object.id, textFieldIndex: count)
                    titleComboBox.delegateAppForm = self
                    titleComboBox.txtField.text = option.answer
                    vv1.addSubview(titleComboBox)
                    count += 1
                    y_Internal_position +=  X_PADDING +  Int( titleComboBox.bounds.height)
                }
                
                let optionsCount = object.options.count
                vv1.frame =  CGRect(x: X_PADDING, y: yposition, width: Int(self.view.frame.size.width) - X_PADDING*2, height: 35*optionsCount + X_PADDING*(optionsCount+1))
                scrlView.addSubview(vv1)
                
                
            }
            else if dataType == DATATYPE_SIDEBYSIDE{
                //controller SidebySide
                vSideBySide.frame = CGRect(x: X_PADDING, y: yposition, width: Int(self.view.frame.size.width) - X_PADDING*2, height: 100)
                vSideBySide.layer.borderColor = colorDividerBG_f4.cgColor
                vSideBySide.layer.borderWidth = borderWidth
                vSideBySide.layer.cornerRadius = radius
                scrollSideBySide.showsHorizontalScrollIndicator = false
                scrollSideBySide.showsVerticalScrollIndicator = false
                scrollSideBySide.contentSize = CGSize(width: vSideBySide.frame.size.width, height: 60)
                scrlView.addSubview(vSideBySide)
                
                sideBySideDisplay(display: object.ranks, leftName: object.side1, rightName: object.side2, str_id: object.id, answer: object.answer)
                
                
            }else if dataType == DATATYPE_RATING{
                //Rating view
                let inputType = object.inputType
                
                var strOption : [String] = [String]()
                for option in object.options {
                    strOption.append(option.label)
                }
                if inputType == "star" {
                    
                    let vv = UIView(frame: CGRect(x: X_PADDING, y: yposition, width: Int(self.view.frame.size.width) - X_PADDING*2, height: 90))
                    vv.layer.cornerRadius = radius
                    vv.layer.borderWidth = borderWidth
                    vv.layer.borderColor = colorDividerBG_f4.cgColor
                    
                    let lblSelectChoise = PaddingLabel(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.size.width) - X_PADDING, height: 29))
                    lblSelectChoise.text = requiredText
                    lblSelectChoise.font = UIFont(name: APP_FONT_NAME, size: 17)
                    lblSelectChoise.textColor = colorSubHeading_76
                    
                    let line = UIView(frame: CGRect(x: 0, y: Int(lblSelectChoise.bounds.height), width: Int(vv.frame.size.width), height: 1))
                    line.backgroundColor = buttonBorderColor
                    
                    StarRatingView = StarRateView(frame: CGRect(x: X_PADDING, y: 40, width: 40, height: 40))
                    StarRatingView.maxCount = strOption.count
                    StarRatingView.idString = object.id
                    vv.addSubview(lblSelectChoise)
                    vv.addSubview(line)
                    vv.addSubview(StarRatingView)
                    scrlView.addSubview(vv)
                    StarRatingView.frame = CGRect (x: X_PADDING, y: 40, width: 40*strOption.count, height: 40)
                    
                    
                    StarRatingView.delegate = self
                    
                    if object.answer != "" {
                        StarRatingView.ratingValue = Int(object.answer)!
                    } else {
                        StarRatingView.ratingValue = -1
                    }
                }
                else{
                    //Slider selection
                    vSliderSelection.frame = CGRect(x: X_PADDING, y: yposition, width: Int(self.view.frame.size.width) - X_PADDING*2, height: 100)
                    vSliderSelection.layer.borderColor = colorDividerBG_f4.cgColor
                    vSliderSelection.layer.borderWidth = borderWidth
                    vSliderSelection.layer.cornerRadius = radius
                    
                    sliderSelection.accessibilityIdentifier = object.id
                    if object.answer != "" {
                        sliderSelection.setValue(Float(object.answer)!, animated: true)
                    }
                    scrlView.addSubview(vSliderSelection)
                    
                }
                
            }else if dataType == DATATYPE_IMAGE{
                
                //image file
                
                let iconImage:UIImage? = UIImage(named: "gallery")
                attachImage = CustomeAttacheFile(frame: CGRect(x: X_PADDING, y: yposition, width: 130, height: 130))
                attachImage.accessibilityIdentifier = object.id
                attachImage.addTarget(self, action: #selector(openGallary), for: .touchUpInside)
                scrlView.addSubview(attachImage)
                
                if object.answer != "" {
                    let image = loadImageFromDocumentDirectory(fileName: object.answer)
                    if image == nil {
                        self.attachImage.setImage(iconImage, for: .normal)
                        self.attachImage.setTitle(object.label.htmlToString, for: .normal)
                    } else {
                        self.attachImage.setImage(image!, for: .normal)
                    }
                    
                } else {
                    attachImage.setTitle(object.label.htmlToString, for: .normal)
                    attachImage.setImage(iconImage, for: .normal)
                }
                
                
            }else if dataType == DATATYPE_VIDEO{
                //video file
                
                let iconImage1:UIImage? = UIImage(named: "gallery")
                attachVideo = CustomeAttacheFile(frame: CGRect(x: X_PADDING, y: yposition, width: 130, height: 130))
                attachVideo.addTarget(self, action: #selector(openCamera), for: .touchUpInside)
                attachVideo.accessibilityIdentifier = object.id
                scrlView.addSubview(attachVideo)
                
                if object.answer != "" {
                    if let videoURL = loadVideoFromDocumentDirectory(fileName: object.answer) {
                        let asset = AVURLAsset(url: videoURL, options: nil)
                        let imgGenerator = AVAssetImageGenerator(asset: asset)
                        imgGenerator.appliesPreferredTrackTransform = true
                        do {
                            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
                            let thumbnail = UIImage(cgImage: cgImage)
                            self.attachVideo.setImage(thumbnail, for: .normal)
                            self.attachVideo.setTitle("", for: .normal)
                        } catch {
                            attachVideo.setTitle(object.label.htmlToString, for: .normal)
                            attachVideo.setImage(iconImage1, for: .normal)
                        }
                    }
                } else {
                    attachVideo.setTitle(object.label.htmlToString, for: .normal)
                    attachVideo.setImage(iconImage1, for: .normal)
                }
                
                
            }else if dataType == DATATYPE_FILE{
                //Attche file
                
                let iconImage:UIImage? = UIImage(named: "attach")
                attacheFile = CustomeAttacheFile(frame: CGRect(x: X_PADDING, y: yposition, width: 130, height: 130))
                
                self.attacheFile.setImage(iconImage, for: .normal)
                self.attacheFile.accessibilityIdentifier = object.id
                self.attacheFile.addTarget(self, action: #selector(openAttchementFile(_:)), for: .touchUpInside)
                scrlView.addSubview(attacheFile)
                
                if object.answer != "" {
                    let url = URL(fileURLWithPath: object.answer)
                    self.attacheFile.setTitle(url.lastPathComponent, for: .normal)
                } else {
                    self.attacheFile.setTitle(object.label.htmlToString, for: .normal)
                }

            }else if dataType == DATATYPE_SIGNATURE{
                
                //SignatureView
                
                signatureView = YPDrawSignatureView(frame:CGRect(x: X_PADDING, y: yposition, width: Int(self.view.frame.size.width) - X_PADDING*2, height: 200))
                signatureView.backgroundColor = UIColor.clear
                signatureView.layer.cornerRadius = radius
                signatureView.layer.borderWidth = borderWidth
                signatureView.layer.borderColor = colorDividerBG_f4.cgColor
                signatureView.accessibilityIdentifier = object.id
                scrlView.addSubview(signatureView)
                
                signClearButton = CustomButton(frame: CGRect(x: Int(signatureView.frame.size.width - 70), y: Int(signatureView.frame.size.height - 45), width: 60, height: 32))
                signClearButton.backgroundColor = UIColor.gray
                signClearButton.setTitleColor(.white, for: .normal)
                signClearButton.layer.cornerRadius = radius
                self.signClearButton.setTitle("Clear", for: .normal)
                signClearButton.addTarget(self, action: #selector(signClearPressed), for: .touchUpInside)
                signatureView.addSubview(signClearButton)
                
                signatureView.delegate = self
                if object.answer != "" {
                    signatureImageView = UIImageView(frame:CGRect(x: 0, y: 0, width: Int(signatureView.frame.size.width), height: 200))
                    signatureImageView.layer.cornerRadius = radius
                    signatureImageView.layer.borderWidth = borderWidth
                    signatureImageView.layer.borderColor = colorDividerBG_f4.cgColor
                    signatureImageView.accessibilityIdentifier = object.id
                    signatureImageView.image = loadImageFromDocumentDirectory(fileName: object.answer)
                    signatureView.addSubview(signatureImageView)
                }
                
                
            }else if dataType == DATATYPE_RECAPTCHA{
                
                //Captch
                vCaptcha.frame = CGRect(x: X_PADDING, y: yposition, width: Int(self.view.frame.size.width) - X_PADDING*2, height: 90)
                vCaptcha.layer.borderColor = colorDividerBG_f4.cgColor
                vCaptcha.layer.borderWidth = borderWidth
                vCaptcha.layer.cornerRadius = radius
                vCaptcha.accessibilityIdentifier = object.id
                scrlView.addSubview(vCaptcha)
                
                setupReCaptcha()
                if object.answer == "" {
                    visibleChallengeSwitch.setOn(false, animated: true)
                } else {
                    visibleChallengeSwitch.setOn(true, animated: true)
                    vCaptcha.isUserInteractionEnabled = false
                }
            }
            else if dataType == DATATYPE_GEOLOCATION{
                let map = MapView(frame: CGRect(x: X_PADDING, y: yposition, width: Int(scrlView.frame.size.width)  - (X_PADDING * 2), height: Int(scrlView.frame.size.width)  - (X_PADDING * 2)))
                map.delegateApp = self
                map.initDesign(latitude: object.lat, longitute: object.long, str_id: object.id)
                scrlView.addSubview(map)
                yposition += X_PADDING + Int( map.bounds.height)
                }
//        }
        
        scrlView.contentSize = CGSize (width: SCREEN_WIDTH, height: SCREEN_HEIGHT - yPosition - CUSTOM_BUTTON_HEIGHT * 2)
        self.view.addSubview(scrlView)
    }
    @objc func valueChanged(sender: UISlider) {
        let index = (Int)(sliderSelection!.value + 1);
        sliderSelection?.setValue(Float(index), animated: false)
    }
    @objc func onNextPressed() {
        let object  = selectedForm.fields[count]
        if object.answer == "" && object.required{
            self.showAlert(message: CS.Common.singleValidationMsg, type: .error, navBar: false)
            return;
        }
         count += 1
        print(selectedForm.fields.count)
        print(count)
         if count == 0{
            buttonPrevious.setTitleColor(.darkGray, for: .disabled)
            buttonPrevious.backgroundColor = UIColor.lightGray
            buttonPrevious.isEnabled = false
            buttonNext.isEnabled = true
            buttonNext.backgroundColor = colorPrimary
//            dataSetupformOnebyOne(object: selectedForm.fields[count])
        }else if  selectedForm.fields.count == count + 1{
            buttonPrevious.isEnabled = true
            buttonPrevious.backgroundColor = colorPrimary
            buttonNext.setTitleColor(.darkGray, for: .disabled)
            buttonNext.backgroundColor = UIColor.lightGray
            buttonNext.isEnabled = false
            buttonNext.isHidden = true
            buttonSubmit.isHidden = false
         }
         else if selectedForm.fields.count > count{
            buttonPrevious.isEnabled = true
            buttonNext.isEnabled = true
            buttonNext.backgroundColor = colorPrimary
            buttonPrevious.backgroundColor = colorPrimary
//            dataSetupformOnebyOne(object: selectedForm.fields[count])
            buttonNext.isHidden = false
            buttonSubmit.isHidden = true
        }
        dataSetupformOnebyOne(object: selectedForm.fields[count])

    }
    @objc func onPreviousPressed() {
        count -= 1
          if count == 0{
            buttonPrevious.setTitleColor(.darkGray, for: .disabled)
            buttonPrevious.backgroundColor = UIColor.lightGray
            buttonPrevious.isEnabled = false
            buttonNext.isEnabled = true
            buttonNext.backgroundColor = colorPrimary
        }else if count > 0{
            buttonPrevious.isEnabled = true
            buttonNext.isEnabled = true
            buttonNext.backgroundColor = colorPrimary
            buttonPrevious.backgroundColor = colorPrimary
            buttonNext.isHidden = false
            buttonSubmit.isHidden = true
          }else  if count == selectedForm.fields.count{
            buttonPrevious.isEnabled = true
            buttonPrevious.backgroundColor = colorPrimary
            buttonNext.setTitleColor(.darkGray, for: .disabled)
            buttonNext.backgroundColor = UIColor.lightGray
            buttonNext.isEnabled = false
        }
        dataSetupformOnebyOne(object: selectedForm.fields[count])

    }
    

    func dataSetupformAPI() {
        
        scrlView = UIScrollView (frame: CGRect (x: 0, y: yPosition, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - yPosition))
        scrlView.backgroundColor = .white
        
        var yposition : Int! = X_PADDING
        
        for object in selectedForm.fields {
            
            let dataType = object.type
            let required = object.required
            var requiredText : String = ""
            
            if required{
                requiredText =  Utils.requiredText(str: object.label.htmlToString)
            }else{
                requiredText = object.label.htmlToString
            }
            
            if dataType == DATATYPE_HEADING {
                
                let buttonAddImage = CustomLabel(frame: CGRect(x: X_PADDING, y: yposition, width: SCREEN_WIDTH - X_PADDING*2 , height: CUSTOM_BUTTON_HEIGHT))
                buttonAddImage.text = object.text
                buttonAddImage.tag = TAG1
                scrlView.addSubview(buttonAddImage)
                
                yposition += X_PADDING + CUSTOM_BUTTON_HEIGHT
                
            } else if dataType == DATATYPE_PARAGRAPH {
                
                let txtField = InsideTextView (frame: CGRect (x: X_PADDING, y: yposition , width: SCREEN_WIDTH - X_PADDING*2 , height: 100))
                txtField.text =  object.text
                txtField.attributedText = txtField.text.htmlToAttributedString
                txtField.isUserInteractionEnabled = false
                scrlView.addSubview(txtField)
                
                yposition += X_PADDING + Int(txtField.bounds.height)
                
            } else if dataType == DATATYPE_TEXT {
                
                let name = CustomInputFieldView(frame: CGRect(x: X_PADDING, y: yposition, width: SCREEN_WIDTH - X_PADDING*2 , height: controls_height))
                name.delegateAppForm = self
                name.initDesign(pName: requiredText , pTag: UploadTAG109, pPlaceHolder: object.placeholder, str_id: object.id)
                name.txtField.text =  object.answer
                scrlView.addSubview(name)
                
                yposition += X_PADDING + Int(name.bounds.height)
                
            } else if dataType == DATATYPE_EMAIL{
                
                let email = CustomInputFieldView(frame: CGRect(x: X_PADDING, y: yposition, width: SCREEN_WIDTH - X_PADDING*2 , height: controls_height))
                email.initDesign(pName:requiredText, pTag: TAG4, pPlaceHolder: object.placeholder, str_id: object.id)
                email.delegateAppForm = self
                email.txtField.keyboardType = .emailAddress
                email.txtField.text = object.answer
                scrlView.addSubview(email)
                

                yposition += X_PADDING + Int(email.bounds.height)
                
            } else if dataType == DATATYPE_PHONE{
                let phone = CustomInputFieldView(frame: CGRect(x: X_PADDING, y: yposition, width: SCREEN_WIDTH - X_PADDING*2 , height: controls_height))
                phone.initDesign(pName:requiredText, pTag: TAG4, pPlaceHolder: object.placeholder, str_id: object.id)
                phone.delegateAppForm = self
                phone.txtField.keyboardType = .phonePad
                phone.txtField.text = object.answer
                scrlView.addSubview(phone)
                yposition += X_PADDING + Int(phone.bounds.height)
                
            } else if dataType == DATATYPE_TEXTAREA{
                
                let districtView = CustomInputTextView(frame: CGRect(x: X_PADDING, y: yposition, width:  SCREEN_WIDTH - X_PADDING*2, height: 125))
                districtView.delegateAppForm = self
                districtView.initDesign(pName: requiredText, pTag: 13, pPlaceHolder: object.predefinedValue, str_id: object.id)
                districtView.txtField.text = object.answer
                scrlView.addSubview(districtView)
                
                yposition += X_PADDING  + 125
                
            }else if dataType == DATATYPE_DATE{
                
                let UnitEstablishmentDate = CustomComboBoxView(frame: CGRect(x: X_PADDING, y: yposition, width: Int(scrlView.frame.size.width)  - (X_PADDING * 2), height: controls_height))
                UnitEstablishmentDate.initDesign(pName:object.label.htmlToString, pTag: TAG8, pOptions: [],pPlaceHolder: object.placeholder, str_id: object.id)
                UnitEstablishmentDate.setDatePicker()
                UnitEstablishmentDate.delegateAppForm = self
                UnitEstablishmentDate.txtField.text = object.answer
                scrlView.addSubview(UnitEstablishmentDate)
                
                yposition += X_PADDING + Int( UnitEstablishmentDate.bounds.height)
                
            }else if dataType == DATATYPE_SELECTLIST{
                
                let titleComboBox = CustomComboBoxView(frame: CGRect(x: X_PADDING, y: yposition, width: SCREEN_WIDTH - X_PADDING*2, height: controls_height))
                titleComboBox.delegateAppForm = self
                var strOption : [String] = [String]()
                for option in object.options {
                    strOption.append(option.label)
                }
                titleComboBox.initDesign(pName:requiredText, pTag: 12, pOptions: strOption,pPlaceHolder: "", str_id: object.id)
                titleComboBox.txtField.text = object.answer
                scrlView.addSubview(titleComboBox)
                
                yposition += X_PADDING + Int( titleComboBox.bounds.height)
                
            }else if dataType == DATATYPE_RADIO{
                
                let genderView = GenderView(frame:  CGRect(x: X_PADDING, y: yposition, width: Int(scrlView.frame.size.width) - X_PADDING*2, height: controls_height))
//                var strOption : [String] = [String]()
//                for option in object.options {
//                    strOption.append(option.label)
                //                }
                genderView.delegateApp = self
                genderView.initDesign(pName:object.label.htmlToString, pTag: 6, pOptions: object.options, str_id: object.id)
                genderView.frame = genderView.resetHeight()
                genderView.layer.cornerRadius = radius
                genderView.layer.borderWidth = borderWidth
                genderView.layer.borderColor =  colorDividerBG_f4.cgColor
                scrlView.addSubview(genderView)
                
                yposition += X_PADDING + Int( genderView.bounds.height)
                
            }else if dataType == DATATYPE_CHECKBOX{
                
                let multiple = MarginSelectView(frame:  CGRect(x: X_PADDING, y: yposition, width: Int(scrlView.frame.size.width) - X_PADDING*2, height: controls_height))
                multiple.delegateApp = self
                multiple.initDesign(pName:requiredText, pTag: 122, pOptions: object.options, str_id: object.id)
                multiple.frame = multiple.resetHeight()
                multiple.layer.cornerRadius = radius
                multiple.layer.borderWidth = borderWidth
                multiple.layer.borderColor =  colorDividerBG_f4.cgColor
                scrlView.addSubview(multiple)
                
                yposition += X_PADDING + Int( multiple.bounds.height)
            }
            else if dataType == DATATYPE_CARRYFORWARD{
                
                let name = CustomInputFieldView(frame: CGRect(x: X_PADDING, y: yposition, width: SCREEN_WIDTH - X_PADDING*2 , height: controls_height))
                name.delegateAppForm = self
                name.initDesign(pName: requiredText , pTag: TAG21, pPlaceHolder: "", str_id: object.id)
                name.txtField.text = CS.Common.carryForwardMsg
                name.txtField.textColor = .red
                scrlView.addSubview(name)
                
                yposition += X_PADDING + Int(name.bounds.height)
                
            }else if dataType == DATATYPE_RANKINGSCALE{
                
                var strOption : [String] = [String]()
                
                let ranks = object.ranks
                
                for n in 1...ranks {
                    strOption.append("\(n)")
                }
                
                let title = PaddingLabel (frame: CGRect (x: X_PADDING, y: yposition, width: SCREEN_WIDTH - X_PADDING*2, height: 25))
                title.text = requiredText
                title.font = UIFont(name: APP_FONT_NAME, size: 17)
                title.textColor = colorSubHeading_76
                let rectShape = CAShapeLayer()
                rectShape.path = UIBezierPath(roundedRect: title.bounds, byRoundingCorners: [ .topRight , .topLeft], cornerRadii: CGSize(width: radius, height: radius)).cgPath
                rectShape.strokeColor = colorDividerBG_f4.cgColor
                rectShape.fillColor = UIColor.clear.cgColor
                rectShape.lineWidth = borderWidth
                rectShape.frame = title.bounds
                title.layer.mask =   rectShape
                title.layer.addSublayer(rectShape)
                scrlView.addSubview(title)
                
                yposition +=  Int( title.bounds.height)
                
                let vv1 = UIView(frame: CGRect(x: X_PADDING, y: yposition, width: Int(self.view.frame.size.width) - X_PADDING*2, height: 90))

                var y_Internal_position : Int! = X_PADDING
                
                var count = 0
                for option in object.options {
                    
                    let  titleComboBox = RankingView(frame: CGRect(x: X_PADDING, y: y_Internal_position, width: Int(scrlView.frame.size.width) - X_PADDING*2 , height: 35))
                    titleComboBox.delegateAppForm = self
                    titleComboBox.initDesign(pName: option.label, pTag: TAG18, pOptions: strOption,pPlaceHolder: "", str_id: object.id, textFieldIndex: count)
                    titleComboBox.txtField.text = option.answer
                    vv1.addSubview(titleComboBox)
                    count += 1
                    
                    y_Internal_position +=  X_PADDING +  Int( titleComboBox.bounds.height)
                }
                
                let optionsCount = object.options.count
                vv1.frame =  CGRect(x: X_PADDING, y: yposition, width: Int(self.view.frame.size.width) - X_PADDING*2, height: 35*optionsCount + X_PADDING*(optionsCount+1))
           
                let rectShape1 = CAShapeLayer()
                rectShape1.path = UIBezierPath(roundedRect: vv1.bounds, byRoundingCorners: [ .bottomRight , .bottomLeft], cornerRadii: CGSize(width: radius, height: radius)).cgPath
                rectShape1.strokeColor = colorDividerBG_f4.cgColor
                rectShape1.fillColor = UIColor.clear.cgColor
                rectShape1.lineWidth = borderWidth
                rectShape1.frame = title.bounds
                vv1.layer.mask =   rectShape1
                vv1.layer.addSublayer(rectShape1)
                scrlView.addSubview(vv1)
                yposition +=  X_PADDING +  Int( vv1.bounds.height)
                
            }
            else if dataType == DATATYPE_SIDEBYSIDE{
                //controller SidebySide
                vSideBySide.frame = CGRect(x: X_PADDING, y: yposition, width: Int(self.view.frame.size.width) - X_PADDING*2, height: 100)
                vSideBySide.layer.borderColor = colorDividerBG_f4.cgColor
                vSideBySide.layer.borderWidth = borderWidth
                vSideBySide.layer.cornerRadius = radius
                scrollSideBySide.showsHorizontalScrollIndicator = false
                scrollSideBySide.showsVerticalScrollIndicator = false
                scrollSideBySide.contentSize = CGSize(width: vSideBySide.frame.size.width, height: 60)
                scrlView.addSubview(vSideBySide)
                
                sideBySideDisplay(display: object.ranks, leftName: object.side1, rightName: object.side2, str_id: object.id, answer: object.answer)
                
                yposition += X_PADDING +  Int(vSideBySide.bounds.height)
                
                
            }else if dataType == DATATYPE_RATING{
                //Rating view
                let inputType = object.inputType
                
                var strOption : [String] = [String]()
                for option in object.options {
                    strOption.append(option.label)
                }
                if inputType == "star" {
                    
                    let vv = UIView(frame: CGRect(x: X_PADDING, y: yposition, width: Int(self.view.frame.size.width) - X_PADDING*2, height: 90))
                    vv.layer.cornerRadius = radius
                    vv.layer.borderWidth = borderWidth
                    vv.layer.borderColor = colorDividerBG_f4.cgColor
                    
                    let lblSelectChoise = PaddingLabel(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.size.width) - X_PADDING, height: 29))
                    lblSelectChoise.text = requiredText
                    lblSelectChoise.font = UIFont(name: APP_FONT_NAME, size: 17)
                    lblSelectChoise.textColor = colorSubHeading_76
                    
                    let line = UIView(frame: CGRect(x: 0, y: Int(lblSelectChoise.bounds.height), width: Int(vv.frame.size.width), height: 1))
                    line.backgroundColor = buttonBorderColor
                    
                    
                    StarRatingView = StarRateView(frame: CGRect(x: X_PADDING, y: 40, width: 40, height: 40))
                    StarRatingView.maxCount = strOption.count
                    StarRatingView.idString = object.id
                    vv.addSubview(lblSelectChoise)
                    vv.addSubview(line)
                    vv.addSubview(StarRatingView)
                    scrlView.addSubview(vv)
                    StarRatingView.frame = CGRect (x: X_PADDING, y: 40, width: 40*strOption.count, height: 40)
                    
                    yposition += X_PADDING +  Int( vv.bounds.height)

                    StarRatingView.delegate = self
                    
                    if object.answer != "" {
                        StarRatingView.ratingValue = Int(object.answer)!
                    } else {
                        StarRatingView.ratingValue = -1
                    }
                }
                else{
                    //Slider selection
                    vSliderSelection.frame = CGRect(x: X_PADDING, y: yposition, width: Int(self.view.frame.size.width) - X_PADDING*2, height: 100)
                    vSliderSelection.layer.borderColor = colorDividerBG_f4.cgColor
                    vSliderSelection.layer.borderWidth = borderWidth
                    vSliderSelection.layer.cornerRadius = radius

                    sliderSelection.accessibilityIdentifier = object.id
                    if object.answer != "" {
                        sliderSelection.setValue(Float(object.answer)!, animated: true)
                    }
                    scrlView.addSubview(vSliderSelection)
                    
                    yposition += X_PADDING +  Int(vSliderSelection.bounds.height)
                }
                
            }else if dataType == DATATYPE_IMAGE{
                
                //image file

                let iconImage:UIImage? = UIImage(named: "gallery")
                 attachImage = CustomeAttacheFile(frame: CGRect(x: X_PADDING, y: yposition, width: 130, height: 130))
                attachImage.accessibilityIdentifier = object.id
                attachImage.addTarget(self, action: #selector(openGallary), for: .touchUpInside)
                scrlView.addSubview(attachImage)
                
                if object.answer != "" {
                    let image = loadImageFromDocumentDirectory(fileName: object.answer)
                    if image == nil {
                        self.attachImage.setImage(iconImage, for: .normal)
                        self.attachImage.setTitle(object.label.htmlToString, for: .normal)
                    } else {
                        self.attachImage.setImage(image!, for: .normal)
                    }
                    
                } else {
                    attachImage.setTitle(object.label.htmlToString, for: .normal)
                    attachImage.setImage(iconImage, for: .normal)
                }
                
                yposition += X_PADDING + 130
                
            }else if dataType == DATATYPE_VIDEO{
                //video file

                let iconImage1:UIImage? = UIImage(named: "gallery")
                attachVideo = CustomeAttacheFile(frame: CGRect(x: X_PADDING, y: yposition, width: 130, height: 130))
                
                attachVideo.addTarget(self, action: #selector(openCamera), for: .touchUpInside)
                attachVideo.accessibilityIdentifier = object.id
                scrlView.addSubview(attachVideo)
                
                
                if object.answer != "" {
                    if let videoURL = loadVideoFromDocumentDirectory(fileName: object.answer) {
                        let asset = AVURLAsset(url: videoURL, options: nil)
                        let imgGenerator = AVAssetImageGenerator(asset: asset)
                        imgGenerator.appliesPreferredTrackTransform = true
                        do {
                            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
                            let thumbnail = UIImage(cgImage: cgImage)
                            self.attachVideo.setImage(thumbnail, for: .normal)
                            self.attachVideo.setTitle("", for: .normal)
                        } catch {
                            attachVideo.setTitle(object.label.htmlToString, for: .normal)
                            attachVideo.setImage(iconImage1, for: .normal)
                        }
                    }
                } else {
                    attachVideo.setTitle(object.label.htmlToString, for: .normal)
                    attachVideo.setImage(iconImage1, for: .normal)
                }
                
                yposition += X_PADDING + 130
                
            }else if dataType == DATATYPE_FILE{
                //Attche file

                let iconImage:UIImage? = UIImage(named: "attach")
                attacheFile = CustomeAttacheFile(frame: CGRect(x: X_PADDING, y: yposition, width: 130, height: 130))
                
                self.attacheFile.setImage(iconImage, for: .normal)
                self.attacheFile.accessibilityIdentifier = object.id
                self.attacheFile.addTarget(self, action: #selector(openAttchementFile(_:)), for: .touchUpInside)
                scrlView.addSubview(attacheFile)

                if object.answer != "" {
                    let filename =  object.answer.components(separatedBy: "-")[1]
                    self.attacheFile.setTitle(filename, for: .normal)
                } else {
                    self.attacheFile.setTitle(object.label.htmlToString, for: .normal)
                }
                
                yposition += X_PADDING + 130

                
            }else if dataType == DATATYPE_SIGNATURE{
                
                //SignatureView

                signatureView = YPDrawSignatureView(frame:CGRect(x: X_PADDING, y: yposition, width: Int(self.view.frame.size.width) - X_PADDING*2, height: 200))
                signatureView.backgroundColor = UIColor.clear
                signatureView.layer.cornerRadius = radius
                signatureView.layer.borderWidth = borderWidth
                signatureView.layer.borderColor = colorDividerBG_f4.cgColor
                signatureView.accessibilityIdentifier = object.id
                scrlView.addSubview(signatureView)
                
                signClearButton = CustomButton(frame: CGRect(x: Int(signatureView.frame.size.width - 70), y: Int(signatureView.frame.size.height - 45), width: 60, height: 32))
                signClearButton.backgroundColor = UIColor.gray
                signClearButton.setTitleColor(.white, for: .normal)
                signClearButton.layer.cornerRadius = radius
                self.signClearButton.setTitle("Clear", for: .normal)
                signClearButton.addTarget(self, action: #selector(signClearPressed), for: .touchUpInside)
                signatureView.addSubview(signClearButton)
                
                signatureView.delegate = self
                
                if object.answer != "" {
                    signatureImageView = UIImageView(frame:CGRect(x: 0, y: 0, width: Int(signatureView.frame.size.width), height: 200))
                    signatureImageView.backgroundColor = UIColor.clear
                    signatureImageView.layer.cornerRadius = radius
                    signatureImageView.layer.borderWidth = borderWidth
                    signatureImageView.layer.borderColor = colorDividerBG_f4.cgColor
                    signatureImageView.accessibilityIdentifier = object.id
                    signatureImageView.image = loadImageFromDocumentDirectory(fileName: object.answer)
                    signatureView.addSubview(signatureImageView)
                }
                
                yposition += X_PADDING +  Int( signatureView.bounds.height)
                
            }else if dataType == DATATYPE_RECAPTCHA{
                
                //Captch
                vCaptcha.frame = CGRect(x: X_PADDING, y: yposition, width: Int(self.view.frame.size.width) - X_PADDING*2, height: 90)
                vCaptcha.layer.borderColor = colorDividerBG_f4.cgColor
                vCaptcha.layer.borderWidth = borderWidth
                vCaptcha.layer.cornerRadius = radius
                vCaptcha.accessibilityIdentifier = object.id
                scrlView.addSubview(vCaptcha)
                setupReCaptcha()

                if object.answer == "" {
                    visibleChallengeSwitch.setOn(false, animated: true)
                } else {
                    visibleChallengeSwitch.setOn(true, animated: true)
                    vCaptcha.isUserInteractionEnabled = false
                }
                yposition += X_PADDING +  Int( vCaptcha.bounds.height)
            }else if dataType == DATATYPE_GEOLOCATION{
                let map = MapView(frame: CGRect(x: X_PADDING, y: yposition, width: Int(scrlView.frame.size.width)  - (X_PADDING * 2), height: Int(scrlView.frame.size.width)  - (X_PADDING * 2)))
                map.delegateApp = self
                
                if object.answer == "" {
                      map.initDesign(latitude: 0.0, longitute: 0.0, str_id: object.id)
                } else {
                    map.initDesign(latitude: object.lat, longitute: object.long, str_id: object.id)

                }
              
                scrlView.addSubview(map)
                yposition += X_PADDING + Int( map.bounds.height)
            }
        }
        
        let buttonREFRESH = CustomButton(frame: CGRect(x: X_PADDING, y: yposition, width: SCREEN_WIDTH - (X_PADDING*2), height: CUSTOM_BUTTON_HEIGHT))
        buttonREFRESH.setTitle("SUBMIT", for: .normal)
        buttonREFRESH.addTarget(self, action: #selector(onSubmitPressed), for: .touchUpInside)
        scrlView.addSubview(buttonREFRESH)
        self.view.addSubview(scrlView)
        
        yposition += X_PADDING +  Int( buttonREFRESH.bounds.height)
        
        scrlView.contentSize = CGSize (width: SCREEN_WIDTH, height: yposition)
        
    }
    //MARK:- SUBMIT

    @objc func onSubmitPressed()  {
        
        var param = [String : Any]()
        let id = selectedForm.id
        param.updateValue(id, forKey: "id")
        
        for object in selectedForm.fields{
            if object.answer == "" && object.required{
                self.showAlert(message: CS.Common.validationMsg, type: .error, navBar: false)
                return;
            }
            
            
        switch String(object.type) {
                
            case DATATYPE_IMAGE,DATATYPE_SIGNATURE :
                if object.answer != ""{
                    let image = loadImageFromDocumentDirectory(fileName: object.answer)
                    let imgData = image?.jpegData(compressionQuality: 0.3)
                    let ans = AGImageInfo (fileName: "\(object.id).jpg", type: Utils.mimeType(for: imgData!), data:imgData!)
                    param.updateValue(ans, forKey: object.id)
                }
                break
            case DATATYPE_VIDEO :
                if object.answer != ""{
                    let videoURL = loadVideoFromDocumentDirectory(fileName: object.answer)
                    let videoData = try? Data(contentsOf: videoURL!)
                    let ans = AGImageInfo (fileName: "\(object.id).mov", type: Utils.mimeType(for: videoData!), data: videoData!)
                    param.updateValue(ans, forKey: object.id)
                }
                break
            case DATATYPE_FILE :
                if object.answer != ""{
                    let url = URL(fileURLWithPath: object.answer)
                    let attachment = loadAttamentFromDocumentDirectory(fileName: object.answer)
                    let attmentData = try? Data(contentsOf: attachment!)
                    let ans = AGImageInfo (fileName: url.lastPathComponent, type: Utils.mimeType(for: attmentData!), data: attmentData!)
                    param.updateValue(ans, forKey: object.id)
                }
                break
            case DATATYPE_RANKINGSCALE :
                if object.answer != ""{
                    for obj in object.options{
                        param.updateValue(obj.ans_value, forKey: obj.ans_key)
                    }
                }
                break
            case DATATYPE_CHECKBOX :
                if object.checkbox_answer.count > 0{
                    var final_id = ""
                    for obj in object.checkbox_answer{
                        for option in object.options {
                            if obj == option.label{
                                final_id = option.answer
                                param.updateValue(option.label, forKey: final_id)
                            }
                        }
                    }
                }
                break
        case DATATYPE_CARRYFORWARD :
            
            if object.type == DATATYPE_CHECKBOX{
                if object.checkbox_answer.count > 0{
                    var final_id = ""
                    for obj in object.checkbox_answer{
                        for option in object.options {
                            if obj == option.label{
                                final_id = option.answer
                                param.updateValue(option.label, forKey: final_id)
                            }
                        }
                    }
                }
            }else{
                if object.answer != ""{
                    param.updateValue(object.answer, forKey: object.id)
                }
            }
            break
            case DATATYPE_GEOLOCATION :
                if object.answer != ""{
                    let strAns = "\(object.lat),\(object.long)"
                        param.updateValue(strAns, forKey: object.id)
                }
                break
            default:
                if object.answer != ""{
                    param.updateValue(object.answer, forKey: object.id)
                }
            break
            }
    }
        
        print(param)
        
            
        WebServicesManager.formSubmit(formData: param, fromId: id, andCompletion: { (isSuccess, response) in
            if isSuccess {
                if let strMsg = response["message"] as? String {
                    if strMsg != ""{
                        super.showAlert(message: strMsg.htmlToString, type: .error, navBar: false)
                        return
                    }
                }
            } else {
                super.showAlert(message: CS.Common.wrongMsg, type: .error, navBar: false)
            }
        }) { (error) in
            super.showAlert(message: CS.Common.wrongMsg, type: .error, navBar: false)
        }
    
    }

    @objc func goToBack()  {
        
         self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true


        if let listArray = ParentClass.sharedInstance.getDataForKey(strKey: EDIT_BLANK_ARRAY) as? Data {
            if let decodedArray = NSKeyedUnarchiver.unarchiveObject(with: listArray) as? [MainFormModal] {
                editListArray = decodedArray
            }
        }
     
        if type == "Edit" {
            formArray[selectedFormIndex] = selectedForm
            ParentClass.sharedInstance.editListArray = formArray
        } else {
            ParentClass.sharedInstance.editListArray.append(selectedForm)
        }

        
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: ParentClass.sharedInstance.editListArray)
        ParentClass.sharedInstance.setData(strData: encodedData, strKey: EDIT_BLANK_ARRAY)

        
        self.navigationController?.popViewController(animated: true)

    }
   

    func  getTextfield(textField :UITextField , str_id : String, selectedOption : Int){

        for obejct in selectedForm.fields {
            if  str_id ==  obejct.id {
                if selectedOption != 1000 {
                     let str_ans = "\(obejct.options[selectedOption].label): \(textField.text!)"
                    let id_ans = "\(str_id)[\(selectedOption)]"
                    obejct.answer = "yes"
                    obejct.options[selectedOption].ans_value = str_ans
                    obejct.options[selectedOption].ans_key = id_ans
                     obejct.options[selectedOption].answer = textField.text!
                } else {
                    obejct.answer = textField.text!
                }
            }
        }
    }
    
    func textViewDidBeginEditing_VC(_ textView :UITextView , str_id : String) {
        for obejct in selectedForm.fields {
            if  str_id ==  obejct.id {
                obejct.answer = textView.text!
            }
        }
    }
    
    func checkboxSelected(_ selectedOptions : [String] , str_id : String,pTag : Int) {
        
            for obejct in selectedForm.fields {
                if  str_id ==  obejct.id {
                    obejct.checkbox_answer = [String]()
                    for option in obejct.options {
                        if selectedOptions.contains(option.label) {
                            option.answer = "\(str_id)[\(option.index)]"
                            option.selected = true
                            obejct.checkbox_answer.append(option.label)
                            obejct.answer = "yes"
                        } else {
                            option.selected = false
                        }
                    }
                }
            }
    }
    func radioSelected(_ selectedOptions : String , str_id : String,pTag : Int) {
        for obejct in selectedForm.fields {
            if  str_id ==  obejct.id {
                for option in obejct.options {
                    if selectedOptions == option.label  {
                        option.selected = true
                        obejct.answer = option.label
                    } else {
                        option.selected = false
                    }
                }
            }
        }
    }
    func getLatlongFormMAP(lat : Double,long:Double,str_id : String) {
        
        for obejct in selectedForm.fields {
            if  str_id ==  obejct.id {
                obejct.answer = "yes"
                obejct.lat = lat
                obejct.long = long
            }
        }
    }
    @objc func signClearPressed(sender:UIButton) {
        signatureView.clear()
    }
    
    @objc func openAttchementFile(_ sender : UIButton){
        
        let types = [kUTTypePDF, kUTTypeText, kUTTypeRTF, kUTTypeSpreadsheet, "com.microsoft.word.doc","org.openxmlformats.wordprocessingml.document"] as [Any]
        
        self.importMenuForDocuments = UIDocumentPickerViewController(documentTypes: types as! [String], in: .import)
        self.importMenuForDocuments.delegate = self
        self.importMenuForDocuments.modalPresentationStyle = .formSheet
        self.importMenuForDocuments.view.tag = sender.tag
        self.present(self.importMenuForDocuments, animated: true, completion: nil)
    }
    
    @objc func openCamera()
    {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary)){
            picker = UIImagePickerController()
            picker!.allowsEditing = false
            picker?.delegate = self
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
        picker!.delegate = self
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
                .debug("validate OK ")
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

//            isEnabled
//                .bind(to: endpointSegmentedControl.rx.isEnabled)
//                .disposed(by: disposeBag)

            validate
                .map { [weak self] _ in
                    self?.view.viewWithTag(Constants.webViewTag)
                }
                .subscribe(onNext: { subview in
                    subview?.removeFromSuperview()
                    for obejct in self.selectedForm.fields {
                        if  sender.accessibilityIdentifier ==  obejct.id {
                            obejct.answer = "yes"
                            self.visibleChallengeSwitch.setOn(true, animated: true)
                        }
                    }
                })
                .disposed(by: disposeBag)
            validate
                .bind(to: label.rx.text)
                .disposed(by: disposeBag)

            visibleChallengeSwitch.rx.value
                .subscribe(onNext: { [weak recaptcha] value in
                    recaptcha?.forceVisibleChallenge = value
                })
                .disposed(by: disposeBag)
        }
        
        
        //Slider select a choise
        @IBAction func timeSliderChanged(sender: UISlider) {

//            let newValue = Int(sender.value/25) * 25
//            sender.setValue(Float(newValue), animated: false)
            let index = (Int)(sliderSelection!.value)
            for obejct in selectedForm.fields {
                if  sender.accessibilityIdentifier ==  obejct.id {
                    obejct.answer = "\(index)"
                }
            }

        }
        
        //SideBySide buttons actions
        @IBAction func sideBySide_tapped(_ sender: UIButton) {
            btnSide1.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
            btnSide2.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
            btnSide3.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
            btnSide4.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
            btnSide5.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
            btnSide6.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
            btnSide7.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
            btnSide8.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
            btnSide9.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
            btnSide10.setImage(#imageLiteral(resourceName: "radioBtnOff"), for: .normal)
            
            if sender.tag == 1{
                btnSide1.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
            } else if sender.tag == 2 {
                btnSide2.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
            } else if sender.tag == 3 {
                btnSide3.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
            } else if sender.tag == 4 {
                btnSide4.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
            } else if sender.tag == 5 {
                btnSide5.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
            } else if sender.tag == 6 {
                btnSide6.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
            } else if sender.tag == 7 {
                btnSide7.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
            } else if sender.tag == 8 {
                btnSide8.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
            } else if sender.tag == 9 {
                btnSide9.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
            } else if sender.tag == 10 {
                btnSide10.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
            }
            
            for obejct in selectedForm.fields {
                if  sender.accessibilityIdentifier ==  obejct.id {
                    obejct.answer = "\(sender.tag)"
                }
            }
        }
        
    func sideBySideDisplay(display: Int, leftName: String, rightName: String, str_id : String, answer : String) {
        
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
        
        btnSide1.accessibilityIdentifier = str_id
        btnSide2.accessibilityIdentifier = str_id
        btnSide3.accessibilityIdentifier = str_id
        btnSide4.accessibilityIdentifier = str_id
        btnSide5.accessibilityIdentifier = str_id
        btnSide6.accessibilityIdentifier = str_id
        btnSide7.accessibilityIdentifier = str_id
        btnSide8.accessibilityIdentifier = str_id
        btnSide9.accessibilityIdentifier = str_id
        btnSide10.accessibilityIdentifier = str_id
        
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
        
        if answer != "" && Int(answer) != nil {
            let ans = Int(answer)!
            if ans == 1{
                btnSide1.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
            } else if ans == 2 {
                btnSide2.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
            } else if ans == 3 {
                btnSide3.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
            } else if ans == 4 {
                btnSide4.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
            } else if ans == 5 {
                btnSide5.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
            } else if ans == 6 {
                btnSide6.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
            } else if ans == 7 {
                btnSide7.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
            } else if ans == 8 {
                btnSide8.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
            } else if ans == 9 {
                btnSide9.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
            } else if ans == 10 {
                btnSide10.setImage(#imageLiteral(resourceName: "radioBtnOn"), for: .normal)
            }
        }
    }
}

extension FormFieldsVC: RatingViewDelegate, YPSignatureDelegate {
    func updateRatingFormatValue(_ value: Int, str_id: String) {
        if isRatingSet == true {
            for obejct in selectedForm.fields {
                if  str_id ==  obejct.id {
                    obejct.answer = "\(value)"
                }
            }
        } else {
            isRatingSet = true
        }
    }
    
    //Image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.attachImage.setImage(image, for: .normal)
            self.attachImage.setTitle("", for: .normal)
            saveImageInDocsDir(imagesFolderName, image: image, imageName: "\(attachImage.accessibilityIdentifier!)")
        } else {
            let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as! URL
            do {
                let videoData = try Data(contentsOf: videoURL)
                saveVideoInDocsDir(imagesFolderName, video: videoData, videoName: "\(attachVideo.accessibilityIdentifier!)")
                
                let asset = AVURLAsset(url: videoURL, options: nil)
                let imgGenerator = AVAssetImageGenerator(asset: asset)
                imgGenerator.appliesPreferredTrackTransform = true
                let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
                let thumbnail = UIImage(cgImage: cgImage)
                self.attachVideo.setImage(thumbnail, for: .normal)
                self.attachVideo.setTitle("", for: .normal)
                
            } catch {
                
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if urls.count > 0 {
            
            let fileManager = FileManager.default

            let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imagesFolderName)
            
            if !fileManager.fileExists(atPath: path) {
                try! fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            }
            let documentsUrl = URL(string: path)!
            let destinationUrl = documentsUrl.appendingPathComponent(urls.first!.lastPathComponent)
            let data = try! Data(contentsOf: urls[0])
            
            self.attacheFile.setTitle(destinationUrl.path.components(separatedBy: "/").last!, for: .normal)
            
            for obejct in self.selectedForm.fields {
                if  self.attacheFile.accessibilityIdentifier ==  obejct.id {
                    obejct.answer = destinationUrl.path
                    self.saveAttamentInDocsDir(self.imagesFolderName, doc: data, docName: obejct.id , filename: destinationUrl.path.components(separatedBy: "/").last!)
                }
            }
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            dismiss(animated: true, completion: nil)
    }
    
    //Signature
    func didStart(_ view : YPDrawSignatureView) {
        scrlView.isScrollEnabled = false
        
        if signatureImageView != nil{
            signatureImageView.isHidden = true
        }
    }
    func didFinish(_ view : YPDrawSignatureView) {
        scrlView.isScrollEnabled = true
        let sign = view.getSignature()
        if sign != nil {
            saveImageInDocsDir(imagesFolderName, image: sign!, imageName: "\(view.accessibilityIdentifier!)")
        }
    }
   
    func saveImageInDocsDir(_ folderName : String, image : UIImage, imageName : String) {
        let fileManager = FileManager.default
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(folderName)
        if !fileManager.fileExists(atPath: path) {
        try! fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        let url = NSURL(string: path)
        let imagePath = url!.appendingPathComponent("\(imageName).png")
        let urlString: String = imagePath!.absoluteString
//        let imageData = image.jpegData(compressionQuality: 0.5)
        let imageData = image.pngData()
        fileManager.createFile(atPath: urlString as String, contents: imageData, attributes: nil)
        for obejct in selectedForm.fields {
            if  imageName ==  obejct.id {
                obejct.answer = "\(folderName)-\(imageName)"
            }
        }
    }
    
    func loadImageFromDocumentDirectory(fileName: String) -> UIImage? {

        let folderName = fileName.components(separatedBy: "-")[0]
        imagesFolderName = folderName
        let imageName = fileName.components(separatedBy: "-")[1]
        let fileManager = FileManager.default
        
        let imagePath = (URL(fileURLWithPath: self.configureDirectory(folderName))).appendingPathComponent("\(imageName).png")
        let urlString: String = imagePath.path
        if fileManager.fileExists(atPath: urlString) {
          let image = UIImage(contentsOfFile: urlString)
          return image
        } else {
            return nil
        }
    }
    
    func saveVideoInDocsDir(_ folderName : String, video : Data, videoName : String) {
        let fileManager = FileManager.default
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(folderName)
        if !fileManager.fileExists(atPath: path) {
            try! fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        let url = NSURL(string: path)
        let imagePath = url!.appendingPathComponent("\(videoName).mov")
        let urlString: String = imagePath!.absoluteString
        
        fileManager.createFile(atPath: urlString as String, contents: video, attributes: nil)
        for obejct in selectedForm.fields {
            if  videoName ==  obejct.id {
                obejct.answer = "\(folderName)-\(videoName)"
            }
        }
    }
    
    func saveAttamentInDocsDir(_ folderName : String, doc : Data, docName : String, filename : String) {
        let fileManager = FileManager.default
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(folderName)
        if !fileManager.fileExists(atPath: path) {
            try! fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        let url = NSURL(string: path)
        let imagePath = url!.appendingPathComponent("\(filename)")
        let urlString: String = imagePath!.absoluteString
        
        fileManager.createFile(atPath: urlString as String, contents: doc, attributes: nil)
        for obejct in selectedForm.fields {
            if  docName ==  obejct.id {
                obejct.answer =  "\(folderName)-\(filename)"
            }
        }
    }
    func loadAttamentFromDocumentDirectory(fileName: String) -> URL? {
        
        let folderName = fileName.components(separatedBy: "-")[0]
        imagesFolderName = folderName
        let videoName = fileName.components(separatedBy: "-")[1]
        
        let fileManager = FileManager.default
        
        let videoPath = (URL(fileURLWithPath: self.configureDirectory(folderName))).appendingPathComponent(videoName)
        let urlString: String = videoPath.path
        if fileManager.fileExists(atPath: urlString) {
            return videoPath
        } else {
            return nil
        }
    }
    func loadVideoFromDocumentDirectory(fileName: String) -> URL? {
        
        let folderName = fileName.components(separatedBy: "-")[0]
        imagesFolderName = folderName
        let videoName = fileName.components(separatedBy: "-")[1]
        
        let fileManager = FileManager.default
        
        let videoPath = (URL(fileURLWithPath: self.configureDirectory(folderName))).appendingPathComponent("\(videoName).mov")
        let urlString: String = videoPath.path
        if fileManager.fileExists(atPath: urlString) {
            return videoPath
        } else {
            return nil
        }
    }
    
    func configureDirectory(_ folderName : String) -> String {
        let fileManager = FileManager.default
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(folderName)
        if !fileManager.fileExists(atPath: path) {
            try! fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        return path
    }
    
    func deleteFileFromLocal(_ filePath : String) {
        do {
            let fileManager = FileManager.default
            let path = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true
            ).first!
            let db = "\(path)/\(filePath)"
            // Check if file exists
            if fileManager.fileExists(atPath: db) {
                // Delete file
                try fileManager.removeItem(atPath: db)
            } else {
            }
            
        }
        catch _ as NSError {
        }
    }
}

extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}

class FileDownloader {

//    static func loadFileSync(url: URL, completion: @escaping (String?, Error?) -> Void)
//    {
//        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//
//        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
//
//        if FileManager().fileExists(atPath: destinationUrl.path)
//        {
//            print("File already exists [\(destinationUrl.path)]")
//            completion(destinationUrl.path, nil)
//        }
//        else if let dataFromURL = NSData(contentsOf: url)
//        {
//            if dataFromURL.write(to: destinationUrl, atomically: true)
//            {
//                print("file saved [\(destinationUrl.path)]")
//                completion(destinationUrl.path, nil)
//            }
//            else
//            {
//                print("error saving file")
//                let error = NSError(domain:"Error saving file", code:1001, userInfo:nil)
//                completion(destinationUrl.path, error)
//            }
//        }
//        else
//        {
//            let error = NSError(domain:"Error downloading file", code:1002, userInfo:nil)
//            completion(destinationUrl.path, error)
//        }
//    }
//
//    static func loadFileAsync(_ folderName : String, url: URL, completion: @escaping (String? , Error?) -> Void) {
//        let fileManager = FileManager.default
//
//        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(folderName)
//
////        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//
//        if !fileManager.fileExists(atPath: path) {
//            try! fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
//        }
//
//        let documentsUrl = URL(string: path)!
//
//        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
//
//        if fileManager.fileExists(atPath: destinationUrl.path)
//        {
//            print("File already exists [\(destinationUrl.path)]")
//            completion(destinationUrl.path,nil)
//        }
//        else
//        {
//            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
//            var request = URLRequest(url: url)
//            request.httpMethod = "GET"
//
//            let task = session.dataTask(with: request, completionHandler:
//            {
//                data, response, error in
//
//                if error == nil
//                {
//                    if let data = data
//                    {
//                        if let _ = try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic)
//                        {
//                            completion(destinationUrl.path,error)
//                        }
//                        else
//                        {
//                            completion(destinationUrl.path,error)
//                        }
//                    }
//                }
//                else
//                {
//                  completion(destinationUrl.path,error)
//                }
//            })
//            task.resume()
//        }
//    }
}
