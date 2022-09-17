import QtQuick 2.0
import QtQuick.Controls 2.0

Text {
    text: 'Smart Text'

    // color can be set on the entire element with this property
    color: "grey"

    // font properties can be set effciently on the whole string at once
    font { family: 'Courier'; pixelSize: 20; italic: false;bold:true; capitalization: Font.SmallCaps }

}
