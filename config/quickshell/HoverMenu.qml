import Quickshell
import QtQml
import QtQuick


PopupWindow {
    id: root 
    anchor.window: barPanel
    anchor.rect.x: parentWindow.width / 2 - width / 2
    anchor.rect.y: parentWindow.height
    implicitWidth: 500
    implicitHeight: 500
    visible:false
    Item {
        id: popupContent
        anchors.fill: parent
        opacity: 1
    }
    MouseArea{
        id:popupArea
        anchors.fill: parent
        hoverEnabled: true
        onExited: popupTimer.restart()
        onEntered: {
            popupTimer.stop()
            fadeOut.stop()
            popupContent.opacity = 1
        }
    }
    Timer{
        id:popupTimer
        interval:2000
        onTriggered:{if(!popupArea.containsMouse){fadeOut.start()}}
    }
    OpacityAnimator {
        id:fadeOut
        target: popupContent
        from: 1
        to: 0
        duration: 500
        onFinished: root.visible = false    
    }
}
