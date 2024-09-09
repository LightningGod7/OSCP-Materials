alias.txt - list of alias created for efficiency

basics.txt - cheat sheet to quickly search commands for copy paste

breakout.txt - to stablise, upgrade shells

ref.py - quickly print out basics.txt with dynamic IP address insertion for commands requiring a listener address or port.

rs.py - simple reverse shell generator
    

Prerequisites
Python 3.x
The netifaces Python package (install using pip install netifaces).
basics file located at /pt/reference/basics.


Install Dependencies:
```pip install netifaces```

Usage
Basic Usage (Print Entire Cheat Sheet with IP Replacement)
To print out your entire OSCP cheat sheet with the tun0 or eth0 IP address automatically inserted into commands requiring a listener address:
```ref```

Search for a Keyword
You can search for a specific keyword within your cheat sheet. The script will print the line containing the keyword and a specified number of lines after it.

```ref <keyword> [<lines_after>]```
Arguments:

<keyword>: The keyword to search for in the cheat sheet.
<lines_after> (optional): The number of lines to display after the keyword is found.
Example:

bash
Copy code
ref "===WINDOWS PE===" 30
This will display the Windows Priv Esc Section.

Handling Missing tun0 Interface
If the tun0 interface is not active, the script will prompt you to connect to a VPN and will still allow you to reference the cheat sheet with or without the IP insertion.
