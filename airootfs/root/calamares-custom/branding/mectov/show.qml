import QtQuick 2.15
import calamares.slideshow 1.0

Presentation {
    id: presentation

    Timer {
        interval: 5000
        running: presentation.activatedInCalamares
        repeat: true
        onTriggered: presentation.goToNextSlide()
    }

    Slide {
        Rectangle {
            anchors.fill: parent
            color: "#1a1b26"

            Column {
                anchors.centerIn: parent
                spacing: 20

                Text {
                    text: "Welcome to Mectov Linux"
                    font.pixelSize: 32
                    font.bold: true
                    color: "#7aa2f7"
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "An Arch-based distribution with KDE Plasma\nBuilt for power users who love customization."
                    font.pixelSize: 16
                    color: "#c0caf5"
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    lineHeight: 1.5
                }
            }
        }
    }

    Slide {
        Rectangle {
            anchors.fill: parent
            color: "#1a1b26"

            Column {
                anchors.centerIn: parent
                spacing: 20

                Text {
                    text: "🚀 Pre-configured & Ready"
                    font.pixelSize: 28
                    font.bold: true
                    color: "#7aa2f7"
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "• KDE Plasma desktop — fully themed\n• Fish shell with Starship prompt\n• PipeWire audio — just works\n• NetworkManager — connect instantly\n• Flatpak — access to thousands of apps"
                    font.pixelSize: 15
                    color: "#c0caf5"
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    lineHeight: 1.8
                }
            }
        }
    }

    Slide {
        Rectangle {
            anchors.fill: parent
            color: "#1a1b26"

            Column {
                anchors.centerIn: parent
                spacing: 20

                Text {
                    text: "🎮 Gaming & Multimedia"
                    font.pixelSize: 28
                    font.bold: true
                    color: "#7aa2f7"
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "• Vulkan drivers included\n• NVIDIA & AMD support out of the box\n• VLC media player\n• Modern codec support"
                    font.pixelSize: 15
                    color: "#c0caf5"
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    lineHeight: 1.8
                }
            }
        }
    }

    Slide {
        Rectangle {
            anchors.fill: parent
            color: "#1a1b26"

            Column {
                anchors.centerIn: parent
                spacing: 20

                Text {
                    text: "✨ Thank You"
                    font.pixelSize: 28
                    font.bold: true
                    color: "#bb9af7"
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "Mectov Linux is being installed.\nPlease wait while we set up your system.\n\nMade with ❤️ by Mectov"
                    font.pixelSize: 15
                    color: "#c0caf5"
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    lineHeight: 1.8
                }
            }
        }
    }
}
