from pybricks.parameters import Button, Color, Direction, Port, Side, Stop
from pybricks.tools import wait, StopWatch

# Hardware (hub, motors, driveBase) lives in robot.py so every mission shares it.
from robot import hub, leftWheel, rightWheel, leftAttachment, rightAttachment, driveBase


def run():
    driveBase.use_gyro(True)
    driveBase.settings(straight_speed=600, straight_acceleration=600)
    driveBase.straight(-10)
    driveBase.reset()

    driveBase.straight(720)
    driveBase.arc(100, 45)
    driveBase.straight(130)
    rightAttachment.run_angle(200,-345)
    wait(1000)
    rightAttachment.run_angle(600,250)
    driveBase.straight(-300)
    driveBase.turn(45)
    leftAttachment.run_angle(600,-250)
    wait(500)
    driveBase.straight(70)
    leftAttachment.run_angle(100,120)
    driveBase.turn(10)
    driveBase.straight(-100)
    driveBase.turn(60)
    driveBase.straight(600)


# Lets this file still run by itself in Pybricks Code.
if __name__ == "__main__":
    run()
