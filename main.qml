import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import "./Components"
import "./Helper" as Helper
import "./navigation"
import "./popups"
import "./pages"
ApplicationWindow {
    id:appWindow
    width: 640
    height: 480
    visible: true
    title: qsTr("Web Application Qt Dev")
    property bool isLandscape: width > height

    property bool backKeyBlocked: false
    property var activationPolicy: {
         "NONE":0, "IMMEDIATELY":1, "LAZY":2, "WHILE_CURRENT":3
     }
    property color transparentColor: "transparent"

    // primary and accent properties:
    property variant primaryPalette: myApp.defaultPrimaryPalette()
    property color primaryLightColor: primaryPalette[0]
    property color primaryColor: primaryPalette[1]
    property color primaryDarkColor: primaryPalette[2]
    property color textOnPrimaryLight: primaryPalette[3]
    property color textOnPrimary: primaryPalette[4]
    property color textOnPrimaryDark: primaryPalette[5]
    property string iconOnPrimaryLightFolder: primaryPalette[6]
    property string iconOnPrimaryFolder: primaryPalette[7]
    property string iconOnPrimaryDarkFolder: primaryPalette[8]
    property variant accentPalette: myApp.defaultAccentPalette()
    property color accentColor: accentPalette[0]
    property color textOnAccent: accentPalette[1]
    property string iconOnAccentFolder: accentPalette[2]
    Material.primary: primaryColor
    Material.accent: accentColor
    // theme Dark vs Light properties:
    property variant themePalette: myApp.defaultThemePalette()
    property color dividerColor: themePalette[0]
    property color cardAndDialogBackground: themePalette[1]
    property real primaryTextOpacity: themePalette[2]
    property real secondaryTextOpacity: themePalette[3]
    property real dividerOpacity: themePalette[4]
    property real iconActiveOpacity: themePalette[5]
    property real iconInactiveOpacity: themePalette[6]
    property string iconFolder: themePalette[7]
    property int isDarkTheme: themePalette[8]
    property color flatButtonTextColor: themePalette[9]
    property color popupTextColor: themePalette[10]
    property real toolBarActiveOpacity: themePalette[11]
    property real toolBarInactiveOpacity: themePalette[12]
    property color toastColor: themePalette[13]
    property real toastOpacity: themePalette[14]
    // Material.dropShadowColor  OK for Light, but too dark for dark theme
    property color dropShadow: isDarkTheme? "#E4E4E4" : Material.dropShadowColor
    onIsDarkThemeChanged: {
        if(isDarkTheme == 1) {
            Material.theme = Material.Dark
        } else {
            Material.theme = Material.Light
        }
    }
    // font sizes - defaults from Google Material Design Guide
    property int fontSizeDisplay4: 112
    property int fontSizeDisplay3: 56
    property int fontSizeDisplay2: 45
    property int fontSizeDisplay1: 34
    property int fontSizeHeadline: 24
    property int fontSizeTitle: 20
    property int fontSizeSubheading: 16
    property int fontSizeBodyAndButton: 14 // is Default
    property int fontSizeCaption: 12
    property int fontSizeActiveNavigationButton: 14
    property int fontSizeInactiveNavigationButton: 12
    // fonts are grouped into primary and secondary with different Opacity
    // to make it easier to get the right property,
    // here's the opacity per size:
    property real opacityDisplay4: secondaryTextOpacity
    property real opacityDisplay3: secondaryTextOpacity
    property real opacityDisplay2: secondaryTextOpacity
    property real opacityDisplay1: secondaryTextOpacity
    property real opacityHeadline: primaryTextOpacity
    property real opacityTitle: primaryTextOpacity
    property real opacitySubheading: primaryTextOpacity
    // body can be both: primary or secondary text
    property real opacityBodyAndButton: primaryTextOpacity
    property real opacityBodySecondary: secondaryTextOpacity
    property real opacityCaption: secondaryTextOpacity

    property var navigationModel: [
        {"type": "../navigation/DrawerNavigationButton.qml", "name": "Home", "icon": "home.png", "source": "../navigation/HomeNavigation.qml", "showCounter":false, "showMarker":false, "a_p":1},
        {"type": "../navigation/DrawerDivider.qml", "name": "", "icon": "", "source": "", "a_p":1},
        {"type": "../navigation/DrawerSubtitle.qml", "name": "Transitoptions", "icon": "", "source": "", "a_p":1},
        {"type": "../navigation/DrawerNavigationButton.qml", "name": "Car", "icon": "car.png", "source": "../pages/PageOne.qml", "showCounter":true, "showMarker":false, "a_p":2},
        {"type": "../navigation/DrawerNavigationButton.qml", "name": "Bus", "icon": "bus.png", "source": "../pages/PageTwo.qml", "showCounter":false, "showMarker":false, "a_p":2},
        {"type": "../navigation/DrawerNavigationButton.qml", "name": "Subway", "icon": "subway.png", "source": "../pages/PageThree.qml", "showCounter":false, "showMarker":true, "a_p":3},
        {"type": "../navigation/DrawerNavigationButton.qml", "name": "Truck", "icon": "truck.png", "source": "../pages/PageFour.qml", "showCounter":false, "showMarker":false, "a_p":2},
        {"type": "../navigation/DrawerNavigationButton.qml", "name": "Flight", "icon": "flight.png", "source": "../pages/PageFive.qml", "showCounter":false, "showMarker":true, "a_p":1},
        {"type": "../navigation/DrawerDivider.qml", "name": "", "icon": "", "source": "", "a_p":1},
        {"type": "../navigation/DrawerNavigationButton.qml", "name": "Settings", "icon": "settings.png", "source": "../pages/SettingsPage.qml", "showCounter":false, "showMarker":false, "a_p":3},
        {"type": "../navigation/DrawerNavigationButton.qml", "name": "Color Schema", "icon": "colors.png", "source": "../pages/ColorSchemaPage.qml", "showCounter":false, "showMarker":false, "a_p":2},
        {"type": "../navigation/DrawerNavigationTextButton.qml", "name": "About this App", "icon": "", "source": "../pages/AboutPage.qml", "showCounter":false, "showMarker":false, "a_p":3}
    ]
    property var navigationData: [
        {"counter":0, "marker":""},
        {},
        {},
        {"counter":3, "marker":""},
        {"counter":0, "marker":""},
        {"counter":0, "marker":"green"},
        {"counter":0, "marker":""},
        {"counter":0, "marker":"red"},
        {},
        {"counter":0, "marker":""},
        {"counter":0, "marker":""},
        {"counter":0, "marker":""}
    ]
    property var favoritesModel: [0,3,4,5]
    property int navigationIndex: 0
    property int navigationIndex2: 0
    onNavigationIndex2Changed: {
         favMenuLoader.source = navigationModel[navigationIndex2]["source"]
    }
     onNavigationIndexChanged: {
         mainLoader.source = navigationModel[navigationIndex]["source"]

     }
     property bool hideTitleBar: false
     property bool showFavorites: true
     property bool highlightActiveNavigationButton : true


 function showInfo(info) {
     popupInfo.text = info
     popupInfo.buttonText = qsTr("OK")
     popupInfo.open()
 }

 PopupInfo {
     id: popupInfo
     onAboutToHide: {
         popupInfo.stopTimer()
         resetFocus()
     }
 } // popupInfo

 function showToast(info) {
     popupToast.text = info
     popupToast.open()
 }

 // PopupToast
 PopupToast {
     id: popupToast
     onAboutToHide: {
         resetFocus()
     }
 }
Helper. GlobalTitleBar{
     id:titleBar
     width: parent.width
     height: 50
     anchors{
         top: parent.top
         left: parent.left
         right: parent.right
     }
 }
    Loader{
        id:mainLoader
        clip: true
        anchors{
            top: titleBar.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        sourceComponent: stackViewPage
    }
    Component{
        id:stackViewPage
        StackView{
            id:stack
            anchors.fill: parent
            initialItem : homePage
        }
    }
    Component{
        id:homePage
        HomePage{}
    }
    DrawerNavigationBar {
           id: navigationBar
    }

    Repeater {
        id: destinations
        model: navigationModel
        Destination {
            id: destinationLoader
        }
    }


    // Settings Page Drawer Build
    Drawer{
        id:settingsDrawer
        width: parent.width*0.4
        height: parent.height
        edge: Qt.RightEdge
        Page{
            anchors.fill: parent
            header:Rectangle{
                width: parent.width
                height: 40
                color: transparentColor
                Column{
                    width: parent.width
                    height: parent.height
                   Rectangle{
                    color: "grey"
                    width: parent.width
                    height: 1
                }
               Row{
                   spacing: 10
                   SmartButton{
                       id:crossButton
                       sourceIcon:"qrc:/images/"+iconFolder+"/"+ "settings.png"
                       width: 40
                       height: 40
                       buttonText: "";
                       color: "transparent"
                       hoverColor: "transparent"
                       pressColor: "transparent"
                       borderColor: "transparent"
                       fontSize: 10
                       borderWidth: 1
                       borderRadius: height/2
                       onClicked: {
                           console.log("Button Clicked !")
                       }
                   }

                Label {
                    font.weight: Font.Medium
                    font.pixelSize: 18
                    opacity: 0.8
                    anchors.verticalCenter: crossButton.verticalCenter
                    text: navigationModel[navigationIndex2]["name"]
                }
                   }
                Rectangle{
                    color: "grey"
                    width: parent.width
                    height: 1
                }
                }
            }
            Loader {
                id: favMenuLoader
                anchors.fill: parent
                clip: true
                sourceComponent: favMenuComponent1
            }
            Component {
                id: favMenuComponent1
                HomeNavigation{

                }
            }

            footer: Rectangle{
                width: parent.width
                height: 50
                color: transparentColor
                DrawerFavoritesNavigationBar{
                    width: parent.width
                    anchors.centerIn: parent
                }

            }


        }
    }


}
