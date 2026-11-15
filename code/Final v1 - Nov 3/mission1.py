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

#driveBase.straight(-10)
#driveBase.turn(93)
driveBase.straight(470)

driveBase.curve(380,-30)
driveBase.turn(-30)
driveBase.turn(64)
driveBase.settings(straight_speed=600)
driveBase.straight(-750)