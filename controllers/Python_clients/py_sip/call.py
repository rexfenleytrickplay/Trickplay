import uuid
import hashlib

class Call(object):

    def __init__(self, user, sender_uri, remote_uri,
                 udp_client_ip, udp_client_port, udp_server_port, write_queue):
        self.user = user
        self.sender_uri = sender_uri
        self.remote_uri = remote_uri
        self.udp_client_ip = udp_client_ip
        self.udp_client_port = udp_client_port
        self.udp_server_port = udp_server_port
        self.write_queue = write_queue

        # Used to record the SIP route taken by a request and used to route the response
        # back to the originator.
        # UAs generating a request records its own address in a Via 
        # and adds it to the header.
        # Order of Via header fields is significant as it determines routes
        self.Via = {
            1 : {
                'protocol' : "SIP/2.0/UDP",
                'client_ip' : udp_client_ip,
                'client_port' : str(udp_client_port)
            }
        }

        # How many times can this bounce around the network?
        self.Max_Forwards = '70'

        # Where is this sending from? tag is generated locally (UAC)
        self.From = {
            'sender' : '<' + sender_uri + '>',
            'tag' : uuid.uuid4().hex,
        }

        # Who are you calling? tag is generated by UAS
        self.To = {
            'remote_contact' : '<' + remote_uri + '>',
            'tag' : ""
        }

        # All Calls are tied to a specific Call-ID. OPTIONS always
        # has a unique Call-ID. All REGISTERs from the same UA have the
        # same Call-ID.
        self.Call_ID = str(uuid.uuid4())

        # Sequence Number, increments per request for same call.
        # Exception is ACK or CANCEL where it uses the CSeq number of the INVITE
        # it's referencing.
        self.CSeq = 101

        # This is your routable address. The SIP Server caches this and forwards
        # all outside requests to this address therfore this must reference
        # your address outside the NAT. All INVITES and 200 responses must have
        # a Contact. REGISTERs may have Contact: * to remove all existing
        # Registrations.
        self.Contact = "<sip:" + user + "@" + udp_client_ip + ":" + str(udp_client_port) + ">"

        # A useless name you can include, may help with logs on server side
        self.User_Agent = "Python"

        # These are the Requests we allow. All of these should be implemented to complete
        # this project.
        self.Allow = "INVITE, ACK, BYE, CANCEL, OPTIONS, PRACK, MESSAGE, UPDATE"

        # This is additional stuff you support. NOTE: we don't support any of it. But
        # Entropy does in the Wireshark packets so I'm including it now anyway.
        # May support it later, who knows?
        self.Supported = "timer, 100rel, path"

        # Strings to help with Authorization
        self.Auth_1 = 'Authorization: Digest username="phone", realm="asterisk", nonce="'
        self.Auth_2 = '", algorithm=MD5, uri="sip:asterisk-1.asterisk.trickplay.com", response="'

        # Default Content length of 0 indicates no message body
        self.Content_Length = 'Content-Length: 0\r\n\
        \r\n' 

        self.branch = None
        self.nonce = None

        self.states = ("UNREGISTERED", "REGISTERED")
        self.current_state = 0

        self.callback = None


    def gen_branch(self):
        """Use to create a unique branch id"""

        # branch must begin with that weird 7 character string
        return 'z9hG4bK' + uuid.uuid4().hex

    
    def pull_nonce(self, response):
        if 'WWW-Authenticate' not in response:
            return False

        auth_line = response['WWW-Authenticate']
        if auth_line.find('nonce="') >= 0:
            begin = auth_line.find('nonce="')
            start = auth_line.find('"', begin)
            end = auth_line.find('"', start+1)
            self.nonce = auth_line[start+1:end]
            print "\nnonce: " + self.nonce + "\n\n"

            return True

        return False


    def interpret(self, response):
        print "You should overwrite this"



