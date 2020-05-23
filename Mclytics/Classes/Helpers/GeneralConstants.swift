//
//  GeneralConstants.swift
//  VTV News
//
//  Created by Nascent Info Tech on 3/4/19.
//  Copyright © 2019 Nascent Info Tech. All rights reserved.
//

import Foundation
import UIKit

let SCREEN_WIDTH = Int(UIScreen.main.bounds.width)
let SCREEN_HEIGHT = Int(UIScreen.main.bounds.height)

var STATUS_BAR_HEIGHT = Int(UIApplication.shared.statusBarFrame.height)
let NAV_HEADER_HEIGHT = 44
let TOP_HEADER_HEIGHT = 50
let TOP_PROGRESSBAR_HEIGHT = 50
let TOP_SUBHEADER_HEIGHT = 72
let HEADER_BUTTON_WIDTH = 80
let TAB_HEADER_HEIGHT = 50.0

let NEXT_BUTTON_WIDTH = 120
let NEXT_BUTTON_HEIGHT = 50


let STEP_HEADER_HEIGHT = 2



let SUBHEADER_BUTTON_WIDTH = 40
let SUBHEADER_BUTTON_HEIGHT = 40
let LABEL_HEIGHT = 35
var LABEL_WIDTH_SE = 150
var LABEL_WIDTH = 200



let TABLEVIEW_Y_POSITION = STATUS_BAR_HEIGHT + Int(ParentClass.sharedInstance.iPhone_X_Top_Padding) + TOP_HEADER_HEIGHT + Int(TAB_HEADER_HEIGHT)

let IS_IPHONE = (UI_USER_INTERFACE_IDIOM() == .phone)
let IS_IPHONE_5 = (IS_IPHONE && UIScreen.main.bounds.size.height == 568.0)
let IS_IPHONE_6 = (IS_IPHONE && UIScreen.main.bounds.size.height == 667.0)
let IS_IPHONE_6_PLUS = (IS_IPHONE && UIScreen.main.bounds.size.height == 736.0)
let IS_IPHONE_XS_MAX = (IS_IPHONE &&  UIScreen.main.nativeBounds.size.height == 2688.0)
let IS_IPHONE_XR = (IS_IPHONE && UIScreen.main.nativeBounds.size.height == 1792.0)

// It's compatble for iphone x, xr and xmax
// So it is used for iphone x porpose as well as for iphone x,xmax and xr
// When it is used for iphone x , xmax and xr, set iphone x condition at last in if condition
let IS_IPHONE_X_XR_XMAX = (IS_IPHONE && UIScreen.main.bounds.size.height == 812.0) || (IS_IPHONE && UIScreen.main.bounds.size.height == 896.0)

let SIDE_PANEL_LABEL_CELL_HEIGHT:CGFloat = 50.0
let TABLEVIEW_CELL_HEIGHT:CGFloat = 60.0
let SIDE_PANEL_LOGO_CELL_HEIGHT:CGFloat = 90.0
let SIDE_PANEL_WIDTH:CGFloat = CGFloat(SCREEN_WIDTH) - 50.0
let SIDE_PANEL_SEPARATOR_CELL_HEIGHT:CGFloat = 21.0
let SIDE_PANEL_FOLLOW_US:CGFloat = 80.0


let DATATYPE_DROPDOWN_ICON = "downArrow"

let labelTextColor = UIColor.gray
let APP_FONT_NAME = "SFProText-Regular"
let APP_FONT_NAME_BOLD = "SFProText-Bold"
let APP_FONT_NAME_MEDIUM = "SFProText-Medium"
let LABEL_FONT_SIZE:CGFloat = 12

let TEXTFIELD_FONT_SIZE:CGFloat = 17
let BUTTON_FONT_SIZE:CGFloat = 16
let SMALL_BUTTON_FONT_SIZE:CGFloat = 13
let HEADER_LABEL_FONT_SIZE:CGFloat = 24
let SUB_HEADER_LABEL_FONT_SIZE:CGFloat = 15
let NAV_HEADER_FONT_SIZE:CGFloat = 17



// geom type
let GEOMTYPE_POINT = "Point"
let GEOMTYPE_LINESTRING = "LineString"
let GEOMTYPE_POLYGON = "Polygon"
let GEOMTYPE_MULTIPOINT = "Multi Point"
let GEOMTYPE_MULTILINESTRING = "Multi LineString"
let GEOMTYPE_MULTIPOLYGON = "Multi Polygon"

