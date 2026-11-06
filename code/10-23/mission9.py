from pybricks.hubs import PrimeHub
from pybricks.pupdevices import Motor, ColorSensor, UltrasonicSensor, ForceSensor
from pybricks.parameters import Button, Color, Direction, Port, Side, Stop
from pybricks.robotics import DriveBase
from pybricks.tools import wait, StopWatch

hub = PrimeHub()


leftWheel = Motor(Port.A, Direction.COUNTERCLOCKWISE)
leftAttachment = Motor(Port.B)
rightWheel = Motor(Port.E)
rightAttachment = Motor(Port.F)

driveBase = DriveBase(leftWheel,rightWheel,49.5,160)

driveBase.use_gyro(True)

driveBase.settings(straight_speed=600, turn_rate=600)

driveBase.straight(-10)
driveBase.reset()

driveBase.straight(350)
driveBase.turn(50)
driveBase.straight(510)           
driveBase.turn(-50)

driveBase.settings(straight_speed=100)
driveBase.straight(300)
driveBase.settings(straight_speed=600)
driveBase.straight(-300)
driveBase.turn(50)
driveBase.straight(-600)
driveBase.turn(50)