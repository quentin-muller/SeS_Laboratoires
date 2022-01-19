#!/bin/python

file = 'sshd_backup'
new_file = 'sshd_py'

KEEP_ORIGINAL = False

old_text = [b'OpenSSH_8.8\x00']
new_text = [b'\x00'*len(old_text[0])]

if(KEEP_ORIGINAL):
    print("Nothing done...")
    print(f"{file} -> {new_file}")
    with open(file, 'rb') as f:
        with open(new_file, 'wb') as g:
            g.write(f.read())


else:
    print(f"Replacing {old_text} with {new_text}")
    print(f"{file} -> {new_file}")

    with open(file, 'rb') as f:
        data = f.read()
        print(f"Occurences in old file : ")
        for old in old_text:
            print(f"    {old} : {data.count(old)}")

        for old, new in zip(old_text, new_text):
            assert len(old) == len(new), "wrong size"
            new_data = data.replace(old, new)

        with open(new_file, 'wb') as g:
            g.write(new_data)