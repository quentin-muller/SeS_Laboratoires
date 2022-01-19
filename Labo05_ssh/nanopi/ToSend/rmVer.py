#!/bin/python

file = 'sshd_backup'
new_file = 'sshd'


old_text = [b'OpenSSH_8.8', b'SSH-%d']
new_text = [b'\x00'*len(old_text[0]), b'SSH-XX']
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