// data type
let DATATYPE_TEXT = "Text"
let DATATYPE_INTEGER = "Integer"
let DATATYPE_DATE = "Date"
let DATATYPE_TIME = "Time"
let DATATYPE_DATE_TIME = "Date and Time"
let DATATYPE_DROPDOWN = "Drop Down"
let DATATYPE_RADIO = "Radio"
let DATATYPE_CHECKBOX = "Checkbox"
let DATATYPE_IMAGE = "Image"
let DATATYPE_DOCUMENT = "Document"
let DATATYPE_AUDIO = "Audio"
let DATATYPE_VIDEO = "Video"

let DATATYPE_TEXT_ICON = "textIconDarkGrey"
let DATATYPE_INTEGER_ICON = "integerIconDarkGrey"
let DATATYPE_DATE_ICON = "dateIconDarkGrey"
let DATATYPE_TIME_ICON = "timeIconDarkGrey"
let DATATYPE_DATE_TIME_ICON = "dateAndTimeIconDarkGrey"

let DATATYPE_RADIO_ICON = "radioBtnOn"
let DATATYPE_CHECKBOX_ICON = "checkboxDarkGrey"
let DATATYPE_IMAGE_ICON = "imageIconDarkGrey"
let DATATYPE_DOCUMENT_ICON = "documentIconDarkGrey"
let DATATYPE_AUDIO_ICON = "audioIconDarkGrey"
let DATATYPE_VIDEO_ICON = "videoIconDarkGrey"

let DATATYPE_TEXT_ICON_SELECTED = "textIconBlue"
let DATATYPE_INTEGER_ICON_SELECTED = "integerIconBlue"
let DATATYPE_DATE_ICON_SELECTED = "dateIconBlue"
let DATATYPE_TIME_ICON_SELECTED = "timeIconBlue"
let DATATYPE_DATE_TIME_ICON_SELECTED = "dateAndTimeIconBlue"
let DATATYPE_DROPDOWN_ICON_SELECTED = "dropdownIconBlue"
let DATATYPE_RADIO_ICON_SELECTED = "radioBtnOnBlue"
let DATATYPE_CHECKBOX_ICON_SELECTED = "checkboxBlue"
let DATATYPE_IMAGE_ICON_SELECTED = "imageIconBlue"
let DATATYPE_DOCUMENT_ICON_SELECTED = "documentIconBlue-datatype"
let DATATYPE_AUDIO_ICON_SELECTED = "audioIconBlue"
let DATATYPE_VIDEO_ICON_SELECTED = "videoIconBlue"

// style types
let POINT_STYLETYPE_POINT = "Point"
let POINT_STYLETYPE_CIRCLE = "Circle"
let POINT_STYLETYPE_BOX = "Box"
let POINT_STYLETYPE_CROSS = "Cross"
let POINT_STYLETYPE_TRIANGLE = "Triangle"

let LINESTRING_STYLETYPE_SOLID = "Linesring_Solid"
let LINESTRING_STYLETYPE_DASH = "Linesring_Dash"
let LINESTRING_STYLETYPE_DOT = "Linesring_Dot"
let LINESTRING_STYLETYPE_DASH_DOT = "Linesring_Dash Dot"

let POLYGON_STYLETYPE_SOLID = "Polygon_Solid"
let POLYGON_STYLETYPE_DASH = "Polygon_Dash"
let POLYGON_STYLETYPE_DOT = "Polygon_Dot"
let POLYGON_STYLETYPE_DASH_DOT = "Polygon_Dash Dot"


let X_PADDING = 15
let X_PADDING_SUBHEADER = 2
let Y_PADDING = 8
let X_PADDING_FOR_COMBOBOX = 50
let CUSTOM_TEXTFIELD_HEIGHT = 30
let CUSTOM_COMBOBOX_TEXTFIELD_HEIGHT = 38
let CUSTOM_BUTTON_HEIGHT = 38



