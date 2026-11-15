from pybricks.parameters import Button, Color, Direction, Port, Side, Stop
from pybricks.tools import wait, StopWatch

# Hardware (hub, motors, driveBase) lives in robot.py so every mission shares it.
from robot import hub, leftWheel, rightWheel, leftAttachment, rightAttachment, driveBase


def run():
    driveBase.use_gyro(True)

    #driveBase.straight(-10)
    #driveBase.turn(93)
    driveBase.settings(straight_speed=600,straight_acceleration=500, turn_rate=500, turn_acceleration=500)
    driveBase.straight(520)
    driveBase.arc(-300, 30)  # was curve(380, -30) - signs flipped so it drives the same path
    driveBase.turn(-30)
    driveBase.turn(65)
    driveBase.settings(straight_speed=600)
    driveBase.straight(-660)


# Lets this file still run by itself in Pybricks Code.
if __name__ == "__main__":
    run()
