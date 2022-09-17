import QtQuick 2.2
import QtQuick.Controls 1.1
import QtWebView 1.1
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.2

import "./Components"
Item {
    property bool showProgress: webView.loading
                                && Qt.platform.os !== "ios"
                                && Qt.platform.os !== "winrt"
    anchors.fill: parent
    property string urlSearch: "https://google.com"

    Rectangle{
        id:navigationBarRec
        width: parent.width
        height: 45
        RowLayout {
            id: navigationBar
            width: parent.width
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter
            spacing: 0
            SmartButton{
                id:backButton
                enabled: webView.canGoBack
                sourceIcon: "qrc:/images/left-32.png"
                width: 40
                height: 40
                buttonText: "";
                color: transparentColor
                hoverColor: transparentColor
                pressColor: transparentColor
                borderColor: transparentColor
                fontSize: 10
                borderWidth: 1
                borderRadius: height/2
                onClicked: {
                    webView.goBack()
                }

            }
            SmartButton{
                id:forwardButton
                enabled:webView.canGoForward
                sourceIcon: "qrc:/images/right-32.png"
                width: 40
                height: 40
                buttonText: "";
                color: transparentColor
                hoverColor: transparentColor
                pressColor: transparentColor
                borderColor: transparentColor
                fontSize: 10
                borderWidth: 1
                borderRadius: height/2
                onClicked: {
                    webView.goForward()
                }

            }
            SmartButton{
                id:reloadButton
                enabled:webView.canGoForward
                sourceIcon: webView.loading ? "qrc:/images/stop-32.png" : "qrc:/images/refresh-32.png"
                width: 40
                height: 40
                buttonText: "";
                color: transparentColor
                hoverColor: transparentColor
                pressColor: transparentColor
                borderColor: transparentColor
                fontSize: 10
                borderWidth: 1
                borderRadius: height/2
                onClicked: {
                   webView.loading ? webView.stop() : webView.reload()
                }

            }

            Item { Layout.preferredWidth: 5 }

            TextField {
                Layout.fillWidth: true
                id: urlField
                inputMethodHints: Qt.ImhUrlCharactersOnly | Qt.ImhPreferLowercase
                text: webView.url
                onAccepted: webView.url = utils.fromUserInput(text)
                ProgressBar {
                    anchors.centerIn: parent
                    z: Qt.platform.os === "android" ? -1 : 1
                    visible: showProgress
                    value: webView.loadProgress == 100 ? 0 : webView.loadProgress
                }
            }

            Item { Layout.preferredWidth: 5 }
            SmartButton{
                id:goButton
                width: 80
                height: 30
                buttonText: "Search";
                color: "Blue"
                hoverColor: "lightblue"
                pressColor: transparentColor
                borderColor: transparentColor
                fontSize: 10
                borderWidth: 1
                borderRadius: 6
                onClicked: {
                    Qt.inputMethod.commit()
                    Qt.inputMethod.hide()
                    webView.url =urlField.text
                }

            }

            Item { Layout.preferredWidth: 10 }
        }

    }



    WebView {
        id: webView
        anchors{
            top: navigationBarRec.bottom
            left: parent.left
            right: parent.right
            bottom: showProgress ? showProgress.top : parent.bottom
        }

        url: urlSearch
        onLoadingChanged: {
            if (loadRequest.errorString)
                console.error(loadRequest.errorString);
        }
    }

    Rectangle{
        width: parent.width
        height: 30
        id: statusBar
        visible: showProgress
        anchors{
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        RowLayout {
            anchors.fill: parent
            Label { text: webView.loadProgress == 100 ? qsTr("Done") : qsTr("Loading: ") + webView.loadProgress + "%" }
        }
    }
}
