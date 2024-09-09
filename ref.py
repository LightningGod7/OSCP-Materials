#!/usr/bin/python3
import sys
import netifaces as ni


CHEATSHEET_PATH = '/pt/references/cheatsheet'

def get_tun0_ip():
    try:
        TUN0_IP = ni.ifaddresses('tun0')[ni.AF_INET][0]['addr']
        return TUN0_IP
    except ValueError:
        return None

def read_file(file_path):
    with open(file_path, 'r') as file:
        return file.readlines()

def search_keyword(lines, keyword, lines_after=0):
    found = False
    print(keyword)
    for i, line in enumerate(lines):
        if keyword in line:
            found = True
            print(line.strip())
            for j in range(1, lines_after + 1):
                if i + j < len(lines):
                    print(lines[i + j].strip())
            if lines_after!=0:
                break
    if not found:
        print(f"Keyword '{keyword}' not found in the file.")

if __name__ == "__main__":
    if len(sys.argv) == 1:
        # If no arguments provided, simply output the whole file
        lines = read_file(CHEATSHEET_PATH)
        tun0_ip = get_tun0_ip()
        if tun0_ip:
            for line in lines:
                print(line.replace('$LHOST', tun0_ip).strip())
        else:
            print("Please connect to VPN to get the tun0 IP address.")
            for line in lines:
                print(line.strip())
    else:
        keyword = sys.argv[1]
        lines_after = int(sys.argv[2]) if len(sys.argv) > 2 else 0
        tun0_ip = get_tun0_ip()
        lines = read_file('/pt/reference/basics')
        if tun0_ip:
            for line in lines:
                line = line.replace('$LHOST', tun0_ip)
            search_keyword(lines, keyword, lines_after)
        else:
            print("Please connect to VPN to get the tun0 IP address.")
            search_keyword(lines, keyword, lines_after)
