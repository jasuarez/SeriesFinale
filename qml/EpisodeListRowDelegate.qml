import QtQuick 1.1
import com.nokia.meego 1.0

Item {
    id: epListItem
    height: 88
    anchors.left: parent.left
    anchors.right: parent.right
    clip: true

    signal clicked
    signal pressAndHold
    signal watchToggled(bool watched)
    property alias title: title.text
    property alias subtitle: subtitle.text
    property alias iconSource: icon.source
    property variant episode: undefined

    states: [
        State {
            name: 'watched'; when: episode.isWatched
            PropertyChanges {
                target: epListItem;
                iconSource: 'image://theme/meegotouch-button-checkbox-background-pressed'
            }
            PropertyChanges {
                target: title
                color: secondaryTextColor
            }
        },
        State {
            when: !episode.isWatched
            PropertyChanges {
                target: epListItem;
                iconSource: 'image://theme/meegotouch-button-checkbox-background'
            }
            PropertyChanges {
                target: title
                color: episode.already_aired() ? activeTextColor : inactiveTextColor
            }
        }
    ]

    BorderImage {
        id: background
        anchors.fill: parent
        visible: episodeMouseArea.pressed
        source: "image://theme/meegotouch-list-background-pressed-center"
    }

    Row {
        anchors.fill: parent

        Item {
            id: markItem
            width: 70
            height: parent.height

            Image {
                id: icon
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                width: 32
                height: 32
                fillMode: "PreserveAspectFit"
                smooth: true
                visible: source != ''
            }

            MouseArea {
                id: iconMouseArea
                anchors.fill: parent
                onClicked: {
                    episode.isWatched = !episode.isWatched
                    epListItem.watchToggled(episode.isWatched)
                }
                onPressAndHold: epListItem.pressAndHold()
            }
        }

        Column {
            id: column
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width - markItem.width - drilldownImage.width

            Text {
                id: title
                width: parent.width
                font.weight: Font.Bold
                font.pixelSize: 24
                color: episode.already_aired() ? activeTextColor : inactiveTextColor
                text: episode.title
                elide: Text.ElideRight
            }

            Label {
                id: subtitle
                font.weight: Font.Light
                font.pixelSize: 22
                color: secondaryTextColor
                text: episode.airDateText
                visible: text != ""
            }
        }
    }

    Image {
        id: drilldownImage
        source: "image://theme/icon-m-common-drilldown-arrow" + (theme.inverted ? "-inverse" : "")
        anchors.right: parent.right;
        anchors.verticalCenter: parent.verticalCenter
    }

    MouseArea {
        id: episodeMouseArea
        x: column.x
        y: 0
        width: parent.width
        height: parent.height
        onClicked: epListItem.clicked()
        onPressAndHold: epListItem.pressAndHold()
    }

}
