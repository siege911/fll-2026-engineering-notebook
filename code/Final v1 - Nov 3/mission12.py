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

DriveBase.settings
driveBase = DriveBase(leftWheel,rightWheel,49.5,160)
driveBase.use_gyro(True)

driveBase.straight(-10)
driveBase.reset()

driveBase.settings(straight_speed=600)

driveBase.straight(425)
rightAttachment.run_angle(100,55)
driveBase.settings(straight_speed=100)
driveBase.straight(-160)
rightAttachment.run_angle(50,-20)
driveBase.turn(15)
driveBase.settings(straight_speed=600)
driveBase.straight(-200)




