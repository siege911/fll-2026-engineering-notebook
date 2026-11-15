from pybricks.parameters import Button, Color, Direction, Port, Side, Stop
from pybricks.tools import wait, StopWatch

# Hardware (hub, motors, driveBase) lives in robot.py so every mission shares it.
from robot import hub, leftWheel, rightWheel, leftAttachment, rightAttachment, driveBase


def run():
    driveBase.use_gyro(True)
    driveBase.settings(straight_speed=680)

    driveBase.straight(-10)
    driveBase.reset()
    rightAttachment.run_angle(500,150,wait=False)
    driveBase.arc(200, 90)
    driveBase.straight(250)
    driveBase.arc(-200, 90)  # was curve(200, -90) - signs flipped so it drives the same path
    driveBase.straight(110)
    driveBase.turn(90)
    driveBase.straight(220)
    leftAttachment.run_angle(500,-1900)
    driveBase.straight(-90)
    driveBase.turn(90)
    driveBase.arc(-175, 90)  # was curve(175, -90) - signs flipped so it drives the same path
    driveBase.arc(2800, 18)


# Lets this file still run by itself in Pybricks Code.
if __name__ == "__main__":
    run()
