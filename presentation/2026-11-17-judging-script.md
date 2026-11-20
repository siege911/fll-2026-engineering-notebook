# **Innovation Project**

## **1\. Isla  ·  OPENING \+ IDENTIFY: Say hi \+ the hook \+ Problem definition**

*Judges want: "Clear definition of the problem"*

Hi\! We are the Rooted Warriors from Flagstaff, Arizona.

Before we start, let me introduce you to our Season App. We documented every part of the process in this interactive Engineering Notebook. Feel free to follow along as we go. Now for our Innovation Project:

Imagine driving on I-17 at night when an elk steps onto the road. We learned that I-17 has about 300 animal strikes a year. That is almost one crash every single day. A new 21-million-dollar wildlife bridge at Willard Springs should cut those crashes by 90 percent. But will it work and is it worth the cost? We explored several options to help solve this problem.

**Show:** Whole team in a line, trifold behind you · Hand the judges the tablet or laptop with the Season App open on the Dashboard ("follow along") · then point to the Problem section of the trifold (in the app: Innovation Project → The Problem).

**Note:** The bridge cost is \$21 million, ADOT's current number (it may go up to \$24 million later). Open the app on the Dashboard before you walk in, so handing it over takes 2 seconds.

 

## 

## **2\. Adeline  ·  IDENTIFY \+ DESIGN: Research \+ Project plan**

*Judges want: "Clear, detailed research from a variety of sources · Clear evidence of an effective project plan"*

We used a variety of experts and resources when approaching this problem. We had 3 different ideas to help. First we considered a system that would alert drivers to animals using a camera or sensor and a flashing light. Next we considered a camera in a car that could alert a driver to an animal. Finally we considered a camera that would help track how many animals used the bridge vs other crossing locations.

We interviewed an expert, Nate Ragan. He said Game and Fish uses expensive GPS collars to track animal movement. We researched what other communities have done to solve this problem. In Banff, Canada, 44 wildlife crossings cut crashes with big animals by more than 80 percent. But the Los Angeles Times reported that just building a crossing doesn't mean animals will use it, so in places like Nepal, scientists use camera traps to check.

Ultimately we decided to build a multi-purpose camera that could detect animals then apply to all 3 solutions starting with tracking animals crossing the new bridge and compare results. We started by making a project plan as a Gantt chart in our team app. Every task has an owner and dates, from picking the design to practicing this talk.

**Show:** Hold up 3 fingers for the 3 ideas (or point to them on the trifold: warning light · in-car camera · bridge-counting camera) · In the app: Innovation Project → Experts & Their Feedback (Nate's card), then Research Collection (Nolan's websites: Banff, LA Times, WWF/Nepal) · then the Gantt chart (Innovation Project → Project Plan).

**Note:** The Banff and Nepal facts come from Nolan's research (Think Wildlife Foundation, WWF, Los Angeles Times), all in Research Collection, so a judge can see the sources. The 3 ideas (warning light, in-car camera, bridge camera) aren't written in the notebook yet: add a dated entry.

 

## 

## **3\. Thea  ·  DESIGN \+ CREATE: Team involvement \+ Innovation**

*Judges want: "Clear evidence that development involved all team members · Detailed explanation of innovation in the solution"*

Everybody had a job. I led the design and programmed the camera. Nolan wired it, and Nolan and Weston soldered it. Adeline and I kept our expert notes and made the trifold. Isla and Fynn built the solar panels.

So this is our camera. Our camera is tiny, cheap and smart. We wanted to test which sensor method would work best and use the least amount of energy to check for motion so we built two into our prototype. The infrared motion sensor feels the body heat of a moving animal up to about 15 feet away. The camera takes a picture every second and then compares the current picture with the last one to see if there is any movement.

We use the Raspberry Pi as a collector and AI animal tagger. The Pi's AI, SpeciesNet, names the animal, and blurs out any people.

