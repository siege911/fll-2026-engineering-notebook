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

rightAttachment.run_angle(100, 60, wait=False)
driveBase.straight(100)
driveBase.turn(-40)
driveBase.straight(450)
leftAttachment.run_angle(750,rotation_angle=-470)
rightAttachment.run_angle(200, -60)
driveBase.straight(-450)
driveBase.turn(30)
driveBase.straight(600)
driveBase.turn(-80)
driveBase.straight(400)
driveBase.turn(130)
rightAttachment.run_angle(200, 60, wait=False)
driveBase.straight(180)
driveBase.settings(straight_speed=100)
rightAttachment.run_angle(200, -60, wait=False)
driveBase.straight(150)
rightAttachment.run_angle(1000, 200)
drivebase.straight(-300)
driveBase.angle(-600)