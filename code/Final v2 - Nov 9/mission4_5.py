from pybricks.parameters import Button, Color, Direction, Port, Side, Stop
from pybricks.tools import wait, StopWatch

# Hardware (hub, motors, driveBase) lives in robot.py so every mission shares it.
from robot import hub, leftWheel, rightWheel, leftAttachment, rightAttachment, driveBase


def run():
    driveBase.use_gyro(True)

    driveBase.settings(straight_speed=700, straight_acceleration=400, turn_acceleration=500)

    driveBase.straight(-15)
    driveBase.reset()

    leftAttachment.run_angle(100, -300, wait=False)
    rightAttachment.run_angle(100, 200, wait=False)

    #Across the mat
    driveBase.straight(855)
    #Turn toward bugs
    driveBase.turn(-45)
    #right attachment goes down
    rightAttachment.run_angle(300, -160)
    # drives backwards
    driveBase.settings(straight_speed=200, turn_acceleration=200)
    driveBase.straight(-30)
    # turn into branch thing
    driveBase.turn(55)
    rightAttachment.run_angle(100, -60, wait=False)
    #back up
    driveBase.straight(-100)
    driveBase.settings(straight_speed=700, straight_acceleration=700, turn_acceleration=200)
    # right attachment up
    rightAttachment.run_angle(600, 180, wait=False)

    # goes straight 
    driveBase.straight(210)
    # right attachment down
    rightAttachment.run_angle(700, -80)
    wait(300)
    # right attachment up
    rightAttachment.run_angle(700, 90)
    # go backwards back to home
    driveBase.straight(-150)
    driveBase.turn(-55)
    leftAttachment.run_angle(700,300)
    driveBase.straight(70)
    leftAttachment.run_angle(700,-250)
    driveBase.arc(-400, -120)
    #driveBase.straight(-820)


# Lets this file still run by itself in Pybricks Code.
if __name__ == "__main__":
    run()