**Show:** Point to each teammate as you say their job · Hold up the solar panels Isla and Fynn got working on Nov 14 · Hold up the camera and point to the motion sensor, then the camera lens · Soldering photos (Innovation Project → Project Photos) · then the Pi Camera Station touchscreen with a tagged animal photo.

**Note:** Sensor facts are now right for our parts: the AM312 motion sensor reaches about 3–5 meters (10–16 feet), and camera v4 takes a picture every second. Judges may ask "which sensor won?": have an answer, or say it's what you're testing next. A photo of the working solar panels would be great for Project Photos.

 

## 

## **4\. Nolan  ·  CREATE \+ ITERATE: Model / drawing \+ Sharing**

*Judges want: "Detailed model/drawing that represents the solution · Solution shared with multiple people/groups"*

Our wiring diagram shows every wire. It runs on USB-C, from a phone charger or our solar box. This is a breadboard. It helps us prototype our wiring. This is just the first version. We aren't finished yet. Our next step is to build a 3D printed box so we can put this in the forest.

We shared this with Thea's older brother and he suggested we build our own circuit board. He developed his own last year and plans to help us in the next version. We shared our idea with Mr Nate Ragan from Arizona Game and Fish. He gave us a lot of great feedback on what they do and how we could use this.

**Show:** Wiring diagram (Innovation Project → Innovation Project Details → Camera Wiring Diagram, or printed on the trifold) · Hold up the breadboard camera and a USB-C phone charger or the solar box · then the Communication table (Innovation Project → Communication).

**Note:** Thea's brother is now in the Communication table, so it shows Nate, Thea's family, Thea's brother and ADOT: "multiple people/groups" ✓. Add "Design and 3D-print the box" to the Gantt chart so the next step is part of the plan.

 

## 

## **5\. Weston  ·  ITERATE \+ COMMUNICATE: Improvements \+ Explanation & impact**

*Judges want: "Clear evidence of improvements based on feedback · Clear explanation of solution and its impact on others"*

Feedback changed our design. Some of the feedback Mr Nate gave us was to blur out pictures of people. He said people do weird things in the forest and we should be careful. So our Raspberry Pi blurs out any pictures of people before we see them. Our first plan was to put the Raspberry Pi in the forest. After our research, we switched to the tiny camera due to lower energy usage and a smaller solar panel.

Here is how it all works together: the small camera detects movement and saves the picture. Raspberry Pi comes and collects the pictures via WiFi. SpeciesNet tags the animals and blurs any people. Knowing where animals cross helps put crossings in the right places and validates whether animals are using the existing crossings: fewer crashes for animals and drivers.

**Show:** Pi touchscreen: a photo with a person blurred · Before → after on the trifold (Raspberry Pi in the forest → tiny camera \+ small solar panel) · then point along the path on the trifold: camera → Pi (Wi-Fi) → SpeciesNet → us → fewer crashes.

**Note:** The switch from the Pi to the tiny camera is your best "improvement" story: make sure the notebook has it as a decision with the reason. A number makes it stronger: our Oct 3 research says a Pi 4 uses 3–5 watts all the time.

 

## 

## **6\. Fynn  ·  COMMUNICATE \+ CLOSING: Pride & enthusiasm \+ Next steps \+ thank you**

*Judges want: "Presentation clearly shows pride or enthusiasm"*

We are so proud not just of what we built but also what we learned\! We learned about how electricity works in electronics. We did real soldering. We learned about how forest animals interact with our cities and roads. We built a working camera. On November 9 the whole system worked for the first time: camera, to Pi, to AI\!

Next, we give it a proper case and it goes outside to find real animals. Our coach has talked to the ADOT District Administrator for the Northcentral District and is filling out the paperwork for allowing us to put the camera on the bridge. We hope to have some data in the next couple of months as the bridge is completed. Thank you\! Do you have any questions for us?

**Show:** Hold up the camera · Pi touchscreen with the first photo from November 9 · then everyone together, big smiles.

**Note:** The ADOT contact and the paperwork are now in the notebook and the Communication table ✓. Add a Nov 9 photo to Project Photos so you have something to show for "it worked for the first time."

 

