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

driveBase.straight(-10)
driveBase.straight(700)
driveBase.curve(200,45)
driveBase.straight(70)
rightAttachment.run_angle(500,300)
rightAttachment.run_angle(500,-300)
driveBase.straight(-70)
driveBase.curve(-200,45)
driveBase.straight(-700)





