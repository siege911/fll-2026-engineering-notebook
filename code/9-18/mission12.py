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


driveBase = DriveBase(leftWheel,rightWheel,49.5,147)
driveBase.use_gyro(True)

rightAttachment.run_angle(480,90)
driveBase.straight(345)
rightAttachment.run_angle(500,-0)
driveBase.straight(145)
leftAttachment.run_angle(200,-170)
leftAttachment.run_angle(200,100)
rightAttachment.run_angle(200,50)
driveBase.straight(-200)
rightAttachment.run_angle(200,-180)
driveBase.straight(-250)