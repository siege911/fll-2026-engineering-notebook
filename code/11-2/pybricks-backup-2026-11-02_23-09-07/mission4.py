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

driveBase.settings(straight_speed=700, straight_acceleration=400, turn_acceleration=500)

driveBase.straight(-15)
driveBase.reset()

leftAttachment.run_angle(100, -300, wait=False)
rightAttachment.run_angle(100, 200, wait=False)

#Across the mat
driveBase.straight(855)
#Turn toward bugs
driveBase.turn(-45)
#right attachment goes down
rightAttachment.run_angle(300, -160)
# drives backwards
driveBase.settings(straight_speed=200, turn_acceleration=200)
driveBase.straight(-30)
# turn into branch thing
driveBase.turn(55)
rightAttachment.run_angle(100, -60, wait=False)
#back up
driveBase.straight(-100)
driveBase.settings(straight_speed=700, straight_acceleration=700, turn_acceleration=200)
# right attachment up
rightAttachment.run_angle(600, 180, wait=False)

# goes straight 
driveBase.straight(210)
# right attachment down
rightAttachment.run_angle(700, -80)
wait(300)
# right attachment up
rightAttachment.run_angle(700, 90)
# go backwards back to home
driveBase.straight(-150)
driveBase.turn(-55)
leftAttachment.run_angle(700,300)
driveBase.straight(70)
leftAttachment.run_angle(700,-250)
driveBase.curve(-400, -120)
#driveBase.straight(-820)