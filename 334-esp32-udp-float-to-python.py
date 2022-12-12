import socket

UDP_IP = "172.29.21.183"
UDP_PORT = 8092

sock = socket.socket(socket.AF_INET, # Internet
                     socket.SOCK_DGRAM) # UDP
sock.bind((UDP_IP, UDP_PORT))

while True:
    data, addr = sock.recvfrom(1024)
    print ("Message: ", data.decode("ASCII"))
