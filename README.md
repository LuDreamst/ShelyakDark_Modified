# ShelyakDark_Modified
A conky widget based on [Shelyak](https://www.pling.com/p/1839849).  
# Changelog  
Check what had changed: [Changelog](https://github.com/LuDreamst/ShelyakDark_Modified/blob/main/Changelog#L10#L25)
# Preview  
![](preview.png)  
# How to use it?  
1. Install conky and its dependencies   
   For apt usrs, you can run:  
   `
   sudo apt install conky-all lua5.4 curl playerctl
   `
2. Make a dir named `conky`:  
   `mkdir -p ~/.config/conky`  
3. Clone this repository and move it to `~/.config/conky`:  
   `git clone https://github.com/LuDreamst/ShelyakDark_Modified.git && mv -v ShelyakDark_Modified ~/.config/conky/`
4. Extract and install Abel.ttf from Abel.zip in the `fonts` folder.  
   If necessary, try this to update the font cache:  
   `sudo fc-cache -v -f`  
5. Change the [city_id](https://github.com/LuDreamst/ShelyakDark_Modified/blob/main/scripts/weather-v2.0.sh#L9), [unit](https://github.com/LuDreamst/ShelyakDark_Modified/blob/main/scripts/weather-v2.0.sh#L16) in `scripts/weather-v2.0.sh` and [°C](https://github.com/LuDreamst/ShelyakDark_Modified/blob/main/ShelyakDark_Modified.conf#L85) as your need.
6. Now you can go:
   `sh start.sh`
7. (Optical)autostart  
   move `ShelyakDark_Modified.desktop` to `~/.config/autostart/`  
# Hope you enjoy it~
