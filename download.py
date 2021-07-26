#!/usr/bin/env python3

import pyicloud
import sys
import json
import os

from pyicloud import PyiCloudService

email = os.environ['ICLOUD_EMAIL']
password = os.environ['ICLOUD_PASSWORD']
api = PyiCloudService(email, password)
path = os.environ.get('ICLOUD_PATH', "/data")
print(path)

if api.requires_2sa:
    import click
    print("Two-step authentication required. Your trusted devices are:")

    devices = api.trusted_devices
    for i, device in enumerate(devices):
        print("  %s: %s" % (i, device.get('deviceName', "SMS to %s" % device.get('phoneNumber'))))

    device = click.prompt('Which device would you like to use?', default=0)
    device = devices[device]
    if not api.send_verification_code(device):
        print("Failed to send verification code")
        sys.exit(1)

    code = click.prompt('Please enter validation code')
    api.validate_verification_code(device, code)
    api = PyiCloudService(email, password)

print(api.photos.all)

photos = iter(api.photos.all)

files = os.listdir(path)

for photo in photos:
    if photo.filename in files:
        print("Already downloaded", photo.filename)
        continue
    print("Downloading", photo.filename)
    download = photo.download()
    with open(photo.filename, 'wb') as opened_file:
        opened_file.write(download.raw.read())
