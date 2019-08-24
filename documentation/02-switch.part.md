## Switch 

### Connect using serial connection 

On the command prompt, run this command to connect to the switch

```bash
screen /dev/ttyS1 9600
sw1>show switch 

    Management Standby   Preconfig     Plugged-in    Switch        Code
SW  Status     Status    Model ID      Model ID      Status        Version
--- ---------- --------- ------------- ------------- ------------- -----------
1   Mgmt Sw              N4032         N4032         OK            6.2.6.6
```

Use the key sequence Ctrl-a + Ctrl-d to detach from the screen session.
Reattach to the screen session by typing:

```bash
screen -r 
```

### Show all sessions
Type screen -list to identify the detached screen session.

	screen -list  
	    There are screens on:  
        	 20751.foo_bar  (Detached)  

### Attach to an specific session
Get attached to the detached screen session

	screen -r 20751.foo_bar

### Kill a session
Get attached to the detached screen session

	screen -r 20751.foo_bar

Once connected to the session press Ctrl + A then type :quit


### How to enable HTTPS/SSH and disable HTTP/Telnet for switch management

There is an account created with Privilege Level 15. To verify this, use the command: 

    console#show users accounts


### Connect to the switch via CLI

To enable SSH, enter the following commands:

        console> enable
        console# config
        console(config)# crypto key generate rsa
        console(config)# crypto key generate dsa
        console(config)# ip ssh server
    	To disable telnet, enter: console(config)#no ip telnet server
    	To enable HTTPS, enter the following commands"
        console(config)# crypto certificate 1 generate key
        console(config)# ip https certificate 1
        console(config)# ip http secure-server

### Save configuration 

    console# copy running-config startup-config


### Backup switch configuration 

Start a tftpd server

    /usr/sbin/in.tftpd --foreground --create -address 10.1.1.1 -s /tmp

Connect to the switch

    screen /dev/ttyS1 9600

Save startup-config or running-config

    sw1> enable
    sw1e# config
    copy running-config tftp://10.1.1.1 tftp://192.168.0.1/backup
    copy startup-config tftp://10.1.1.1 tftp://192.168.0.1/backup
