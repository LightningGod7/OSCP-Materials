#!/usr/bin/python3
import argparse
import re
import sys

def detect_format(shellcode_str):
    if '0x' in shellcode_str:
        return 'hex'
    elif re.search(r'\b\d+\b', shellcode_str):
        return 'decimal'
    return None

def extract_shellcode(raw_text):
    # Extract only what is inside the curly braces
    brace_match = re.search(r'\{([^}]*)\}', raw_text, re.DOTALL)
    if brace_match:
        raw_text = brace_match.group(1)

    # Try to detect format after extracting only the actual data
    shellcode_type = detect_format(raw_text)

    if shellcode_type == 'hex':
        matches = re.findall(r'0x[0-9a-fA-F]{2}', raw_text)
        shellcode = [int(x, 16) for x in matches]
    elif shellcode_type == 'decimal':
        matches = re.findall(r'\b\d+\b', raw_text)
        shellcode = [int(x) for x in matches if 0 <= int(x) <= 255]
    else:
        return None, None

    return shellcode_type, shellcode

def caesar_encrypt(shellcode, key):
    return [(b + key) % 256 for b in shellcode]

def format_shellcode(shellcode, shellcode_type, format_style='csharp', var_name='shellcode', line_len=16):
    if shellcode_type == 'hex':
        items = [f'0x{b:02x}' for b in shellcode]
    else:
        items = [str(b) for b in shellcode]
    
    if format_style == 'vba':
        # VBA Array format with proper line continuations
        result = f'{var_name} = Array('
        current_line_len = len(result)
        max_line_len = 100
        
        for i, item in enumerate(items):
            if i == 0:
                add_str = item
            else:
                add_str = ',' + item
            
            # Check if adding this item would exceed line length
            if current_line_len + len(add_str) > max_line_len and i > 0:
                result += ' _\n,' + item
                current_line_len = len(',' + item)
            else:
                result += add_str
                current_line_len += len(add_str)
        
        result += ')'
        return result
    
    elif format_style == 'csharp':
        # C# byte array format
        lines = []
        for i in range(0, len(items), line_len):
            chunk = items[i:i + line_len]
            if i + line_len < len(items):  # Not the last line
                lines.append('    ' + ','.join(chunk) + ',')
            else:  # Last line
                lines.append('    ' + ','.join(chunk))
        
        result = f'byte[] {var_name} = new byte[{len(shellcode)}] {{\n'
        result += '\n'.join(lines)
        result += '\n};'
        return result
    
    elif format_style == 'python':
        # Python list format
        lines = []
        for i in range(0, len(items), line_len):
            chunk = items[i:i + line_len]
            if i == 0:
                lines.append(f'{var_name} = [' + ','.join(chunk) + ',')
            elif i + line_len < len(items):  # Not the last line
                lines.append('    ' + ','.join(chunk) + ',')
            else:  # Last line
                lines.append('    ' + ','.join(chunk) + ']')
        return '\n'.join(lines)
    
    else:  # raw format
        lines = []
        for i in range(0, len(items), line_len):
            chunk = items[i:i + line_len]
            lines.append(','.join(chunk))
        return '\n'.join(lines)

def main():
    parser = argparse.ArgumentParser(description="Caesar encrypt shellcode from msfvenom")
    parser.add_argument('-k', '--key', type=int, required=True, help='Caesar cipher key (shift)')
    parser.add_argument('-f', '--format', choices=['vba', 'csharp', 'python', 'raw'], default='csharp', help='Output format style')
    parser.add_argument('-v', '--variable', default='shellcode', help='Variable name for the output (default: shellcode)')
    args = parser.parse_args()

    raw_input = sys.stdin.read()

    shellcode_type, shellcode = extract_shellcode(raw_input)
    if shellcode_type is None or not shellcode:
        print("[!] Unsupported or empty shellcode format.")
        sys.exit(1)

    encrypted_shellcode = caesar_encrypt(shellcode, args.key)

    line_lengths = {
        'vba': 16,      # VBA handles line length internally now
        'csharp': 16,
        'python': 16,
        'raw': 32
    }

    output = format_shellcode(encrypted_shellcode, shellcode_type, args.format, args.variable, line_lengths[args.format])
    print(output)

if __name__ == '__main__':
    main()
