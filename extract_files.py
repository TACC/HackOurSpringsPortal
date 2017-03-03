import zipfile
zip_ref = zipfile.ZipFile("GWDBDownload.zip", 'r')
zip_ref.extractall("temp/")
zip_ref.close()
