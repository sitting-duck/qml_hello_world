QT += core quick
CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += main.cpp \
    filelogger.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

TARGET = Hello_Automation

#INCLUDEPATH += "$$PWD/thirdpartylibs/cutelogger/include"

CONFIG(release, debug|release) {
#    LIBS += -L"$$PWD/thirdpartylibs/cutelogger/libr"
} else {
#    LIBS += -L"$$PWD/thirdpartylibs/cutelogger/libd"
}

macx {

    DEFINES += MAC
    QMAKE_MACOSX_DEPLOYMENT_TARGET = 10.8
    QMAKE_RPATHDIR += "@loader_path/../Frameworks/"
    QMAKE_RPATHDIR += "@loader_path/../../Frameworks/"

    LIBS_PRIVATE += -framework Cocoa -lz
    LIBS_PRIVATE += -framework CoreFoundation -lz

    CONFIG(debug,debug|release) {
        message( debug )
        QMAKE_CXXFLAGS_DEBUG += -stdlib=libc++  -std=c++11
        QMAKE_LFLAGS_DEBUG= -lc++
    } else {
        message( release ) DEFINES += NDEBUG
        QMAKE_CXXFLAGS_RELEASE += -O3 -stdlib=libc++  -std=c++11#-lstdc++
        QMAKE_LFLAGS_RELEASE += -lc++
    }

    INCLUDEPATH += "/usr/local/include"
    #LIBS += -L"/usr/local/lib/" -llcms2

    #LIBS += -lOpenImageIO
#    LIBS += -L"/usr/local/lib" -lOpenImageIO

    #INCLUDEPATH += "/usr/local/include/zlib"
    #LIBS += -L"/usr/local/lib" -lz

    #INCLUDEPATH += "/usr/local/include/minizip"
    #LIBS += -L"/usr/local/lib" -lminizip
}

OTHER_FILES += \
    RectEllipseTool.qml \
    OverlayBase.qml

HEADERS += \
    filelogger.h
