//
//  ToolbarView.swift
//  Memorize
//

import Adwaita

struct ToolbarView: View {

    @Binding var sets: [FlashcardsSet]
    @Binding var selectedSet: String
    @Binding var search: Search
    @Binding var editSearch: Search
    @Binding var searchFocused: Bool
    @Binding var editMode: Bool
    @State private var about = false
    var app: GTUIApp
    var window: GTUIApplicationWindow
    var addSet: () -> Void

    var view: Body {
        HeaderBar {
            Button(icon: .default(icon: .listAdd)) {
                addSet()
            }
            .tooltip(Loc.addSet)
        } end: {
            menu
        }
        .headerBarTitle {
            Text(Loc.sets)
                .style("heading")
        }
        .aboutDialog(
            visible: $about,
            app: "Memorize",
            developer: "david-swift",
            version: "0.2.1",
            icon: .custom(name: "io.github.david_swift.Flashcards"),
            website: .init(string: "https://github.com/david-swift/Memorize"),
            issues: .init(string: "https://github.com/david-swift/Memorize/issues")
        )
    }

    var menu: View {
        Menu(icon: .default(icon: .openMenu), app: app, window: window) {
            MenuButton(Loc.newWindow, window: false) {
                app.addWindow("main")
            }
            .keyboardShortcut("n".ctrl())
            MenuButton(Loc.closeWindow) {
                window.close()
            }
            .keyboardShortcut("w".ctrl())
            viewMenu
            MenuSection {
                MenuButton(Loc.about, window: false) {
                    about = true
                }
            }
        }
        .primary()
        .tooltip(Loc.mainMenu)
    }

    var viewMenu: MenuSection {
        .init {
            MenuButton(Loc.search) {
                if editMode {
                    editSearch.toggle()
                    if editSearch.visible {
                        searchFocused = true
                    }
                } else {
                    search.toggle()
                    if search.visible {
                        searchFocused = true
                    }
                }
            }
            .keyboardShortcut("f".ctrl())
        }
    }

}
