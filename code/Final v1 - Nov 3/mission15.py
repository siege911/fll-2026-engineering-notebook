from pybricks.hubs import PrimeHub
from pybricks.pupdevices import Motor, ColorSensor, UltrasonicSensor, ForceSensor
from pybricks.parameters import Button, Color, Direction, Port, Side, Stop
from pybricks.robotics import DriveBase
from pybricks.tools import wait, StopWatch

hub = PrimeHub()


#This is a cool comment

leftWheel = Motor(Port.A, Direction.COUNTERCLOCKWISE)
leftAttachment = Motor(Port.B)
rightWheel = Motor(Port.E)
rightAttachment = Motor(Port.F)


driveBase = DriveBase(leftWheel,rightWheel,49.5,160)
driveBase.use_gyro(True)

driveBase.settings(straight_speed=800,straight_acceleration=800)
driveBase.straight(220)
rightAttachment.run_angle(500,-0)
driveBase.straight(145)
leftAttachment.run_angle(200,-140)
rightAttachment.run_angle(400,-1000)
driveBase.straight(-450)

