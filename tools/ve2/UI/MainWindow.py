# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'MainWindow.ui'
#
# Created: Wed Jun 20 14:23:21 2012
#      by: PyQt4 UI code generator 4.8.3
#
# WARNING! All changes made in this file will be lost!

from PyQt4 import QtCore, QtGui

try:
    _fromUtf8 = QtCore.QString.fromUtf8
except AttributeError:
    _fromUtf8 = lambda s: s

class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName(_fromUtf8("MainWindow"))
        MainWindow.setEnabled(True)
        MainWindow.resize(346, 571)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Ignored, QtGui.QSizePolicy.Ignored)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(MainWindow.sizePolicy().hasHeightForWidth())
        MainWindow.setSizePolicy(sizePolicy)
        MainWindow.setMinimumSize(QtCore.QSize(200, 200))
        MainWindow.setCursor(QtCore.Qt.ArrowCursor)
        MainWindow.setLayoutDirection(QtCore.Qt.LeftToRight)
        self.centralwidget = QtGui.QWidget(MainWindow)
        self.centralwidget.setObjectName(_fromUtf8("centralwidget"))
        MainWindow.setCentralWidget(self.centralwidget)
        self.menubar = QtGui.QMenuBar(MainWindow)
        self.menubar.setGeometry(QtCore.QRect(0, 0, 346, 27))
        font = QtGui.QFont()
        font.setPointSize(11)
        self.menubar.setFont(font)
        self.menubar.setObjectName(_fromUtf8("menubar"))
        self.menuFile = QtGui.QMenu(self.menubar)
        self.menuFile.setObjectName(_fromUtf8("menuFile"))
        self.menuView = QtGui.QMenu(self.menubar)
        self.menuView.setObjectName(_fromUtf8("menuView"))
        self.menuRun = QtGui.QMenu(self.menubar)
        self.menuRun.setObjectName(_fromUtf8("menuRun"))
        self.menuEdit = QtGui.QMenu(self.menubar)
        self.menuEdit.setObjectName(_fromUtf8("menuEdit"))
        self.menuInsert_UI_Element = QtGui.QMenu(self.menuEdit)
        self.menuInsert_UI_Element.setObjectName(_fromUtf8("menuInsert_UI_Element"))
        MainWindow.setMenuBar(self.menubar)
        self.InspectorDock = QtGui.QDockWidget(MainWindow)
        self.InspectorDock.setEnabled(True)
        sizePolicy = QtGui.QSizePolicy(QtGui.QSizePolicy.Expanding, QtGui.QSizePolicy.Expanding)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.InspectorDock.sizePolicy().hasHeightForWidth())
        self.InspectorDock.setSizePolicy(sizePolicy)
        self.InspectorDock.setMinimumSize(QtCore.QSize(325, 45))
        self.InspectorDock.setContextMenuPolicy(QtCore.Qt.NoContextMenu)
        self.InspectorDock.setFeatures(QtGui.QDockWidget.AllDockWidgetFeatures)
        self.InspectorDock.setObjectName(_fromUtf8("InspectorDock"))
        self.InspectorContainer = QtGui.QWidget()
        self.InspectorContainer.setObjectName(_fromUtf8("InspectorContainer"))
        self.gridLayout_7 = QtGui.QGridLayout(self.InspectorContainer)
        self.gridLayout_7.setMargin(1)
        self.gridLayout_7.setSpacing(1)
        self.gridLayout_7.setObjectName(_fromUtf8("gridLayout_7"))
        self.InspectorLayout = QtGui.QGridLayout()
        self.InspectorLayout.setSpacing(0)
        self.InspectorLayout.setObjectName(_fromUtf8("InspectorLayout"))
        self.gridLayout_7.addLayout(self.InspectorLayout, 0, 0, 1, 1)
        self.InspectorDock.setWidget(self.InspectorContainer)
        MainWindow.addDockWidget(QtCore.Qt.DockWidgetArea(2), self.InspectorDock)
        self.actionExit = QtGui.QAction(MainWindow)
        self.actionExit.setObjectName(_fromUtf8("actionExit"))
        self.action_Exit = QtGui.QAction(MainWindow)
        font = QtGui.QFont()
        self.action_Exit.setFont(font)
        self.action_Exit.setMenuRole(QtGui.QAction.QuitRole)
        self.action_Exit.setObjectName(_fromUtf8("action_Exit"))
        self.action_Save = QtGui.QAction(MainWindow)
        font = QtGui.QFont()
        self.action_Save.setFont(font)
        self.action_Save.setObjectName(_fromUtf8("action_Save"))
        self.action_New = QtGui.QAction(MainWindow)
        font = QtGui.QFont()
        self.action_New.setFont(font)
        self.action_New.setShortcutContext(QtCore.Qt.WindowShortcut)
        self.action_New.setObjectName(_fromUtf8("action_New"))
        self.action_Cut = QtGui.QAction(MainWindow)
        font = QtGui.QFont()
        self.action_Cut.setFont(font)
        self.action_Cut.setObjectName(_fromUtf8("action_Cut"))
        self.action_Copy = QtGui.QAction(MainWindow)
        font = QtGui.QFont()
        self.action_Copy.setFont(font)
        self.action_Copy.setObjectName(_fromUtf8("action_Copy"))
        self.action_Paste = QtGui.QAction(MainWindow)
        font = QtGui.QFont()
        self.action_Paste.setFont(font)
        self.action_Paste.setObjectName(_fromUtf8("action_Paste"))
        self.action_Delete = QtGui.QAction(MainWindow)
        font = QtGui.QFont()
        self.action_Delete.setFont(font)
        self.action_Delete.setObjectName(_fromUtf8("action_Delete"))
        self.actionSelect_All = QtGui.QAction(MainWindow)
        font = QtGui.QFont()
        self.actionSelect_All.setFont(font)
        self.actionSelect_All.setObjectName(_fromUtf8("actionSelect_All"))
        self.action_Close = QtGui.QAction(MainWindow)
        self.action_Close.setIconText(_fromUtf8("Close file"))
        font = QtGui.QFont()
        self.action_Close.setFont(font)
        self.action_Close.setObjectName(_fromUtf8("action_Close"))
        self.action_Save_As = QtGui.QAction(MainWindow)
        font = QtGui.QFont()
        self.action_Save_As.setFont(font)
        self.action_Save_As.setObjectName(_fromUtf8("action_Save_As"))
        self.actionUndo = QtGui.QAction(MainWindow)
        font = QtGui.QFont()
        self.actionUndo.setFont(font)
        self.actionUndo.setObjectName(_fromUtf8("actionUndo"))
        self.actionRedo = QtGui.QAction(MainWindow)
        font = QtGui.QFont()
        self.actionRedo.setFont(font)
        self.actionRedo.setObjectName(_fromUtf8("actionRedo"))
        self.actionDebug = QtGui.QAction(MainWindow)
        self.actionDebug.setObjectName(_fromUtf8("actionDebug"))
        self.actionRun = QtGui.QAction(MainWindow)
        self.actionRun.setObjectName(_fromUtf8("actionRun"))
        self.actionStep_into = QtGui.QAction(MainWindow)
        font = QtGui.QFont()
        self.actionStep_into.setFont(font)
        self.actionStep_into.setObjectName(_fromUtf8("actionStep_into"))
        self.actionStep_over = QtGui.QAction(MainWindow)
        font = QtGui.QFont()
        self.actionStep_over.setFont(font)
        self.actionStep_over.setObjectName(_fromUtf8("actionStep_over"))
        self.actionDebug_View = QtGui.QAction(MainWindow)
        self.actionDebug_View.setObjectName(_fromUtf8("actionDebug_View"))
        self.actionRun_View = QtGui.QAction(MainWindow)
        self.actionRun_View.setObjectName(_fromUtf8("actionRun_View"))
        self.actionSave_All = QtGui.QAction(MainWindow)
        font = QtGui.QFont()
        self.actionSave_All.setFont(font)
        self.actionSave_All.setObjectName(_fromUtf8("actionSave_All"))
        self.actionSearch = QtGui.QAction(MainWindow)
        font = QtGui.QFont()
        font.setPointSize(10)
        self.actionSearch.setFont(font)
        self.actionSearch.setObjectName(_fromUtf8("actionSearch"))
        self.actionSearch_Replace = QtGui.QAction(MainWindow)
        font = QtGui.QFont()
        self.actionSearch_Replace.setFont(font)
        self.actionSearch_Replace.setObjectName(_fromUtf8("actionSearch_Replace"))
        self.actionGo_to_line = QtGui.QAction(MainWindow)
        font = QtGui.QFont()
        self.actionGo_to_line.setFont(font)
        self.actionGo_to_line.setObjectName(_fromUtf8("actionGo_to_line"))
        self.actionSearch_in_Files = QtGui.QAction(MainWindow)
        self.actionSearch_in_Files.setObjectName(_fromUtf8("actionSearch_in_Files"))
        self.actionBeutify_Selection = QtGui.QAction(MainWindow)
        self.actionBeutify_Selection.setObjectName(_fromUtf8("actionBeutify_Selection"))
        self.actionStrip_Whitespace = QtGui.QAction(MainWindow)
        self.actionStrip_Whitespace.setObjectName(_fromUtf8("actionStrip_Whitespace"))
        self.actionStep_out = QtGui.QAction(MainWindow)
        font = QtGui.QFont()
        self.actionStep_out.setFont(font)
        self.actionStep_out.setObjectName(_fromUtf8("actionStep_out"))
        self.actionStop = QtGui.QAction(MainWindow)
        self.actionStop.setObjectName(_fromUtf8("actionStop"))
        self.actionPause = QtGui.QAction(MainWindow)
        font = QtGui.QFont()
        self.actionPause.setFont(font)
        self.actionPause.setObjectName(_fromUtf8("actionPause"))
        self.actionContinue = QtGui.QAction(MainWindow)
        font = QtGui.QFont()
        self.actionContinue.setFont(font)
        self.actionContinue.setObjectName(_fromUtf8("actionContinue"))
        self.actionNew_File = QtGui.QAction(MainWindow)
        font = QtGui.QFont()
        self.actionNew_File.setFont(font)
        self.actionNew_File.setObjectName(_fromUtf8("actionNew_File"))
        self.actionNew_Folder = QtGui.QAction(MainWindow)
        font = QtGui.QFont()
        font.setPointSize(10)
        self.actionNew_Folder.setFont(font)
        self.actionNew_Folder.setObjectName(_fromUtf8("actionNew_Folder"))
        self.actionOpen_App = QtGui.QAction(MainWindow)
        font = QtGui.QFont()
        self.actionOpen_App.setFont(font)
        self.actionOpen_App.setObjectName(_fromUtf8("actionOpen_App"))
        self.actionNew_App = QtGui.QAction(MainWindow)
        font = QtGui.QFont()
        font.setPointSize(10)
        self.actionNew_App.setFont(font)
        self.actionNew_App.setObjectName(_fromUtf8("actionNew_App"))
        self.action_Run = QtGui.QAction(MainWindow)
        self.action_Run.setObjectName(_fromUtf8("action_Run"))
        self.action_Debug = QtGui.QAction(MainWindow)
        self.action_Debug.setObjectName(_fromUtf8("action_Debug"))
        self.action_Stop = QtGui.QAction(MainWindow)
        self.action_Stop.setObjectName(_fromUtf8("action_Stop"))
        self.actionPreference = QtGui.QAction(MainWindow)
        self.actionPreference.setObjectName(_fromUtf8("actionPreference"))
        self.action_Button = QtGui.QAction(MainWindow)
        self.action_Button.setObjectName(_fromUtf8("action_Button"))
        self.action_Save_2 = QtGui.QAction(MainWindow)
        self.action_Save_2.setObjectName(_fromUtf8("action_Save_2"))
        self.actionDialog_Box = QtGui.QAction(MainWindow)
        self.actionDialog_Box.setObjectName(_fromUtf8("actionDialog_Box"))
        self.actionToastAlert = QtGui.QAction(MainWindow)
        self.actionToastAlert.setObjectName(_fromUtf8("actionToastAlert"))
        self.actionProgressSpinner = QtGui.QAction(MainWindow)
        self.actionProgressSpinner.setObjectName(_fromUtf8("actionProgressSpinner"))
        self.actionOrbitting_Dots = QtGui.QAction(MainWindow)
        self.actionOrbitting_Dots.setObjectName(_fromUtf8("actionOrbitting_Dots"))
        self.actionTextInput = QtGui.QAction(MainWindow)
        self.actionTextInput.setObjectName(_fromUtf8("actionTextInput"))
        self.actionOpen_Engine_Group = QtGui.QAction(MainWindow)
        self.actionOpen_Engine_Group.setObjectName(_fromUtf8("actionOpen_Engine_Group"))
        self.actionLua_File_Engine_UI_Elements = QtGui.QAction(MainWindow)
        self.actionLua_File_Engine_UI_Elements.setObjectName(_fromUtf8("actionLua_File_Engine_UI_Elements"))
        self.actionJSON_New_UI_Elements = QtGui.QAction(MainWindow)
        self.actionJSON_New_UI_Elements.setObjectName(_fromUtf8("actionJSON_New_UI_Elements"))
        self.actionNew_Layer = QtGui.QAction(MainWindow)
        self.actionNew_Layer.setObjectName(_fromUtf8("actionNew_Layer"))
        self.actionNew_Project = QtGui.QAction(MainWindow)
        self.actionNew_Project.setObjectName(_fromUtf8("actionNew_Project"))
        self.actionOpen_Project = QtGui.QAction(MainWindow)
        self.actionOpen_Project.setObjectName(_fromUtf8("actionOpen_Project"))
        self.actionSave_Project = QtGui.QAction(MainWindow)
        self.actionSave_Project.setObjectName(_fromUtf8("actionSave_Project"))
        self.actionSlider = QtGui.QAction(MainWindow)
        self.actionSlider.setObjectName(_fromUtf8("actionSlider"))
        self.actionLayoutManager = QtGui.QAction(MainWindow)
        self.actionLayoutManager.setObjectName(_fromUtf8("actionLayoutManager"))
        self.actionScrollPane = QtGui.QAction(MainWindow)
        self.actionScrollPane.setObjectName(_fromUtf8("actionScrollPane"))
        self.actionTabBar = QtGui.QAction(MainWindow)
        self.actionTabBar.setObjectName(_fromUtf8("actionTabBar"))
        self.actionArrowPane = QtGui.QAction(MainWindow)
        self.actionArrowPane.setObjectName(_fromUtf8("actionArrowPane"))
        self.actionButtonPicker = QtGui.QAction(MainWindow)
        self.actionButtonPicker.setObjectName(_fromUtf8("actionButtonPicker"))
        self.actionMenuButton = QtGui.QAction(MainWindow)
        self.actionMenuButton.setObjectName(_fromUtf8("actionMenuButton"))
        self.menuFile.addAction(self.actionNew_Project)
        self.menuFile.addAction(self.actionOpen_Project)
        self.menuFile.addAction(self.actionSave_Project)
        self.menuFile.addAction(self.actionNew_Layer)
        self.menuFile.addAction(self.action_Exit)
        self.menuRun.addAction(self.action_Run)
        self.menuRun.addAction(self.action_Stop)
        self.menuInsert_UI_Element.addAction(self.actionArrowPane)
        self.menuInsert_UI_Element.addAction(self.action_Button)
        self.menuInsert_UI_Element.addAction(self.actionButtonPicker)
        self.menuInsert_UI_Element.addAction(self.actionDialog_Box)
        self.menuInsert_UI_Element.addAction(self.actionLayoutManager)
        self.menuInsert_UI_Element.addAction(self.actionMenuButton)
        self.menuInsert_UI_Element.addAction(self.actionProgressSpinner)
        self.menuInsert_UI_Element.addAction(self.actionOrbitting_Dots)
        self.menuInsert_UI_Element.addAction(self.actionScrollPane)
        self.menuInsert_UI_Element.addAction(self.actionSlider)
        self.menuInsert_UI_Element.addAction(self.actionTabBar)
        self.menuInsert_UI_Element.addAction(self.actionTextInput)
        self.menuInsert_UI_Element.addAction(self.actionToastAlert)
        self.menuEdit.addAction(self.menuInsert_UI_Element.menuAction())
        self.menubar.addAction(self.menuFile.menuAction())
        self.menubar.addAction(self.menuEdit.menuAction())
        self.menubar.addAction(self.menuRun.menuAction())
        self.menubar.addAction(self.menuView.menuAction())

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        MainWindow.setWindowTitle(QtGui.QApplication.translate("MainWindow", "TrickPlay Visual Editor ", None, QtGui.QApplication.UnicodeUTF8))
        self.menuFile.setTitle(QtGui.QApplication.translate("MainWindow", "File", None, QtGui.QApplication.UnicodeUTF8))
        self.menuView.setTitle(QtGui.QApplication.translate("MainWindow", "Windows", None, QtGui.QApplication.UnicodeUTF8))
        self.menuRun.setTitle(QtGui.QApplication.translate("MainWindow", "Run", None, QtGui.QApplication.UnicodeUTF8))
        self.menuEdit.setTitle(QtGui.QApplication.translate("MainWindow", "Edit", None, QtGui.QApplication.UnicodeUTF8))
        self.menuInsert_UI_Element.setTitle(QtGui.QApplication.translate("MainWindow", "Insert UI Element", None, QtGui.QApplication.UnicodeUTF8))
        self.InspectorDock.setWindowTitle(QtGui.QApplication.translate("MainWindow", "Inspector : ", None, QtGui.QApplication.UnicodeUTF8))
        self.actionExit.setText(QtGui.QApplication.translate("MainWindow", "Exit", None, QtGui.QApplication.UnicodeUTF8))
        self.action_Exit.setText(QtGui.QApplication.translate("MainWindow", "Exit", None, QtGui.QApplication.UnicodeUTF8))
        self.action_Exit.setShortcut(QtGui.QApplication.translate("MainWindow", "Ctrl+Q", None, QtGui.QApplication.UnicodeUTF8))
        self.action_Save.setText(QtGui.QApplication.translate("MainWindow", "Save file", None, QtGui.QApplication.UnicodeUTF8))
        self.action_Save.setShortcut(QtGui.QApplication.translate("MainWindow", "Ctrl+S", None, QtGui.QApplication.UnicodeUTF8))
        self.action_New.setText(QtGui.QApplication.translate("MainWindow", "Create new  app...", None, QtGui.QApplication.UnicodeUTF8))
        self.action_New.setShortcut(QtGui.QApplication.translate("MainWindow", "Ctrl+Shift+N", None, QtGui.QApplication.UnicodeUTF8))
        self.action_Cut.setText(QtGui.QApplication.translate("MainWindow", "Cut", None, QtGui.QApplication.UnicodeUTF8))
        self.action_Cut.setShortcut(QtGui.QApplication.translate("MainWindow", "Ctrl+X", None, QtGui.QApplication.UnicodeUTF8))
        self.action_Copy.setText(QtGui.QApplication.translate("MainWindow", "Copy", None, QtGui.QApplication.UnicodeUTF8))
        self.action_Copy.setShortcut(QtGui.QApplication.translate("MainWindow", "Ctrl+C", None, QtGui.QApplication.UnicodeUTF8))
        self.action_Paste.setText(QtGui.QApplication.translate("MainWindow", "Paste", None, QtGui.QApplication.UnicodeUTF8))
        self.action_Paste.setShortcut(QtGui.QApplication.translate("MainWindow", "Ctrl+V", None, QtGui.QApplication.UnicodeUTF8))
        self.action_Delete.setText(QtGui.QApplication.translate("MainWindow", "Delete", None, QtGui.QApplication.UnicodeUTF8))
        self.actionSelect_All.setText(QtGui.QApplication.translate("MainWindow", "Select all", None, QtGui.QApplication.UnicodeUTF8))
        self.actionSelect_All.setShortcut(QtGui.QApplication.translate("MainWindow", "Ctrl+A", None, QtGui.QApplication.UnicodeUTF8))
        self.action_Close.setText(QtGui.QApplication.translate("MainWindow", "Close file", None, QtGui.QApplication.UnicodeUTF8))
        self.action_Close.setShortcut(QtGui.QApplication.translate("MainWindow", "Ctrl+W", None, QtGui.QApplication.UnicodeUTF8))
        self.action_Save_As.setText(QtGui.QApplication.translate("MainWindow", "Save file as...", None, QtGui.QApplication.UnicodeUTF8))
        self.actionUndo.setText(QtGui.QApplication.translate("MainWindow", "Undo", None, QtGui.QApplication.UnicodeUTF8))
        self.actionUndo.setShortcut(QtGui.QApplication.translate("MainWindow", "Ctrl+Z", None, QtGui.QApplication.UnicodeUTF8))
        self.actionRedo.setText(QtGui.QApplication.translate("MainWindow", "Redo", None, QtGui.QApplication.UnicodeUTF8))
        self.actionRedo.setShortcut(QtGui.QApplication.translate("MainWindow", "Ctrl+R", None, QtGui.QApplication.UnicodeUTF8))
        self.actionDebug.setText(QtGui.QApplication.translate("MainWindow", "Debug", None, QtGui.QApplication.UnicodeUTF8))
        self.actionRun.setText(QtGui.QApplication.translate("MainWindow", "Run", None, QtGui.QApplication.UnicodeUTF8))
        self.actionStep_into.setText(QtGui.QApplication.translate("MainWindow", "Step Into", None, QtGui.QApplication.UnicodeUTF8))
        self.actionStep_into.setShortcut(QtGui.QApplication.translate("MainWindow", "Ctrl+I", None, QtGui.QApplication.UnicodeUTF8))
        self.actionStep_over.setText(QtGui.QApplication.translate("MainWindow", "Step over", None, QtGui.QApplication.UnicodeUTF8))
        self.actionStep_over.setShortcut(QtGui.QApplication.translate("MainWindow", "Ctrl+K", None, QtGui.QApplication.UnicodeUTF8))
        self.actionDebug_View.setText(QtGui.QApplication.translate("MainWindow", "Debug View", None, QtGui.QApplication.UnicodeUTF8))
        self.actionRun_View.setText(QtGui.QApplication.translate("MainWindow", "Run View", None, QtGui.QApplication.UnicodeUTF8))
        self.actionSave_All.setText(QtGui.QApplication.translate("MainWindow", "Save all files", None, QtGui.QApplication.UnicodeUTF8))
        self.actionSearch.setText(QtGui.QApplication.translate("MainWindow", "Search...", None, QtGui.QApplication.UnicodeUTF8))
        self.actionSearch.setShortcut(QtGui.QApplication.translate("MainWindow", "Ctrl+F", None, QtGui.QApplication.UnicodeUTF8))
        self.actionSearch_Replace.setText(QtGui.QApplication.translate("MainWindow", "Find/Replace...", None, QtGui.QApplication.UnicodeUTF8))
        self.actionSearch_Replace.setShortcut(QtGui.QApplication.translate("MainWindow", "Ctrl+F", None, QtGui.QApplication.UnicodeUTF8))
        self.actionGo_to_line.setText(QtGui.QApplication.translate("MainWindow", "Go to line...", None, QtGui.QApplication.UnicodeUTF8))
        self.actionGo_to_line.setShortcut(QtGui.QApplication.translate("MainWindow", "Ctrl+J", None, QtGui.QApplication.UnicodeUTF8))
        self.actionSearch_in_Files.setText(QtGui.QApplication.translate("MainWindow", "Search in Files...", None, QtGui.QApplication.UnicodeUTF8))
        self.actionBeutify_Selection.setText(QtGui.QApplication.translate("MainWindow", "Beutify Selection", None, QtGui.QApplication.UnicodeUTF8))
        self.actionStrip_Whitespace.setText(QtGui.QApplication.translate("MainWindow", "Strip Whitespace", None, QtGui.QApplication.UnicodeUTF8))
        self.actionStep_out.setText(QtGui.QApplication.translate("MainWindow", "Step out", None, QtGui.QApplication.UnicodeUTF8))
        self.actionStep_out.setShortcut(QtGui.QApplication.translate("MainWindow", "Ctrl+M", None, QtGui.QApplication.UnicodeUTF8))
        self.actionStop.setText(QtGui.QApplication.translate("MainWindow", "Stop", None, QtGui.QApplication.UnicodeUTF8))
        self.actionPause.setText(QtGui.QApplication.translate("MainWindow", "Pause", None, QtGui.QApplication.UnicodeUTF8))
        self.actionPause.setShortcut(QtGui.QApplication.translate("MainWindow", "Ctrl+P", None, QtGui.QApplication.UnicodeUTF8))
        self.actionContinue.setText(QtGui.QApplication.translate("MainWindow", "Continue", None, QtGui.QApplication.UnicodeUTF8))
        self.actionContinue.setShortcut(QtGui.QApplication.translate("MainWindow", "Ctrl+B", None, QtGui.QApplication.UnicodeUTF8))
        self.actionNew_File.setText(QtGui.QApplication.translate("MainWindow", "Create new file...", None, QtGui.QApplication.UnicodeUTF8))
        self.actionNew_File.setShortcut(QtGui.QApplication.translate("MainWindow", "Ctrl+N", None, QtGui.QApplication.UnicodeUTF8))
        self.actionNew_Folder.setText(QtGui.QApplication.translate("MainWindow", "New Folder", None, QtGui.QApplication.UnicodeUTF8))
        self.actionOpen_App.setText(QtGui.QApplication.translate("MainWindow", "Open existing app...", None, QtGui.QApplication.UnicodeUTF8))
        self.actionOpen_App.setShortcut(QtGui.QApplication.translate("MainWindow", "Ctrl+O", None, QtGui.QApplication.UnicodeUTF8))
        self.actionNew_App.setText(QtGui.QApplication.translate("MainWindow", "New App", None, QtGui.QApplication.UnicodeUTF8))
        self.action_Run.setText(QtGui.QApplication.translate("MainWindow", "Run", None, QtGui.QApplication.UnicodeUTF8))
        self.action_Run.setShortcut(QtGui.QApplication.translate("MainWindow", "Ctrl+F11", None, QtGui.QApplication.UnicodeUTF8))
        self.action_Debug.setText(QtGui.QApplication.translate("MainWindow", "Debug", None, QtGui.QApplication.UnicodeUTF8))
        self.action_Debug.setShortcut(QtGui.QApplication.translate("MainWindow", "F11", None, QtGui.QApplication.UnicodeUTF8))
        self.action_Stop.setText(QtGui.QApplication.translate("MainWindow", "Stop", None, QtGui.QApplication.UnicodeUTF8))
        self.action_Stop.setShortcut(QtGui.QApplication.translate("MainWindow", "Esc", None, QtGui.QApplication.UnicodeUTF8))
        self.actionPreference.setText(QtGui.QApplication.translate("MainWindow", "Preference...", None, QtGui.QApplication.UnicodeUTF8))
        self.action_Button.setText(QtGui.QApplication.translate("MainWindow", "Button", None, QtGui.QApplication.UnicodeUTF8))
        self.action_Save_2.setText(QtGui.QApplication.translate("MainWindow", "Save", None, QtGui.QApplication.UnicodeUTF8))
        self.actionDialog_Box.setText(QtGui.QApplication.translate("MainWindow", "Dialog Box", None, QtGui.QApplication.UnicodeUTF8))
        self.actionToastAlert.setText(QtGui.QApplication.translate("MainWindow", "ToastAlert", None, QtGui.QApplication.UnicodeUTF8))
        self.actionProgressSpinner.setText(QtGui.QApplication.translate("MainWindow", "ProgressSpinner", None, QtGui.QApplication.UnicodeUTF8))
        self.actionOrbitting_Dots.setText(QtGui.QApplication.translate("MainWindow", "Orbitting Dots", None, QtGui.QApplication.UnicodeUTF8))
        self.actionTextInput.setText(QtGui.QApplication.translate("MainWindow", "TextInput", None, QtGui.QApplication.UnicodeUTF8))
        self.actionOpen_Engine_Group.setText(QtGui.QApplication.translate("MainWindow", "Open Engine Group", None, QtGui.QApplication.UnicodeUTF8))
        self.actionLua_File_Engine_UI_Elements.setText(QtGui.QApplication.translate("MainWindow", "Lua File (Engine UI Elements)", None, QtGui.QApplication.UnicodeUTF8))
        self.actionJSON_New_UI_Elements.setText(QtGui.QApplication.translate("MainWindow", "JSON (New UI Elements)", None, QtGui.QApplication.UnicodeUTF8))
        self.actionNew_Layer.setText(QtGui.QApplication.translate("MainWindow", "New Layer", None, QtGui.QApplication.UnicodeUTF8))
        self.actionNew_Project.setText(QtGui.QApplication.translate("MainWindow", "New Project...", None, QtGui.QApplication.UnicodeUTF8))
        self.actionOpen_Project.setText(QtGui.QApplication.translate("MainWindow", "Open Project...", None, QtGui.QApplication.UnicodeUTF8))
        self.actionSave_Project.setText(QtGui.QApplication.translate("MainWindow", "Save Project", None, QtGui.QApplication.UnicodeUTF8))
        self.actionSlider.setText(QtGui.QApplication.translate("MainWindow", "Slider", None, QtGui.QApplication.UnicodeUTF8))
        self.actionLayoutManager.setText(QtGui.QApplication.translate("MainWindow", "LayoutManager", None, QtGui.QApplication.UnicodeUTF8))
        self.actionScrollPane.setText(QtGui.QApplication.translate("MainWindow", "ScrollPane", None, QtGui.QApplication.UnicodeUTF8))
        self.actionTabBar.setText(QtGui.QApplication.translate("MainWindow", "TabBar", None, QtGui.QApplication.UnicodeUTF8))
        self.actionArrowPane.setText(QtGui.QApplication.translate("MainWindow", "ArrowPane", None, QtGui.QApplication.UnicodeUTF8))
        self.actionButtonPicker.setText(QtGui.QApplication.translate("MainWindow", "ButtonPicker", None, QtGui.QApplication.UnicodeUTF8))
        self.actionMenuButton.setText(QtGui.QApplication.translate("MainWindow", "MenuButton", None, QtGui.QApplication.UnicodeUTF8))

