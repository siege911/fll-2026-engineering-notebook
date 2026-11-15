from pybricks.parameters import Button, Color, Direction, Port, Side, Stop
from pybricks.tools import wait, StopWatch

# Hardware (hub, motors, driveBase) lives in robot.py so every mission shares it.
from robot import hub, leftWheel, rightWheel, leftAttachment, rightAttachment, driveBase


def run():
    #This is a cool comment

    driveBase.use_gyro(True)

    driveBase.settings(straight_speed=800,straight_acceleration=800)
    driveBase.straight(220)
    rightAttachment.run_angle(500,-0)
    driveBase.straight(145)
    leftAttachment.run_angle(200,-100)
    rightAttachment.run_angle(400,-700)
    driveBase.straight(-450)


# Lets this file still run by itself in Pybricks Code.
if __name__ == "__main__":
    run()
