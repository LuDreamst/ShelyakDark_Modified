# ShelyakDark_Modified
A conky widget based on [Shelyak](https://www.pling.com/p/1839849).  
# Changelog  
Check what had changed: [Changelog](https://github.com/LuDreamst/ShelyakDark_Modified/blob/main/Changelog#L10#L18)
# Preview  
![](preview.png)  
# How to use it?  
1. Install conky and its dependencies   
   For apt users, you can run:  
   ```bash
   sudo apt install conky-all lua5.4 curl playerctl jq
   ```
2. Make a dir named `conky`:  
   `mkdir -p ~/.config/conky`  
3. Clone this repository and move it to `~/.config/conky`:  
   `git clone https://github.com/LuDreamst/ShelyakDark_Modified.git && mv -v ShelyakDark_Modified ~/.config/conky/`
4. Extract and install required fonts from the `fonts` folder.  
   ```bash
   # Install Abel font
   unzip fonts/Abel.zip -d ~/.local/share/fonts/
   
   # Install Feather icon font (already extracted)
   cp fonts/feather.ttf ~/.local/share/fonts/
   
   # Install Fira font (for Chinese text support)
   sudo apt install fonts-fira-sans
   
   # Update font cache
   sudo fc-cache -v -f
   ```  
5. Configure weather settings for your location:  
   ```bash
   # Edit scripts/weather-v2.0.sh to customize:
   # - city_id: Get from https://openweathermap.org/find (required)
   # - api_key: Get your own free key from https://openweathermap.org/api (recommended to replace default)
   # - unit: Change to 'imperial' if you prefer Fahrenheit
   nano scripts/weather-v2.0.sh
   ```
   
   **About city_id and api_key:** For a detailed visual guide on obtaining these, refer to the original Shelyak author's blog: [How to Apply the Theme](https://malformed-blog.blogspot.com/2025/02/how-to-apply-theme.html)
   
   **Note on api_key:** The default API key remains functional, but it is recommended that you register your own.
   
   Also update the temperature unit in `ShelyakDark_Modified.conf`:  
   - Lines 85, 90, 91: Change `°C` to `°F` if using Fahrenheit mode
   
6. Start the widget:  
   ```bash
   cd ~/.config/conky/ShelyakDark_Modified
   sh start.sh
   ```
   **Note:** Weather data will load after a few seconds on first run.

7. (Optional) Enable autostart:  
   ```bash
   cp ShelyakDark_Modified.desktop ~/.config/autostart/
   ```
# Hope you enjoy it~