// TAG 
let TAG1 = 1
let TAG2 = 2
let TAG3 = 3
let TAG4 = 4
let TAG5 = 5
let TAG6 = 6
let TAG7 = 7
let TAG8 = 8
let TAG9 = 9
let TAG10 = 10
let TAG11 = 11
let TAG12 = 12
let TAG13 = 13
let TAG14 = 14
let TAG15 = 15
let TAG16 = 16
let TAG17 = 17
let TAG18 = 18
let TAG19 = 19
let TAG20 = 20
let TAG21 = 21

let VerificationTAG22 = 22
let VerificationTAG23 = 23
let VerificationTAG24 = 24
let VerificationTAG25 = 25

let UploadTAG101 = 26
let UploadTAG103 = 27
let UploadTAG105 = 28
let UploadTAG107 = 29
let UploadTAG109 = 30

let UploadTAG201 = 31
let UploadTAG203 = 32
let UploadTAG205 = 33
let UploadTAG207 = 34
let UploadTAG209 = 35

let VerificationTAG36 = 36
let VerificationTAG37 = 37



let HEADER_LABEL_FONT_NAME = "SFProText-Semibold"
let TAB_FONT = "SFProText-Medium"
let REGULAR_FONT_NAME = "SFProText-Regular"



// Colors
let buttonBorderColor = UIColor(red: 198.0/255.0, green: 198.0/255.0, blue: 198.0/255.0, alpha: 1.0)
let buttonTextColor = UIColor(red: 189.0/255.0, green: 189.0/255.0, blue: 189.0/255.0, alpha: 1.0)
let buttonBackgroundColor = UIColor(red: 25.0/255.0, green: 118.0/255.0, blue: 210.0/255.0, alpha: 1.0)
let textFieldTextColor = UIColor(red: 198.0/255.0, green: 198.0/255.0, blue: 198.0/255.0, alpha: 1.0)
let blueTextColor = UIColor(red: 25.0/255.0, green: 118.0/255.0, blue: 210.0/255.0, alpha: 1.0)
let grayTextColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.6)
let themeColor = UIColor(red: 0/255.0, green: 150/255.0, blue: 136/255.0, alpha: 1)

let colorPrimary = UIColor (hex: "008577")
let colorPrimaryDark = UIColor (hex: "00574")
let colorListingHeading_25 = UIColor (hex: "5F5F5F")
let colorSubHeading_76 = UIColor (hex: "767676")
let colorSubSubHeading_94 = UIColor (hex: "949494")
let colorDividerBG_f4 = UIColor (hex: "f4f4f4")
let colorPlaceHolder_C6 = UIColor (hex: "c6c6c6")
let colorBudget = UIColor (hex: "0078ff")
let colorRed = UIColor (hex: "D32F2F")


let LINE_BACKGROUND_COLOUR = UIColor.lightGray
let HEADER_BACKGROUND_COLOUR = UIColor.white
let SUBHEADER_BACKGROUND_COLOUR = UIColor(red: 0.0/255.0, green: 75.0/255.0, blue: 160.0/255.0, alpha: 1.0)
let SEPARATE_BACKGROUND_COLOUR = UIColor(red: 0.0/255.0, green: 75.0/255.0, blue: 160.0/255.0, alpha: 0.38)
let STEP_BACKGROUND_COLOUR = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.38)
let ALERT_BACKGROUND_COLOUR = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.50)

//rgba(0, 75, 160, 1)
let NOTE_COLOUR = UIColor.red
let LABEL_HEADER_COLOUR = UIColor.white

let SUB_LABEL_HEADER_COLOUR = UIColor.black
let SUB_LABEL_DESC_COLOUR = UIColor(red: 198.0/255.0, green: 198.0/255.0, blue: 198.0/255.0, alpha: 1.0)
let SUB_LABEL_DESC_FONT_SIZE:CGFloat = 11

let IMAGES_FOLDER_NAME = "ImagesPhoto"
let UNIT_IMAGES = "UnitPhoto"
let PRODUCT_IMAGES = "ProductPhoto"
let MANUFACTRUNG_IMAGES = "ManufacturingPhoto"
let ACHIEVEMENT_IMAGES = "AchievementPhoto"

let VIDEOS_FOLDER_NAME = "ManufacturingVideo"

let DOCUMENTS_FOLDER_NAME = "LocalDocuments"
let AUDIO_FOLDER_NAME = "LocalAudios"
let VIDEO_FOLDER_NAME = "LocalVideos"
let  LOADING_TITLE = "Please Wait..."
let  UPLAOD_TITLE = "Uploading..."


