#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>
#include <QTranslator>
#include <QQmlContext>
#include <QtCore/QUrl>
#include <QtCore/QCommandLineOption>
#include <QtCore/QCommandLineParser>
#include <QStyleHints>
#include <QScreen>
#include <QtQml/QQmlContext>
#include <QtWebView/QtWebView>

// Workaround: As of Qt 5.4 QtQuick does not expose QUrl::fromUserInput.
class Utils : public QObject {
    Q_OBJECT
public:
    Utils(QObject* parent = 0) : QObject(parent) { }
    Q_INVOKABLE static QUrl fromUserInput(const QString& userInput);
};

#include "applicationui.hpp"
int main(int argc, char *argv[])
{



    //! [0]
       // QtWebView::initialize();
        QGuiApplication app(argc, argv);
    //! [0]
        QGuiApplication::setApplicationDisplayName(QCoreApplication::translate("main",
                                                                               "QtWebView Example"));
        ApplicationUI appui;
        QCommandLineParser parser;
        QCoreApplication::setApplicationVersion(QT_VERSION_STR);
        parser.setApplicationDescription(QGuiApplication::applicationDisplayName());
        parser.addHelpOption();
        parser.addVersionOption();
        parser.addPositionalArgument("url", "The initial URL to open.");
        QStringList arguments = app.arguments();
        parser.process(arguments);
        const QString initialUrl = parser.positionalArguments().isEmpty() ?
            QStringLiteral("https://www.qt.io") : parser.positionalArguments().first();

        QQmlApplicationEngine engine;
        QQmlContext *context = engine.rootContext();
//        context->setContextProperty(QStringLiteral("utils"), new Utils(&engine));
//        context->setContextProperty(QStringLiteral("initialUrl"),
//                                    Utils::fromUserInput(initialUrl));
//        QRect geometry = QGuiApplication::primaryScreen()->availableGeometry();
//        if (!QGuiApplication::styleHints()->showIsFullScreen()) {
//            const QSize size = geometry.size() * 4 / 5;
//            const QSize offset = (geometry.size() - size) / 2;
//            const QPoint pos = geometry.topLeft() + QPoint(offset.width(), offset.height());
//            geometry = QRect(pos, size);
//        }
//        context->setContextProperty(QStringLiteral("initialX"), geometry.x());
//        context->setContextProperty(QStringLiteral("initialY"), geometry.y());
//        context->setContextProperty(QStringLiteral("initialWidth"), geometry.width());
//        context->setContextProperty(QStringLiteral("initialHeight"), geometry.height());
            // from QML we have access to ApplicationUI as myApp
            context->setContextProperty("myApp", &appui);

            engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
            return app.exec();
}