# 

# **Robot Design**

## **1\. Isla  ·  OPENING \+ IDENTIFY: Meet our robot \+ Mission strategy**

*Judges want: "Clear evidence of mission strategy"*

This is our robot\! Our mission strategy this year started with a robot base. We wanted to balance speed and accuracy. We started by testing 8 different wheels. We decided on this one because it has good traction and is accurate. Next we decided on size. Our robot is low and wide with extra bracing, so it doesn't tip and it turns accurately.

We built three copies of the base, so we can test three attachments at once and have a spare. Our strategy: split up the board and work on multiple missions at once. We first built an attachment for a single mission, then we grouped nearby missions together for our attachments. Now we can do all 15 missions in nine runs.

**Show:** Hold up the robot and point to its wheels (bring 2 or 3 of the wheels you tested if you can) · Tradeoff Decisions on the Robot Design page (wheels, low \+ wide, three copies) · then the Run Plan & Time Check on the Robot Game page (9 runs).

**Note:** In the app, the "Which drive tires?" tradeoff still says "(students: which tires did you compare?)": write in the 8 wheels and why you picked this one, and your three-copies reason. We haven't done a full timed run of the whole board yet. Do one before the tournament, so if a judge asks "how long do all nine runs take?" you have a real number.

 

## 

## **2\. Adeline  ·  IDENTIFY \+ DESIGN: Use of resources \+ All members contributed**

*Judges want: "Clear use of building or coding resources to support the strategy · Clear evidence that all team members contributed ideas"*

We code in Python, using Pybricks. We learned concepts like gyro turns and how to run multiple motors doing different things at the same time.

This robot was specifically missing its gears. This allowed one person to focus on building and hand drive the robot around the map testing attachments. Then we would switch to one of the two robots with gears to actually program the mission.

Everyone contributed ideas. By September 19, all six of us built or programmed something. As we continued working, we leaned into each other's strengths. Nolan and Weston were our Master Builders. They helped build or fix most of the attachments. Isla and Adeline did a lot of the initial programming work. Then Fynn did the final runthrough on all coding to make sure each mission ran fast and accurately. Thea helped track and document our progress and tests in this App. And we built on each other's work: For instance, Fynn started the Forest Elder attachment, Isla finished it, and Adeline rebuilt it to make it better.

**Show:** Laptop: Pybricks open to a program with a gyro turn and two motors moving at once · Hold up the robot with no gears next to one with gears · Point to each teammate as you name them · then "Who's Been Doing What" (Dashboard) or the Team Profile (Core Values page).

**Note:** The no-gears build-and-test robot isn't in the notebook: add it as a tradeoff decision (it's also a great reason for building three copies). Fynn's fine-tuning of every attachment (Nov 9 \+ Nov 13\) is now in the notebook ✓; Fynn's final run-through of the code isn't logged yet.

 

## 

## **3\. Weston  ·  DESIGN \+ CREATE: Skills in all members \+ Attachments**

*Judges want: "Clear evidence of building and coding skills in all team members · Clear explanation of innovative attachments and their purpose"*

Every one of us builds AND codes. I built the base, then my first attachment for Mission 14, then programmed Mission 9\. Thea was a builder and wrote her first program for Mission 12\. Nolan built attachments and programmed Missions 2 and 3\. We all had a part.

Our attachments do more than one mission per trip. Our 2-and-3 attachment knocks the seeds loose and flips the rock. Our favorite attachment is probably this one for Mission 14\. We're supposed to deliver the seeds into this thing. Since this mission isn't attached to the board, we tried something different. We used these arms to unlock the mission from the board and then these hooks to lift up the whole mission and bring it back to base. It's just one of the many ways we approached problems on the game board in unique ways.

**Show:** The 2+3 attachment · then demo the Mission 14 attachment on the mat: arms unlock the model, hooks lift it, robot drives it back to base (Robot Design → Attachments Over Time has its photo).