class Register(Call):

    def gen_register(self, authorization):
        """Create and return a REGISTER packet"""

        # generate new branch id
        self.branch = self.gen_branch()

        # build REGISTER packet
        register = "REGISTER sip:asterisk-1.asterisk.trickplay.com SIP/2.0\r\n"
        register += "Via: " + self.Via[1]['protocol'] + " " + self.Via[1]['client_ip'] + \
                    ":" + self.Via[1]['client_port'] + ";rport;branch=" + self.branch + \
                    "\r\n"
        register += "Max-Forwards: " + self.Max_Forwards + "\r\n"
        register += "From: " + self.From['sender'] + ";tag=" + self.From['tag'] + "\r\n"
        register += "To: " + self.From['sender'] + "\r\n"
        register += "Call-ID: " + self.Call_ID + "\r\n"
        register += "CSeq: " + str(self.CSeq) + " REGISTER\r\n"
        register += "Contact: " + self.Contact + "\r\n"
        register += "User-Agent: " + self.User_Agent + "\r\n"
        register += "Allow: " + self.Allow + "\r\n"
        register += "Supported: " + self.Supported + "\r\n"

        # add authorization line if available
        if authorization:
            register += authorization

        # terminate with default Content-Length of 0
        register += self.Content_Length

        # increment sequence number
        self.CSeq += 1

        return register


    def register(self):
        """Register to the SIP Server"""

        # if authorization key exists then generate auth line
        auth = None
        if self.nonce:
            ha1 = hashlib.md5("phone:asterisk:saywhat").hexdigest()
            ha2 = hashlib.md5("REGISTER:sip:asterisk-1.asterisk.trickplay.com").hexdigest()
            ha3 = hashlib.md5(ha1 + ":" + self.nonce + ":" + ha2).hexdigest()

            auth = self.Auth_1 + self.nonce + self.Auth_2 + ha3 + '"\r\n'

        # create REGISTER packet
        packet = self.gen_register(auth)

        # send over network
        self.write_queue.append(packet)


    def interpret(self, response):
        if response['Status-Line'] == "SIP/2.0 200 OK":
            self.current_state = 1
            if self.callback:
                self.callback()
        elif response['Status-Line'] == "SIP/2.0 401 Unauthorized":
            if self.pull_nonce(response):
                self.register()
        
        print "\ncurrent state:", self.states[self.current_state], '\n\n'



class Invite(Call):
    
    def gen_invite(self, authorization):
        """Create and return an INVITE packet"""

        # generate new branch id
        self.branch = self.gen_branch()

        # build REGISTER packet
        invite = "INVITE sip:rex@asterisk-1.asterisk.trickplay.com SIP/2.0\r\n"
        invite += "Via: " + self.Via[1]['protocol'] + " " + self.Via[1]['client_ip'] + \
                    ":" + self.Via[1]['client_port'] + ";rport;branch=" + self.branch + \
                    "\r\n"
        invite += "Max-Forwards: " + self.Max_Forwards + "\r\n"
        invite += "From: " + self.From['sender'] + ";tag=" + self.From['tag'] + "\r\n"
        invite += "To: " + self.To['remote_contact'] + "\r\n"
        invite += "Call-ID: " + self.Call_ID + "\r\n"
        invite += "CSeq: " + str(self.CSeq) + " INVITE\r\n"
        invite += "Contact: " + self.Contact + "\r\n"
        invite += "User-Agent: " + self.User_Agent + "\r\n"
        invite += "Allow: " + self.Allow + "\r\n"
        invite += "Supported: " + self.Supported + "\r\n"

        # add authorization line if available
        if authorization:
            invite += authorization

        # terminate with default Content-Length of 0
        invite += self.Content_Length

        # increment sequence number
        self.CSeq += 1

        return invite


    def invite(self):
        """Register to the SIP Server"""

        # if authorization key exists then generate auth line
        auth = None
        if self.nonce:
            ha1 = hashlib.md5("phone:asterisk:saywhat").hexdigest()
            ha2 = hashlib.md5("INVITE:sip:asterisk-1.asterisk.trickplay.com").hexdigest()
            ha3 = hashlib.md5(ha1 + ":" + self.nonce + ":" + ha2).hexdigest()

            auth = self.Auth_1 + self.nonce + self.Auth_2 + ha3 + '"\r\n'

        # create INVITE packet
        packet = self.gen_invite(auth)

        # send over network
        self.write_queue.append(packet)

    
    def ack(self):
        """Send an ACK to an INVITE"""
        return


    def interpret(self, response):
        if response['Status-Line'] == "SIP/2.0 200 OK":
            #self.current_state = 1
            if self.callback:
                self.callback()
        elif response['Status-Line'] == "SIP/2.0 401 Unauthorized":
            if self.pull_nonce(response):
                self.invite()
        
        print "\ncurrent state:", self.states[self.current_state], '\n\n'
