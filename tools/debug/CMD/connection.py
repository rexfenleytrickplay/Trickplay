import httplib, urllib, urllib2, json
import os, time
from socket import error

class Connection():
    
    def __init__(self, address, port):
        self.address = address        
        self.port = port
    
    def get(self):
        """
        Get the current address and port selected
        """
        
        s = str(self.address) + ':' + str(self.port)
        #print('Address returned', s)
        return s
    
    def set(self, address, port):
        """
        Set the current address and port
        """
        
        self.address = address        
        self.port = port
    
# TODO:
# Better way of passing connection between widgets?
CON = Connection('', '')

def send(data):
    """
    Send UI parameters for Trickplay to change
    """
    
    params = json.dumps(data)
    conn = httplib.HTTPConnection( CON.get() )
    
    try:
        conn.request("POST", "/debug/ui", params)
        response = conn.getresponse()
        data = response.read()
        conn.close()
        return True

    except error, e:
        print("Error >> Trickplay Application unavailable.")
        print(e)
        return False
        
def getTrickplayData():
    """
    Get Trickplay UI tree data for the inspector
    """
    
    s = CON.get()
    r = urllib2.Request("http://" + s + "/debug/ui")
    f = None
    
    try:
        f = urllib2.urlopen(r)
        return decode(f.read())
    
    # Connection refused
    except urllib2.URLError, e:
        print("Error >> Connection to Trickplay application unsuccessful.")
        print(e)
    
    except httplib.BadStatusLine, e:
        print("Error >> Trickplay application closed before data could be retreived.")
        print(e)
    
    except httplib.InvalidURL, e:
        print('Could not find a Trickplay device.')
        print(e)
        
    return None
 
  
def sendTrickplayDebugCommand(db_port, cmd, start=False):
    """
    Send Start Trickplay Remote Debugger
    """
    
    if start == True:
		print '\t'+"Connecting remote debugger ..."

    s = CON.address+":"+db_port
    print s+"OOOOOOOOOOO"
    print cmd
    conn = httplib.HTTPConnection( s )
    
    try:
        conn.request("POST", "/debugger", cmd)
        response = conn.getresponse()
        data = response.read()
        conn.close()
        return data

    # Connection refused
    except error, e:
        print("Error >> Trickplay Application unavailable.")
        print(e)
        return False
 

def getTrickplayDebug():
    """
    Get Trickplay UI tree data for the inspector
    """
    
    s = CON.get()
    r = urllib2.Request("http://" + s + "/debug/start")
    f = None
    
    try:
        f = urllib2.urlopen(r)
        return decode(f.read())
    
    # Connection refused
    except urllib2.URLError, e:
        print("Error >> Connection to Trickplay application unsuccessful.")
        print(e)
        """
        print("Retry ...")
        time.sleep(5)
        try:	
			f = urllib2.urlopen(r)
			return decode(f.read())
        except urllib2.URLError, e:
        	print("Error >> Connection to Trickplay application unsuccessful.")
        	print(e)
		"""
    except httplib.BadStatusLine, e:
        print("Error >> Trickplay application closed before data could be retreived.")
        print(e)
    
    except httplib.InvalidURL, e:
        print('Could not find a Trickplay device.')
        print(e)
        
    return None
    
    
    
def decode(input):
    
    return json.loads(input)


"""
Test the connection
"""
def test():
    
    send({'gid': 1, 'properties' :{'x': 1200}})


if __name__ == "__main__":
    
    test()
