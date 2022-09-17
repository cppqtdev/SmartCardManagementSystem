import QtQuick 2.0
import QtQuick.Controls 2.5
import"../Components"
import QtQuick.Controls.Material 2.3
import "../"
Rectangle{
    width: parent.width
    height: 40
    color:  isDarkTheme ? primaryDarkColor:primaryColor//"lightgrey"
    Timer {
            interval: 1; running: true; repeat: true
            onTriggered: {
                time.text= Qt.formatTime(new Date(), "hh:mm:ss AP")
            }
        }
    SmartLable{
        id:time
        anchors.centerIn: parent
        color: "white"
    }

    SmartButton{
        id:menuButton
        anchors{
            left: parent.left
            verticalCenter: parent.verticalCenter
            leftMargin: 10
        }
        sourceIcon: "qrc:/images/"+iconFolder+"/"+ "menu.png"
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
            console.log("Drawer Button Clicked !")
            navigationBar.open()
        }

    }
    SmartButton{
        id:homeButton
        anchors{
            left: menuButton.right
            verticalCenter: parent.verticalCenter
            leftMargin: 10
        }
        width: 40
        height: 40
        buttonText: "";
        sourceIcon: "qrc:/images/"+iconFolder+"/"+ navigationModel[0].icon
        color: "transparent"
        hoverColor: "transparent"
        pressColor: "transparent"
        borderColor: "transparent"
        fontSize: 10
        borderWidth: 1
        borderRadius: height/2
        onClicked: {
            console.log("Home Button Clicked !")
             mainLoader.sourceComponent  = stackViewPage

        }

    }
    Component{
        id:webView
        WebViewPage{

        }
    }


    SmartButton{
        id:helpButton
        anchors{
            right: onlineButton.left
            verticalCenter: parent.verticalCenter
            rightMargin: 10
        }
        width: 40
        height: 40
        buttonText: "";
        sourceIcon: "qrc:/images/"+iconFolder+"/"+ "colors.png"
        color: "transparent"
        hoverColor: "transparent"
        pressColor: "transparent"
        borderColor: "transparent"
        fontSize: 10
        borderWidth: 1
        borderRadius: height/2
        onClicked: {
            mainLoader.sourceComponent  = webView
        }

    }
    SmartButton{
        id:onlineButton
        anchors{
            right: parent.right
            verticalCenter: parent.verticalCenter
            rightMargin: 10
        }
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
            settingsDrawer.open()
        }

    }
}