**Note:** Fynn fine-tuned the Mission 14 attachment on Nov 9\. If it looks different from the Nov 2 photo in the app, take a new one. Know the Mission 14 rule in case a judge asks whether bringing the model back to base is allowed.

 

## 

## **4\. Fynn  ·  CREATE \+ ITERATE: Code / sensors \+ Testing**

*Judges want: "Clear explanation of innovative code and/or sensor use · Clear evidence of repeated testing of robot and code"*

Our code uses the gyro in the hub to drive straight and turn exactly, and measures distance with wheel rotations. Adeline made a program template that every mission starts from, so they all set up the motors and wheels the same way. When a mission ends, the system turns off the gyro and automatically selects the next mission. Each mission starts by backing up to square itself with the wall and then resets the gyro for maximum accuracy.

We tested over and over and refined for consistency. Mission 14 worked 5 out of 5 times. Missions 4 and 5 worked 4 out of 5\. On November 8, Isla and I tested every mission and listed what needed work, like Mission 15's yellow arm. We timed every mission to see how long they took and worked to find ways to speed them up. For instance we rebuilt this attachment for Missions 2 and 3 to make it more consistent by aligning with the base and lowering our grabber.

**Show:** Laptop: a mission program, pointing to the back-into-the-wall \+ gyro reset lines and the next-mission menu · Run the robot squaring on the wall if there's a mat · Attachments Over Time (Robot Design page: Fynn's Nov 9 \+ Nov 13 fine-tuning) and Run Plan times (Robot Game page) · then hold up the finished 2+3 attachment.

**Note:** Fynn's fine-tuning is logged now (Nov 9: Missions 6, 7, 14 and some of 2+3; Nov 13: finished 2+3, worked on 8+9) ✓. Test Sessions still has only 3 rows with numbers: count tries (like "5 out of 5") at the next practice and add them. A full timed run of the whole board would make this row even stronger.

 

## 

## **5\. Thea  ·  ITERATE \+ COMMUNICATE: Improvements \+ Process & lessons learned**

*Judges want: "Clear evidence of improvements based on testing · Detailed explanation of process and lessons learned"*

Our code changed 18 times this season. You can see in our app all of the code changes. The Mission 4 program changed at four practices in a row, grew from 19 lines to 57, and got faster. We rebuilt the Research Platform attachment from a motorized lifter to a passive push system. This allowed us to use the motors to grab the vine and the seed separately. We split Mission 12 into two parts to fit our runs better.

Our process: build, code, test, fix, repeat. Lesson one: time real runs. Our first plan was all guesses and way too long. Lesson two: combine missions to save trips. Lesson three: write everything down, so we know who did what and every change.

**Show:** Coding page → Our Robot Code (the code history grid; tap Mission 4 to show 19 → 57 lines) · then hold up the Research Platform (Missions 8 \+ 9\) attachment and point to the passive pusher and the two motors · Run Plan: Mission 12 in runs 6 and 8\.

**Note:** The motorized lifter → passive push rebuild isn't in the notebook with its own date and reason yet (Fynn worked on Missions 8 \+ 9 on Nov 13). Add when it happened and who did it to Attachments Over Time.

 

## 

## **6\. Nolan  ·  COMMUNICATE \+ CLOSING: Pride & enthusiasm \+ Next steps \+ thank you**

*Judges want: "Team clearly shows pride or enthusiasm"*

We are proud of how far we came\! In August we had one robot base and now we have every mission complete. Not only did each and every one of us build an attachment and code something, we all learned our strengths. We found that we are better when we recognize that something special in each teammate.

I found out that I can build complicated attachments. I learned that Fynn is a super coder. I learned that a team needs someone to help keep us on track and documenting all of our progress. Thea did that and our team App is a result of her work. We each did our part and we progressed further this year than we ever have. Thank you\! Do you have any questions for us?

**Show:** Hold up one attachment you built · Point to Fynn, then to Thea and the app · then everyone together, big smiles\!

**Note:** Every mission now shows Working in the app ✓ (from Fynn's Nov 9 testing). Save the "we found our strengths" line as a Proudest Moment in the app.

