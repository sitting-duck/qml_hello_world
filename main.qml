import QtQuick 2.6
import QtQuick.Window 2.2

import QtQuick.Controls 1.4
import com.ashleytharp.imageio 1.0

ApplicationWindow {
    visible: true
    width: 500
    height: 500
    title: "test"

    //RectEllipseTool {}

//    Controller {
//        id: controller
//        Component.onCompleted: {
//            console.log("calling operate signal");
//            controller.operate("test");
//        }

//        onFinished: {
//            console.log("I'm finished");
//        }
//    }

    ImageIO {
        id: imageio
    }

    menuBar: MenuBar {
            Menu {
                title: "File"
                MenuItem {
                    text: "Open..."
                    onTriggered: {
                        imageio.getOpenFileNames();
                    }
                }
                MenuItem { text: "Close" }
            }

////            Menu {
////                title: "Edit"
////                MenuItem { text: "Cut" }
////                MenuItem { text: "Copy" }
////                MenuItem { text: "Paste" }
////            }
        }



}
