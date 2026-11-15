# robot.py - shared hardware setup used by main_base.py and every mission file.
# Change ports / wheel size here ONCE instead of in every mission.

from pybricks.hubs import PrimeHub
from pybricks.pupdevices import Motor
from pybricks.parameters import Direction, Port
from pybricks.robotics import DriveBase

hub = PrimeHub()

leftWheel = Motor(Port.A, Direction.COUNTERCLOCKWISE)
leftAttachment = Motor(Port.B)
rightWheel = Motor(Port.E)
rightAttachment = Motor(Port.F)

driveBase = DriveBase(leftWheel, rightWheel, 49.5, 160)

# Remember the starting speed settings so each mission begins fresh,
# even if the mission before it changed the speeds.
DEFAULT_SETTINGS = driveBase.settings()


def reset_settings():
    # Called right before every mission: default speeds, gyro ON,
    # and zero the heading so "straight ahead" is wherever the robot is now.
    driveBase.settings(*DEFAULT_SETTINGS)
    driveBase.use_gyro(True)
    driveBase.reset()


def park():
    # Called after every mission: let go of the wheels and turn the gyro OFF
    # so the robot doesn't fight you when you pick it up between missions.
    driveBase.stop()
    driveBase.use_gyro(False)


def stop_everything():
    park()
    leftAttachment.stop()
    rightAttachment.stop()
