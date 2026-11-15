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

leftAttachment.run_angle(100, 220, wait=False)

driveBase.straight(140)
driveBase.turn(45)
driveBase.straight(655)
driveBase.turn(-45)
driveBase.straight(150)
rightAttachment.run_angle(80,-165)
#driveBase.straight(-100)
leftAttachment.run_angle(100,-60,wait=False)
rightAttachment.run_angle(300,90)
driveBase.settings(straight_speed=120)
driveBase.straight(270)
leftAttachment.run_angle(100,30)
driveBase.settings(straight_speed=600)
driveBase.straight(-90)
driveBase.turn(-10)

driveBase.straight(-140)
driveBase.turn(50)
driveBase.straight(-700)