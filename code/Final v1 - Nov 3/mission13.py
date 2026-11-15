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
driveBase.settings(straight_speed=600, straight_acceleration=600)
driveBase.straight(-10)
driveBase.reset()

driveBase.straight(720)
driveBase.curve(100,45)
driveBase.straight(130)
rightAttachment.run_angle(200,-345)
wait(1000)
rightAttachment.run_angle(600,250)
driveBase.straight(-300)
driveBase.turn(45)
leftAttachment.run_angle(600,-250)
wait(500)
driveBase.straight(70)
leftAttachment.run_angle(100,120)
driveBase.turn(10)
driveBase.straight(-100)
driveBase.turn(60)
driveBase.straight(600)
