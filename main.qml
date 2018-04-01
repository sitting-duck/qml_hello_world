import AThread 1.0
import QtQuick 2.6
import QtQuick.Window 2.2

Window {
    visible: true
    width: 500
    height: 500

    //RectEllipseTool {}

    Controller {
        id: controller
        Component.onCompleted: {
            console.log("calling operate signal");
            controller.operate("test");
        }

        onFinished: {
            console.log("I'm finished");
        }

    }

}
