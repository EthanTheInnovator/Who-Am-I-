# Which Phantom Thief Are You?

For my "Who am I?" app, I based it on my favorite video game "Persona 5"

You can get any of the 9 main characters

I built the app to be ultra modular, so writing and changing questions is just a matter of knowing what you want the questions to be (try it out by editing Question.swift).
The different UI elements I used were switches, pickers, and steppers (in addition to buttons)
I also added a blur view and finally figured out animations in SwiftUI!!!

Bugs:
- I couldn't figure out how to go back to a question without the animation glitching out
- If you hit next while the animation is still playing, it'll go back to the last question, but act like it's at the next question (it's weird)
- The pickers can only be edited on an actual device, so a simulator does not work (not sure why, I think this is a bug in Xcode, come ask me if you need to use my phone).
- If there's a tie, it automatically goes to the last match
- There's one page where the text cuts off. This is a bug in SwiftUI that I was able to fix for most of the labels but for that one I couldn't
