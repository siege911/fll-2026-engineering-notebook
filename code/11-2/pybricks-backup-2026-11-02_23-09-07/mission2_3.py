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

driveBase.straight(-15)
driveBase.straight(400)
driveBase.turn(-15.12)
driveBase.straight(90)
driveBase.straight(-410)
driveBase.turn(60)
driveBase.straight(510)
rightAttachment.run_angle(50,90)
driveBase.straight(-500)
