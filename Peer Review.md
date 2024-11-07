# Peer-Review for Programming Exercise 2 #

## Description ##

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.   

## Due Date and Submission Information
See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.  

# Solution Assessment #

## Peer-reviewer Information

* *name:* Qingyue Yang
* *email:* yqmyang@ucdavis.edu

### Description ###

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect #### 
    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great ####
    Minor flaws in one or two objectives. 

#### Good #####
    Major flaw and some minor flaws.

#### Satisfactory ####
    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory ####
    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.


___

## Solution Assessment ##

### Stage 1 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Nice implementation overall. I do not see any mistakes in this stage, so I pick 'Perfect' for this stage. The control is nice and the cross line looks pretty good for me.

___
### Stage 2 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The scoll of the camera is smooth and the vessel do moving left when it touch the left side of the box. The export fields also meet the requirements. Good job!

___
### Stage 3 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Very smooth! And the arguments are being adjusted satisfied. I love the over all feeling of this stage. Also, all the code part, inlcuding the export fields fully meet the requirement.

___
### Stage 4 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Smooth as stage 3 is. Perfect to meet the requirements in the description of the assignment. 

___
### Stage 5 ###

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
Good implementation. All 4 way can being speeding up as required.
___
# Code Style #


### Description ###
Check the scripts to see if the student code adheres to the GDScript style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

* [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.


#### Style Guide Infractions ####

You follow the GDScript Style Guide generally with a few problems that might make it better if you can fix it. I noticed that some of your lines are over 100 characters, like this: https://github.com/ensemble-ai/exercise-2-camera-control-cycyee/blob/0996a006663364bd671e7c425acdd24f0c56ac6c/Obscura/scripts/camera_controllers/speedup_push_zone.gd#L38 , it is better to lower the number of characters in a single line to make your code much more understandable. Also, remember to add a space after the "#" when you try to explain something as a comment, like this: https://github.com/ensemble-ai/exercise-2-camera-control-cycyee/blob/0996a006663364bd671e7c425acdd24f0c56ac6c/Obscura/scripts/camera_controllers/lerp_position_lock.gd#L58 . Overall, you did a good job!

#### Style Guide Exemplars ####

The namings of conventions are perfect in this assignment, like the Classname is https://github.com/ensemble-ai/exercise-2-camera-control-cycyee/blob/0996a006663364bd671e7c425acdd24f0c56ac6c/Obscura/scripts/camera_controllers/lerp_position_lock.gd#L1 , and we got the file name "lerp_position_lock.gd", which follows the GDScript Style Guide.

___
#### Put style guide infractures ####

Here is the guide I used in this assignment: https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html , and also the StyleGuide.md in the course folder.

___

# Best Practices #

### Description ###

If the student has followed best practices then feel free to point at these code segments as examplars. 

If the student has breached the best practices and has done something that should be noted, please add the infraction.


This should be similar to the Code Style justification.

#### Best Practices Infractions ####

You follow the the style guide of the GDScript very well, but there are few things you need to pay attention to, which could make your code more readable and understandable for other readers. Most of the parts in your assignment is good, but you might need to pay attention on the comments of the code. Some of your code lack of comments, which might lead confusions. 

* Lack of Comment: https://github.com/ensemble-ai/exercise-2-camera-control-cycyee/blob/de3f8172d9ee2f81fc6dfdd2a723ca713b3e0755/Obscura/scripts/camera_controllers/lerp_target_focus.gd#L26-L31 , this block of code is confused and need some time to understand because of the lack of the comments.
* Unproper Return Value: https://github.com/ensemble-ai/exercise-2-camera-control-cycyee/blob/de3f8172d9ee2f81fc6dfdd2a723ca713b3e0755/Obscura/scripts/camera_controllers/lerp_position_lock.gd#L35 , you can add "->" to declare the return value type of the function, which makes the function much more clear.

#### Best Practices Exemplars ####

* Good Code Order: https://github.com/ensemble-ai/exercise-2-camera-control-cycyee/blob/de3f8172d9ee2f81fc6dfdd2a723ca713b3e0755/Obscura/scripts/camera_controllers/lerp_position_lock.gd#L1-L9 , the code order of your flies are pretty good for me. And it meet the requirement described in the style guide of the GDScript.
