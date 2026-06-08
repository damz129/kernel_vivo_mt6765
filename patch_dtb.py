import os
import struct

header_path = "build/unzip_boot/header.bin"
dtb_clean_path = "build/unzip_boot/new_clean.dtb"
dtb_final_path = "build/unzip_boot/dtb"

with open(header_path, "rb") as f:
    header = bytearray(f.read())

with open(dtb_clean_path, "rb") as f:
    dtb_data = f.read()

clean_size = len(dtb_data)
header[0x20:0x24] = struct.pack(">I", clean_size)

payload = header + dtb_data

remainder = len(payload) % 2048
if remainder != 0:
    padding_needed = 2048 - remainder
    payload += b"\x00" * padding_needed

with open(dtb_final_path, "wb") as f:
    f.write(payload)

print(f"-> DONE: DTB ({len(payload)} bytes)")
