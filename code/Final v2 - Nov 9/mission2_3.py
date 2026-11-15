from pybricks.parameters import Button, Color, Direction, Port, Side, Stop
from pybricks.tools import wait, StopWatch

# Hardware (hub, motors, driveBase) lives in robot.py so every mission shares it.
from robot import hub, leftWheel, rightWheel, leftAttachment, rightAttachment, driveBase


def run():
    driveBase.use_gyro(True)
    driveBase.settings(straight_speed=600)
    driveBase.straight(-10)
    driveBase.reset()
    #driveBase.straight(400)
    #driveBase.turn(-15)
    #driveBase.straight(90)
    #driveBase.straight(-410)
    #driveBase.turn(60)
    #driveBase.straight(510)
    driveBase.straight(190)
    driveBase.turn(45)
    driveBase.straight(330)
    rightAttachment.run_angle(50,90)
    driveBase.straight(-500)
    driveBase.turn(-55)
    driveBase.settings(straight_speed=200)
    driveBase.straight(450)
    driveBase.straight(-370)


# Lets this file still run by itself in Pybricks Code.
if __name__ == "__main__":
    run()
