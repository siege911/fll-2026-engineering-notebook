from pybricks.parameters import Button, Color, Direction, Port, Side, Stop
from pybricks.tools import wait, StopWatch

# Hardware (hub, motors, driveBase) lives in robot.py so every mission shares it.
from robot import hub, leftWheel, rightWheel, leftAttachment, rightAttachment, driveBase


def run():
    driveBase.use_gyro(True)

    driveBase.settings(straight_speed=600, turn_rate=600)

    driveBase.straight(-10)
    driveBase.reset()

    leftAttachment.run_angle(100, 220, wait=False)

    driveBase.straight(140)
    driveBase.turn(45)
    driveBase.straight(655)
    driveBase.turn(-45)
    driveBase.straight(150)
    rightAttachment.run_angle(80,-165)
    #driveBase.straight(-100)
    leftAttachment.run_angle(100,-60,wait=False)
    rightAttachment.run_angle(300,90)
    driveBase.settings(straight_speed=120)
    driveBase.straight(270)
    leftAttachment.run_angle(100,30)
    driveBase.settings(straight_speed=600)
    driveBase.straight(-90)
    driveBase.turn(-10)

    driveBase.straight(-140)
    driveBase.turn(50)
    driveBase.straight(-700)


# Lets this file still run by itself in Pybricks Code.
if __name__ == "__main__":
    run()
