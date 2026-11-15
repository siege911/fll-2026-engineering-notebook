from pybricks.parameters import Button, Color, Direction, Port, Side, Stop
from pybricks.tools import wait, StopWatch

# Hardware (hub, motors, driveBase) lives in robot.py so every mission shares it.
from robot import hub, leftWheel, rightWheel, leftAttachment, rightAttachment, driveBase


def run():
    driveBase.use_gyro(True)

    driveBase.straight(-10)
    driveBase.reset()

    driveBase.settings(straight_speed=600)

    driveBase.straight(425)
    rightAttachment.run_angle(100,55)
    driveBase.settings(straight_speed=100)
    driveBase.straight(-160)
    rightAttachment.run_angle(50,-20)
    driveBase.turn(15)
    driveBase.settings(straight_speed=600)
    driveBase.straight(-200)


# Lets this file still run by itself in Pybricks Code.
if __name__ == "__main__":
    run()
