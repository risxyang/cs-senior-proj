import socket
import os
import pyOSC3

c = pyOSC3.OSCClient()
c.connect(('127.0.0.1', 6448))   # localhost, port 6448

UDP_IP = "172.29.21.183"
UDP_PORT = 8092

sock = socket.socket(socket.AF_INET, # Internet
                     socket.SOCK_DGRAM) # UDP
sock.bind((UDP_IP, UDP_PORT))

while True:
    data, addr = sock.recvfrom(1024)
    content = data.decode("ASCII")
    os.system('echo '+ content + '> wifiread')
    print ("Message: ", content)
    #send OSC message to wekinator
    content_arr = content.split(',')
    oscmsg = pyOSC3.OSCMessage()
    oscmsg.setAddress("/wek/inputs")
    for i in range(len(content_arr)):
        oscmsg.append(float(content_arr[i]))
        # print(content_arr[i])
    c.send(oscmsg)
