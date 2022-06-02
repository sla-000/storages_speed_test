# Test speed of various storages

Simple project to test how fast work the different types of storage

- Hive
- Shared Preferences
- Sqflite (naive / indexed)

## Results

Values are microseconds
First number is duration of data creation and loading of it to DB 
Second number is Duration of getting random 1000 keys from DB

![MacOs](/page/macos_m1.png "MacOs")
![Oneplus 9 Pro](/page/oneplus_9_pro.jpg "Oneplus 9 Pro")
![Pixel 3, Emulated](/page/pixel_3_emul.png "Pixel 3 Emulated")
![iPhone SE, Emulated, Debug mode](/page/iphone_se_emul_debug.png "iPhone SE Emulated Debug mode")