let STORED_UNIT_PHOTOS_KEY = "STORED_UNIT_PHOTOS"
let STORED_PRODUCT_PHOTOS_KEY = "STORED_PRODUCT_PHOTOS"
let STORED_MANIFACTURING_UNIT_PHOTOS_KEY = "STORED_MANIFACTURING_UNIT_PHOTOS_KEY"
let STORED_MANIFACTURING_UNIT_VIDEO_KEY = "STORED_MANIFACTURING_UNIT_VIDEO_KEY"
let STORED_ACHIEVEMENT_PHOTO_KEY = "STORED_ACHIEVEMENT_PHOTO_KEY"

// ============================== java script fun =================
let ADD_BTN_FUNCTION = "startDraw"
let STOP_BTN_FUNCTION = "endDraw"
let EDIT_BTN_FUNCTION = "toggleEdit"
let DELETE_BTN_FUNCTION = "toggleDelete"

// UNDO / REDO
let REDO_BTN_FUNCTION = "redo"
let UNDO_BTN_FUNCTION = "undo"

let REMOVE_FEATURE_FUNCTION = "removeFeature"
let RESET_DELETE_FUNCTION = "resetDelete"
let LOAD_FEATURE_FUNCTION = "loadFeatures"
let ZOOM_TO_FEATURE_FUNCTION = "zoomToFeature"
let GET_DRAWN_GEOMETRY_FUNCTION = "getDrawnGeometry"
let UNDO_EDIT_GEOMETRY_FUNCTION = "undoEdit"

// LIVE LOCATION
let SEND_LIVE_LOCATION_FUNCTION = "sendLiveLocation"

// SHOW LAYER / TRACKS
let SHOW_LAYER_FUNCTION = "showLayer"
let HIDE_LAYER_FUNCTION = "hideLayer"
let GET_LAYER_FUNCTION = "getLayerData"
let ADD_LAYER_FUNCTION = "addLayer"
// HSOW hide extrnal layers
let SHOW_EXTERNAL_LAYER_FUNCTION = "showWMSLayer"
let HIDE_EXTERNAL_LAYER_FUNCTION = "hideWMSLayer"

let JS_PARAMETER_TYPE_TRACK = "track"
let JS_PARAMETER_TYPE_LAYER = "layer"
let JS_PARAMETER_TYPE_EDIT = "edit"

// ===============================================================

let GEOMETRY_DB_TAG = "3857"

//let LAYER_DATA_SYNC_URL = "http://192.168.20.199:8082/api/upload/"
let LAYER_DATA_SYNC_URL = "http://192.168.20.62:8082/api/upload/"

//let LAYER_DATA_SYNC_URL = "http://192.168.20.62:8082/api/testSync"
let IMAGE_COMPRESS_QUALITY = CGFloat(0.4)

let ACCURACY_KEY = "ACCURACY_KEY"
let LAYERS__STYLE_UPDATED_KEY = "LAYERS_OR_STYLE_UPDATED_KEY"
let REMEMBER_ME_KEY = "REMEMBER_ME_KEY"
let USERNAME_KEY = "USERNAME_KEY"
let PASSWORD_KEY = "PASSWORD_KEY"
let IS_SURVEYOR_KEY = "IS_SURVEYOR_KEY"
let TOKEN_KEY = "TOKEN_KEY"

let TIMER_INTERVAL_FOR_TRACK_LOCARIONS = 2

let STORE_ADDRESS_CHANGED_ARRAY = "STORE_ADDRESS_CHANGED_ARRAY"
let STORE_NOT_TRACEBLE_ARRAY = "STORE_NOT_TRACEBLE_ARRAY"


let INSPECTION_EDIT_MODE = "INSPECTION_EDIT_MODE"
let IS_VERIFICATION_SCREEN_DONE = "IS_VERIFICATION_SCREEN_DONE"
let IS_VISITED_SCREEN = "IS_VISITED_SCREEN"


let USER_ID = "USER_ID"
let ORG_ID = "ORG_ID"
let ACCESS_ID = "ACCESS_ID"
let CATEGORY_ID = "CATEGORY_ID"
let FILL_BLANK_ARRAY = "FILL_BLANK_ARRAY"
let SAVE_ARRAY = "SAVE_ARRAY"



