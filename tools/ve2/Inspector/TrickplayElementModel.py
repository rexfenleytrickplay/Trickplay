from PyQt4.QtCore import *
from PyQt4.QtGui import *

from PyQt4.QtNetwork import  QTcpSocket, QNetworkAccessManager , QNetworkRequest , QNetworkReply
from TrickplayElement import TrickplayElement
#from connection import *

class TrickplayElementModel(QStandardItemModel):
    
    def __init__(self, inspector, parent=None):
        QWidget.__init__(self, parent)
        self.inspector = inspector
        self.manager = QNetworkAccessManager()
        self.reply = None
        self.theBigestGid = None
        self.styleData = None

    def inspector_reply_finished(self, pdata=None, sdata=None):
        if pdata is not None :
            root = self.invisibleRootItem()
            child = None
            pdata = pdata[0]
            self.styleData = sdata

            for c in pdata["children"]:
                if c["name"] == "screen":
                    child = c
                    break
                
            if child is None:
                print( "Could not find screen element." )
            else:
                self.tpData = pdata
                self.theBigestGid = 2
                self.insertElement(root, child, pdata, True)

            self.inspector.ui.inspector.expandAll()

            gid = None

            try:
                index = self.inspector.selected(self.ui.inspector)
                item = self.itemFromIndex(index)
                gid = item['gid']
            except:
                gid = 2

            # Find the last item after getting new data so that
            # both trees reflect the changes
            if self.inspector.main.command == "newLayer" or self.inspector.main.command == "insertUIElement" :
                result = self.inspector.search(self.theBigestGid , 'gid')
                if result: 
                    self.inspector.selectItem(result)
                else:
                    print("UI Element not found")
                self.inspector.main.command == ""
            else:
                result = self.inspector.search(gid, 'gid')
                if result:
                    self.inspector.selectItem(result)
    
            if not self.inspector.ui.screenCombo.findText(self.inspector.currentScreenName) < 0 :
                self.inspector.ui.screenCombo.setCurrentIndex( self.inspector.ui.screenCombo.findText(self.inspector.currentScreenName))                
            return


    def fill(self):
        """
        Get UI data from Trickplay and fill the tree with it.
        If no data is available, do nothing.
        """
        self.tpData = None
        self.getInspectorData()
            
    def insertElement(self, parent, data, parentData, screen):
        """
        Recursively add UI Elements to the tree
        """

        """
        Parent is the parent node
        
        Data is the property data for this node
        ParentData is a reference to the dictionary containing data
        """
        
        if data is None:
            return

        try:
            value = data["name"]
        except:
            value = ""

        title = data["type"]
        gid = data['gid']

        if value[:5] == "Layer":
            title = value
            value = ""
            self.inspector.curLayerName = title
            self.inspector.curLayerGid = data['gid']

            if not self.inspector.screens["_AllScreens"].count(title) > 0:
                self.inspector.screens["_AllScreens"].append(title)
                if self.inspector.currentScreenName is not None:
                    if not self.inspector.screens[self.inspector.currentScreenName].count(title) > 0:
                        self.inspector.screens[self.inspector.currentScreenName].append(title)

        else:
            self.inspector.layerName[int(gid)] = self.inspector.curLayerName
            self.inspector.layerGid[int(gid)] = self.inspector.curLayerGid

        if gid > self.theBigestGid:
            self.theBigestGid = gid 

        if "Texture" == title:
            title = "Image"
            
        # Set the name node to gid + name
        if '' != value:   
            gs = str(gid)
            l = len(gs)
            value =  gs + ' ' * 2 * (6 - l) + value 
        else:    
            value = str(gid)
        
        node = TrickplayElement(title)
        self.node = node
        node.setTPJSON(data)
        node.setTPParent(parentData)
        node.setFlags(node.flags() ^ Qt.ItemIsEditable)

        # Add a checkbox for everything but screen
        if not screen:
            
            node.setCheckable(True)
            
            checkState = Qt.Unchecked
            if data['is_visible']:
                checkState = Qt.Checked

            node.setCheckState(checkState)
        
        # Screen has no is_visible property because changing it
        # causes problems with key presses in the app
        else:    
            del(data['is_visible'])
        
        partner = node.partner()
        partner.setFlags(partner.flags() ^ Qt.ItemIsEditable)
        partner.setData(value, Qt.DisplayRole)
        
        parent.appendRow([node, partner])
        
        # Recurse through tabs
        try:
            tabs = data['tabs']
            for r in range (0, len(tabs)) :
                #tempnode = TrickplayElement("Tab"+str(r))
                tempnode = TrickplayElement(tabs[r]['label'])
                tempnode.tabdata = data
                tempnode.tabIndex = r
                #self.node = tempnode
                tempnode.setFlags(tempnode.flags() ^ Qt.ItemIsEditable)
                partner = tempnode.partner()
                partner.setFlags(partner.flags() ^ Qt.ItemIsEditable)
                partner.setData("", Qt.DisplayRole)
                node.appendRow([tempnode, partner])
                #print r, (tabs[r]['contents'][1])
                for c in range (0, len(tabs[r]['contents'])) :
                    self.insertElement(tempnode, tabs[r]['contents'][c], data, False)
        # Element has no tabs
        except KeyError:
            pass

        # Recurse through cells
        try:
            cells = data['cells']
            #print ("Rows:", len(cells))
            #print ("Cols:", len(cells[0]))
            for r in range (0, len(cells)) :
                tempnode = TrickplayElement("Row"+str(r))
                #self.node = tempnode
                tempnode.setFlags(tempnode.flags() ^ Qt.ItemIsEditable)
                partner = tempnode.partner()
                partner.setFlags(partner.flags() ^ Qt.ItemIsEditable)
                partner.setData("", Qt.DisplayRole)
                node.appendRow([tempnode, partner])
                for c in range (0, len(cells[0])) :
                    if type(cells[r][c]) == dict:
                        self.insertElement(tempnode, cells[r][c], data, False)
                    else:
                        emptynode = TrickplayElement("Empty")
                        emptynode.setFlags(emptynode.flags() ^ Qt.ItemIsEditable)
                        partner = emptynode.partner()
                        partner.setFlags(partner.flags() ^ Qt.ItemIsEditable)
                        partner.setData("", Qt.DisplayRole)
                        tempnode.appendRow([emptynode, partner])

        # Element has no cells
        except KeyError:
            pass
        
        # Recurse through items
        try:
            if str(data['type']) == "MenuButton":
                items = data['items']
                for i in range(len(items)-1, -1, -1):
                    self.insertElement(node, items[i], data, False)
        
        # Element has no items
        except KeyError:
            pass
        
        # Recurse through contents
        try:
            contents = data['content']
            for i in range(len(contents)-1, -1, -1):
                self.insertElement(node, contents[i], data, False)
        
        # Element has no contents
        except KeyError:
            pass
        
        # Recurse through children
        try:
            children = data['children']
            for i in range(len(children)-1, -1, -1):
                self.insertElement(node, children[i], data, False)
        
        # Element has no children
        except KeyError:
            pass
        
    def empty(self):
        """
        Remove all nodes from the tree
        """
        
        self.invisibleRootItem().removeRow(0)
        
    def search(self, property, value, start = None):
        """
        Find an element where property == value
        """
        
        start = start or self.invisibleRootItem().child(0, 0)
        
        if start:
            return self.recSearch(property, value, start)
        else:
            return None
       
    def recSearch(self, property, value, item):
        
        if item[property] == None:
            return 

        if item[property] == value:
            return item
        
        # Check the item's children
        else:
            
            count = item.rowCount()
            if count > 0:
                for i in range(count):
                    result = self.recSearch(property, value, item.child(i))
                    if result:
                        return result
                        
            else:
                return None

