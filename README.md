# Track your counters (v1.1.0)
This app allows to create trackers and customize them as you like. You can save the current state as well as change the default tracker so when you open the app you get the default you want.

The size of the UI can also be saved and there are some presets to give you some ideas.

The app UI is thought for smartphones but it adapts to whatever window size you have.

The app is available on:
- Android: https://play.google.com/store/apps/details?id=com.ForeignTreeGames.TrackYourCounters
- Linux: https://foreigntreegames.itch.io/track-your-counters

## Folder structure
- scripts: You can see scripts that don't relate to the UI, basically things for saving. tracker info and a global script.
- UI: All scenes and scripts related to the UI which contains most of the code.
- theme: Themes used for this project. They are primarily used to change font size.
- assets: Some assets I created to select the color.
- fonts: folder with fonts used.
- android: android build template.

## Here it works

All trackers are fully editable and even the default tracker that is added when pressing the + button can be changed.

Tracker buttons:

🗒️ Notes: It shows the notes attached to that tracker. You can introduce any text there.

— Minimize: It hides the tracker values showing only the name.

◇ Maximize: It shows the tracker values.

✏️ Edit: Enters the edit mode where you can edit the values of the trackers.

Once on edit mode:

✔️ Accept: It applies the changes you made to the tracker.

❌ Cancel: Discards the changes done to the tracker.

↕ Position: It shows the current position and is used to change the position of the tracker.

O Color: To change the color of the tracker.

🗑️ Delete: It removes the tracker.

+/-/x/÷: You can change the type of operator is used when clicking to change the value of a tracker. Simply press on the operator to change the type on edit mode.

+ Add tracker: This adds the default tracker. The default tracker can be changed using the main menu and then saved for future use in the save options.

Main Menu:

🎲 Show dice: It shows the dice menu. You can throw as many dice as you want by changing the first value. There's 6 different dice you can use (by clicking on the dice name you change the type) with values:

- D2: 0 or 1
- D4: 1 to 4
- D6: 1 to 6
- D10: 0 to 9
- D12: 1 to 12
- D20: 1 to 20

  The result is shown on the right side. You can clean the value by pressing it.

⬆️ Increase UI size: Increases the text size.

⬇️ Decrease UI size: Decreses the text size.

📎 Save: Opens the save menu which allows you to save the UI size or all the current trackers (When saving the trackers the default tracker is saved together with the rest of the trackers).

📂 Load/Presets: You can use some presets from here or load your previously saved trackers.

✏️ Edit default: Allows you to change the default tracker which is the one used when adding a new one. We have several button there:

- 📎 Save: Saves the tracker to the settings file for future use.
- 📂 Load: Load the default tracker from the settings file that has been previously saved.
- 🗑️ Delete: Deletes the default tracker from the saved settings to the predefined value (like a factory reset).
- ✔️ Accept: Accepts the default tracker but doesn't save it to the settings file for future use.
- ❌ Cancel: Closes the panel without saving the changes.

❓ Help: Shows the current menu.

🗑️ Delete all: Deletes all trackers.
