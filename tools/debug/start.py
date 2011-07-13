#!/usr/bin/env python

""" 

Features to add:

1.   Two views, one for UI elements and one for properties
2.   Search by gid/name
3.   Checkboxes for hide/show
X.   Drag and drop UI elements?

"""

import sys,  pprint

from PyQt4.QtGui import *
from PyQt4.QtCore import *
from TreeView import Ui_MainWindow

from delegate import InspectorDelegate
import connection
from model import ElementModel,  pyData,  modelToData,  dataToModel
from data import modelToData,  dataToModel, BadDataException

# Custom ItemDataRoles

Qt.Pointer = Qt.UserRole + 1
Qt.Value = Qt.UserRole + 2
Qt.Element = Qt.UserRole + 3
Qt.ItemDepth = Qt.UserRole + 4
Qt.Gid = Qt.UserRole + 5
Qt.Data = Qt.UserRole + 6

class StartQT4(QMainWindow):
    def __init__(self, parent=None):

        # Main window setup
        QWidget.__init__(self, parent)
        
        self.ui = Ui_MainWindow()
        
        self.ui.setupUi(self)
        
        # Buttons
        QObject.connect(self.ui.button_Refresh, SIGNAL("clicked()"), self.refresh)
        
        QObject.connect(self.ui.action_Exit, SIGNAL("triggered()"),  self.exit)
        
        # Models
        self.inspectorModel = ElementModel()
        
        self.propertyModel = ElementModel()
        
        #self.model.connect(self.model, SIGNAL('itemChanged( QStandardItem * )'), self.itemChanged)
        
        # Delegates
        #self.inspectorDelegate = InspectorDelegate()
        
        #self.ui.inspector.setItemDelegate(self.inspectorDelegate)

        #self.inspectorDelegate.connect(self.delegate,  SIGNAL('closeEditor( QWidget * , QAbstractItemDelegate::EndEditHint )'),  self.editorClosed)
                
        self.createTree()
        
        self.preventChanges = False
        
        
    """
    Re-populate the property view every time a new UI element
    is selected in the inspector view.
    """
    def selectionChanged(self,  a,  b):
        
        #print("Selection Changed",  a,  b)
        
        i = self.inspectorSelectionModel.selection()
        
        i = self.inspectorProxyModel.mapSelectionToSource(i)
        
        s = i.indexes()[0]
        
        self.updatePropertyList(s)
        
        
    """
    Remove and re-append the list of UI Element properties in the property view
    """
    def updatePropertyList(self, inspectorElementIndex):
        
        r = self.propertyModel.invisibleRootItem()
        
        r.setData(inspectorElementIndex,  Qt.Pointer)
        
        r.removeRows(0, r.rowCount())
    
        self.inspectorModel.copyAttrs(inspectorElementIndex, r)
        
        
    """
    Update a UI Element in the app given its gid
    """
    def sendData(self,  gid,  title,  value):
    
        try:
                    
            modelToData(title, value)
        
        except BadDataException, (e):
            
            print("BadDataException",  e.value)
            
            return False
            
        # Convert the data to proper format for sending
        title, value = modelToData(title, value)
        
        print('Sending:', gid, title, value)
        
        connection.send({'gid': gid, 'properties' : {title : value}})
        
        return True
    
    """
    Allow the user to change the name of a UIElement from the inspector view
    """    
    def inspectorDataChanged(self,  topLeft,  bottomRight):
        
        if not self.preventChanges:
            
            print("preventChanges",  self.preventChanges)
            
            self.preventChanges = True
            
            # User can only select one element, so these will always be equal. This assertion can be removed later.
            if str(topLeft.data(0).toString()) ==  str(bottomRight.data(0).toString()):
                
                print("inspector dataChanged called")
                
                valueIndex = topLeft
                
                # If index is an element, it was checked or unchecked
                if 0 == valueIndex.column():
                    
                    checkState = valueIndex.model().itemFromIndex(valueIndex).checkState()
                    
                    checkState = bool(checkState)
                
                    print("checkbox changed to",  checkState)
                    
                    gid = pyData(valueIndex, Qt.Gid)
                    
                    if self.sendData(gid, 'is_visible', checkState):
                        
                        propertyValueIndex = self.inspectorModel.findAttr(valueIndex, 'is_visible')[1]
                        
                        valueIndex.model().itemFromIndex(propertyValueIndex).setData(checkState, 0)
                        
                        self.updatePropertyList(valueIndex)
                
                # Index is the element's name
                else:
                
                    titleIndex = self.inspectorModel.titleFromValue(valueIndex)
                    
                    print('title',  titleIndex.data(0).toString())
                    
                    gid = pyData(valueIndex, Qt.Gid)
                    
                    value = pyData(valueIndex, 0)
                    
                    if self.sendData(gid, 'name', value):
                        
                        propertyValueIndex = self.inspectorModel.findAttr(titleIndex, 'name')[1]
                        
                        self.inspectorModel.itemFromIndex(propertyValueIndex).setData(value, 0)
                        
                        self.updatePropertyList(titleIndex)
                
            self.preventChanges = False
        
    """
    Update Trickplay app when data is changed (by the user) in the property view
    """
    def dataChanged(self,  topLeft,  bottomRight):
        #print("dataChanged",  str(topLeft.data(0).toString()),  str(bottomRight.data(0).toString())) 
        
        if not self.preventChanges:
            
            self.preventChanges = True
            
            # User can only select one element, so these will always be equal. This assertion can be removed later.
            if str(topLeft.data(0).toString()) ==  str(bottomRight.data(0).toString()):
                
                print("property dataChanged called")
                
                r = self.propertyModel.invisibleRootItem()
                
                propertyValueIndex = topLeft
                
                propertyTitleIndex = r.child(propertyValueIndex.row(), 0)
               
                # Get the index of the UI Element in the inspector
                inspectorElementIndex = r.data(Qt.Pointer).toPyObject()
                
                gid = pyData(inspectorElementIndex, Qt.Gid)
                
                inspectorIndexPair = self.inspectorModel.findAttr(inspectorElementIndex,  str(propertyTitleIndex.data(0).toString()))
                
                #titleItem = self.inspectorModel.itemFromIndex(inspectorIndexPair[0])
                
                valueItem = self.inspectorModel.itemFromIndex(inspectorIndexPair[1])
                
                title = pyData(propertyTitleIndex, 0)
                
                value = pyData(propertyValueIndex, 0)
                
                # Verify data is  OK before making any changes to model
                if self.sendData(gid, title, value):
                    
                    # Update the checkbox
                    if "is_visible" == title:
                        
                        if value:
                            
                            value = 2
                        
                        inspectorElementIndex.model().itemFromIndex(inspectorElementIndex).setCheckState(value)
                        
                    # Update the data in the inspector
                    valueItem.setData(value,  0)
                    
            else:
                
                print("ERROR >> Multiple dataChanged's")
                
            self.preventChanges = False
        
    """
    Initialize models, proxy models, selection models, and connections
    """
    def createTree(self):

        # Set up Inspector
        self.inspectorModel.initialize(["UI Element",  "Name"],  True)

        # Inspector Proxy Model
        self.inspectorProxyModel= QSortFilterProxyModel()
        
        self.inspectorProxyModel.setSourceModel(self.inspectorModel)
        
        self.inspectorProxyModel.setFilterRole(0)

        self.inspectorProxyModel.setFilterRegExp(QRegExp("(Group|Image|Text|Rectangle|Clone)"))
        
        self.ui.inspector.setModel(self.inspectorProxyModel)
        
        # Inspector Selection Model
        self.inspectorSelectionModel = QItemSelectionModel(self.inspectorProxyModel)
        
        self.ui.inspector.setSelectionMode(QAbstractItemView.SingleSelection)
        
        self.ui.inspector.setSelectionModel(self.inspectorSelectionModel)
        
        # Set up Property
        self.ui.property.setModel(self.propertyModel)
        
        self.propertyModel.initialize(["UI Element Property",  "Value"],  False)
        
        self.propertySelectionModel = QItemSelectionModel(self.propertyModel)
        
        self.ui.property.setSelectionModel(self.propertySelectionModel)

        # Property Proxy Model
        self.propertyProxyModel= QSortFilterProxyModel()
        
        self.propertyProxyModel.setSourceModel(self.propertyModel)
        
        self.propertyProxyModel.setFilterRole(0)

        self.propertyProxyModel.setFilterRegExp(QRegExp("(opacity|is_visible|scale|clip|anchor_point|x|y|z|h|w"+\
        "|gid|type|source|src|tile|border_color|border_width|color|text)"))
        
        self.ui.property.setModel(self.propertyProxyModel)
        
        # Connections
        self.inspectorSelectionModel.connect(self.inspectorSelectionModel, SIGNAL("selectionChanged(QItemSelection, QItemSelection)"), self.selectionChanged)
        
        self.inspectorModel.connect(self.inspectorModel, SIGNAL("dataChanged(const QModelIndex&,const QModelIndex&)"), self.inspectorDataChanged)
        
        self.propertyModel.connect(self.propertyModel, SIGNAL("dataChanged(const QModelIndex&,const QModelIndex&)"), self.dataChanged)
        
        
    def refresh(self):
        self.preventChanges = True
        self.inspectorModel.refreshRoot()
        self.preventChanges = False
        
    def exit(self):
        sys.exit()

def main(argv):
    
    app = QApplication(argv)
    myapp = StartQT4()
    myapp.show()
    sys.exit(app.exec_())
    
if __name__ == "__main__":
    
    main(sys.argv)

