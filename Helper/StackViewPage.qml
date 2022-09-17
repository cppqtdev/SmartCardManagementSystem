import QtQuick 2.0
import QtQuick.Controls 2.5
Item {
    id:appWindow
    anchors.fill: parent
    GlobalTitleBar{
        id:titleBar
        width: parent.width
        height: 50
        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
        }
    }
    StackView{
        id:stack
        anchors.fill: parent
    }
}
