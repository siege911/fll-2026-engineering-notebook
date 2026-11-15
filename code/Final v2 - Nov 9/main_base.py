# main_base.py - Quantum Warriors mission menu
#
# BUTTONS
#   In the menu:
#     LEFT   = go down a number
#     RIGHT  = go up a number
#     CENTER = start the mission shown on the screen
#   While a mission is running:
#     CENTER = STOP the mission and go back to the menu on that same number
#   After a mission finishes:
#     The screen shows the NEXT number (light turns orange).
#     RIGHT or CENTER = start that next mission right away
#     LEFT           = go back a number (to redo the one you just ran)
#   BLUETOOTH button (in the menu) = quit the whole program
#
# LIGHT COLORS
#   Blue = menu   Green = mission running   Orange = ready for next mission
#   Red  = mission stopped or had an error

from pybricks.parameters import Button, Color
from pybricks.tools import wait

from robot import hub, reset_settings, stop_everything, park

import mission1
import mission2_3
import mission4_5
import mission6_7_11
import mission8_9
import mission12a
import mission13_12b
import mission14
import mission15

# Screen number -> mission file. Change the order here to change the run order.
MISSIONS = [
    mission1,    # 1 = Mission 1
    mission2_3,  # 2 = Missions 2 & 3
    mission4_5,    # 3 = Missions 4 & 5
    mission8_9,    # 4 = Missions 8 & 9
    mission14,   # 5 = Mission 14
    mission12a,   # 6 = Mission 12a (just the support tie)
    mission15,   # 7 = Mission 15
    mission13_12b,   # 8 = Missions 13 & 12b (the cane and seed)
    mission6_7_11,  # 9 = Missions 6 & 7 & 11
]

MENU_STOP_BUTTON = Button.BLUETOOTH


def show(index, color):
    hub.display.number(index + 1)
    hub.light.on(color)


def wait_for_release():
    while hub.buttons.pressed():
        wait(10)


def wait_for_press():
    while True:
        pressed = hub.buttons.pressed()
        for b in (Button.LEFT, Button.RIGHT, Button.CENTER):
            if b in pressed:
                return b
        wait(10)


def run_mission(index):
    """Runs one mission. Returns True if it finished, False if stopped or crashed."""
    show(index, Color.GREEN)
    wait_for_release()          # don't let the start press count as a stop press
    reset_settings()
    finished = False

    # While a mission runs, the CENTER button becomes the "stop" button.
    # Pressing it raises SystemExit inside the mission, which we catch here.
    hub.system.set_stop_button(Button.CENTER)
    try:
        MISSIONS[index].run()
        finished = True
    except SystemExit:
        pass
    except Exception as e:
        print("Mission", index + 1, "error:", e)
    finally:
        hub.system.set_stop_button(MENU_STOP_BUTTON)

    park()   # wheels loose + gyro off between missions

    if not finished:
        stop_everything()
        hub.light.on(Color.RED)
        hub.speaker.beep(300, 300)
        wait(500)
    return finished


# ---------------- main loop ----------------
hub.system.set_stop_button(MENU_STOP_BUTTON)
selected = 0          # 0 = mission number 1 on the screen
ready_for_next = False

while True:
    show(selected, Color.ORANGE if ready_for_next else Color.BLUE)
    wait_for_release()
    button = wait_for_press()

    if button == Button.LEFT:
        selected = (selected - 1) % len(MISSIONS)
        ready_for_next = False
        hub.speaker.beep(600, 40)
        continue

    if button == Button.RIGHT and not ready_for_next:
        selected = (selected + 1) % len(MISSIONS)
        hub.speaker.beep(800, 40)
        continue

    # CENTER, or RIGHT right after a mission finished -> run it
    if run_mission(selected):
        hub.speaker.beep(1000, 100)
        if selected < len(MISSIONS) - 1:
            selected += 1
            ready_for_next = True
        else:
            selected = 0             # finished the last one, back to 1
            ready_for_next = False
    else:
        ready_for_next = False       # stay on the same number to restart it
