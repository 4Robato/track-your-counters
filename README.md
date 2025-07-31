# Track your counters (v1.2.3)
This app allows to create as many trackers as you need and customize them as you like. You can save the current state as well as change the default tracker so when you open the app you get the default you want.

When pressing the buttons in the trackers logs are generated which are also saved if you want to.

The size of the UI can also be saved and there are some presets to give you some ideas.

The app UI is thought for smartphones but it adapts to whatever window size you have.

The app is available on:
- Android: https://play.google.com/store/apps/details?id=com.ForeignTreeGames.TrackYourCounters
- Linux, Windows and Browser: https://foreigntreegames.itch.io/track-your-counters

## Folder structure
- scripts: You can see scripts that don't relate to the UI, basically things for saving. tracker info and a global script.
- UI: All scenes and scripts related to the UI which contains most of the code.
- theme: Themes used for this project. They are primarily used to change font size.
- translations: All translations available. When a new language is added to the .csv file it will be added in the game without the need of changing code.
- assets: Some assets I created to select the color.
- fonts: folder with fonts used.
- android: android build template.

## How it works

All trackers are fully editable, you can save the current state as well as individual trackers to use later on.

Tips:

· You can multiply by 0 to have a reset button on the tracker values.

· If you usually need the same set up, create the trackers and save the game state on the save menu

· If you play games with characters, create them on the tracker manager and save them.

Tracker buttons:

📝 Notes: It shows the notes attached to that tracker. You can introduce any text there.

➖ Minimize: It hides the tracker values showing only the name.

➕ Maximize: It shows the tracker values.

✏️ Edit: Enters the edit mode where you can edit the values of the trackers.

Once on edit mode:

✔️ Accept: It applies the changes you made to the tracker.

❌ Cancel: Discards the changes done to the tracker.

↕ Position: It shows the current position and is used to change the position of the tracker.

O Color: To change the color of the tracker.

🗑️ Delete: It removes the tracker.

➕/➖/✖/➗: You can change the type of operator is used when clicking to change the value of a tracker. Simply press on the operator to change the type on edit mode.

Buttons on the main Screen:

: Opens the main menú with options to save, load, change UI size and more.

🌐: It allows you to change language.

🎲: Adds a dice to the trackers. You can throw as many dice as you want by changing the first value. There's 6 different dice you can use (by clicking on the dice name you change the type) with values:

  · D2: 0 or 1

  · D4: 1 to 4

  · D6: 1 to 6

  · D10: 0 to 9

  · D12: 1 to 12

  · D20: 1 to 20

  The result is shown on the right side. You can clean the value by pressing it.

  If more than one dice is selected, you can press ⤵ to see all results from the dice and then press ⤴ to hide them.

📑 Logs: You can see all the actions that happened here.

 Add tracker: This adds the default tracker. The default tracker can be changed using the main menu and then saved for future use in the save options.

Main Menu ():

⬆️ Increase UI size: Increases the text size.

⬇️ Decrease UI size: Decreses the text size.

📎 Save: Opens the save menu which allows you to save the UI size or all the current trackers (When saving the trackers the default tracker is saved together with the rest of the trackers).

📂 Load/Presets: You can use some presets from here or load your previously saved trackers.

✏️ Edit default: Allows you to change the default tracker which is the one used when adding a new one. We have several button there:

  · 📎 Save: Saves the tracker to the settings file for future use.

  · 📂 Load: Load the default tracker from the settings file that has been previously saved.

  · 🗑️ Delete: Deletes the default tracker from the saved settings to the predefined value (like a factory reset).

  · ✔️ Accept: Accepts the default tracker but doesn't save it to the settings file for future use.

  · ❌ Cancel: Closes the panel without saving the changes.

📑 Tracker manager: Here you can add trackers and save them for later use. You can also add them to the main screen using the  or change positions pressing the arrows.

❓ Help: Shows the current menu.

🗑️ Delete all: Deletes all trackers, dice and cleans the Logs.


## Attribution

All emojis designed by [OpenMoji](https://openmoji.org/) – the open-source emoji and icon project. License: [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/)
