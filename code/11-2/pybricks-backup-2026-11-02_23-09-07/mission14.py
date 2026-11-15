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
driveBase.settings(straight_speed=680)

driveBase.straight(-10)
driveBase.curve(200,90)
driveBase.straight(50)
driveBase.curve(200,-90)
driveBase.straight(110)
driveBase.turn(90)
driveBase.straight(220)
leftAttachment.run_angle(500,-1900)
driveBase.straight(-90)
driveBase.turn(90)
driveBase.curve(175,-90)
driveBase.curve(2800,18)
