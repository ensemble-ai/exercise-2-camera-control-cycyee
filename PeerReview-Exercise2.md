# Peer-Review for Programming Exercise 2

## Description

For this assignment, you will be giving feedback on the completeness of assignment two: Obscura. To do so, we will give you a rubric to provide feedback. Please give positive criticism and suggestions on how to fix segments of code.

You only need to review code modified or created by the student you are reviewing. You do not have to check the code and project files that the instructor gave out.

Abusive or hateful language or comments will not be tolerated and will result in a grade penalty or be considered a breach of the UC Davis Code of Academic Conduct.

If there are any questions at any point, please email the TA.

## Due Date and Submission Information

See the official course schedule for due date.

A successful submission should consist of a copy of this markdown document template that is modified with your peer review. This review document should be placed into the base folder of the repo you are reviewing in the master branch. The file name should be the same as in the template: `CodeReview-Exercise2.md`. You must also include your name and email address in the `Peer-reviewer Information` section below.

If you are in a rare situation where two peer-reviewers are on a single repository, append your UC Davis user name before the extension of your review file. An example: `CodeReview-Exercise2-username.md`. Both reviewers should submit their reviews in the master branch.

# Solution Assessment

## Peer-reviewer Information

- _name:_ Emma Chan
- _email:_ ethchan@ucdavis.edu

### Description

For assessing the solution, you will be choosing ONE choice from: unsatisfactory, satisfactory, good, great, or perfect.

The break down of each of these labels for the solution assessment.

#### Perfect

    Can't find any flaws with the prompt. Perfectly satisfied all stage objectives.

#### Great

    Minor flaws in one or two objectives.

#### Good

    Major flaw and some minor flaws.

#### Satisfactory

    Couple of major flaws. Heading towards solution, however did not fully realize solution.

#### Unsatisfactory

    Partial work, not converging to a solution. Pervasive Major flaws. Objective largely unmet.

---

## Solution Assessment

### Stage 1

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

---

#### Justification

The center of the camera is perfectly one-to-one with the vessel's position as specified in the prompt. A cross to indicate the camera's center is drawn on the screen exactly as specified by the prompt.

---

### Stage 2

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

---

#### Justification

As specified in the prompt, the camera automatically moves right and pushes along the vessel if the vessel is stationary.

I only have a few nitpicks. One of them is that the vessel jitters when touching the right side of the frame. This could easily be fixed by changing \_physics_process in the Vessel code to \_process. Another nitpick is that I found the autoscroll speed to be a bit too fast compared to the vessel's speed. This however isn't a problem with the implementation itself. This is more of a game-feel nitpick.

---

### Stage 3

- [x] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

---

#### Justification

The camera's catchup strikes a good balance between being smooth and being snappy. The position-lock lerp as a whole follows the assignment's instructions fairly well. Nice touch implementing an actual lerp algorithm.

The one nitpick I have is the same from Stage 2: the vessel's jittering caused by \_process and \_physics_process running together.

---

### Stage 4

- [ ] Perfect
- [x] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

---

#### Justification

The camera pulls out ahead of the vessel as it should. The camera's repositioning to the vessel also feels very smooth and snappy. The cross indicating the camera's center is drawn exactly as specified by the prompt. The student once again adds a nice touch by implementing an actual lerp algorithm.

If I had a game-feel nitpick, it would be that the leash distance is a bit too short for the intended look-ahead effect to be noticeable when the camera is more zoomed out. The jittering nitpick from Stages 2 and 3 also applies here.

---

### Stage 5

- [ ] Perfect
- [ ] Great
- [x] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

---

#### Justification

The camera moves at push_ratio \* vessel's speed when the vessel is between the speedup zone and pushbox border as specified in the prompt. The camera also moves at full speed when the vessel touches the pushbox border. As a whole, the camera movement follows the prompt's specifications when the vessel is moving exactly right, left, up, or down.

However, when the vessel starts moving diagonally, the implementation's major flaws begin to show. In that situation, the vessel is unable to move towards the corners of the outer pushbox. More specifically, the vessel is immediately nudged back towards the up, left, right, or down directions when trying to move diagonally. The jittering nitpick from Stages 2, 3, and 4 also apply here.

---

# Code Style

### Description

Check the scripts to see if the student code adheres to the GDScript style guide.

If sections do not adhere to the style guide, please peramlink the line of code from Github and justify why the line of code has not followed the style guide.

It should look something like this:

- [description of infraction](https://github.com/dr-jam/ECS189L) - this is the justification.

Please refer to the first code review template on how to do a permalink.

#### Style Guide Infractions

- [excessive line lengths](https://github.com/ensemble-ai/exercise-2-camera-control-cycyee/blob/5e5998c59a2aca0f6119cf5ad2f32f2a744b4329/Obscura/scripts/camera_controllers/speedup_push_zone.gd#L38) - Some lines exceed 100 characters which makes the code less easy to read and follow. This could be solved by making use of backslashes to break up those lengthy lines into multiple lines.

#### Style Guide Exemplars

- [Student follows the rule of two spaces between each function.](https://github.com/ensemble-ai/exercise-2-camera-control-cycyee/blob/5e5998c59a2aca0f6119cf5ad2f32f2a744b4329/Obscura/scripts/camera_controllers/lerp_target_focus.gd#L12-L19) Outside of the infraction listed above, the student seemed to follow the GDScript style guide well.

---

---

# Best Practices

### Description

If the student has followed best practices then feel free to point at these code segments as examplars.

If the student has breached the best practices and has done something that should be noted, please add the infraction.

This should be similar to the Code Style justification.

#### Best Practices Infractions

- Variable declarations - The student should specify the type more often when declaring variables. This would make the code's intentions more clear and also prevent the assignment of invalid values to those variables. Instances of this infraction can be seen [here](https://github.com/ensemble-ai/exercise-2-camera-control-cycyee/blob/5e5998c59a2aca0f6119cf5ad2f32f2a744b4329/Obscura/scripts/camera_controllers/lerp_target_focus.gd#L26) and [here](https://github.com/ensemble-ai/exercise-2-camera-control-cycyee/blob/5e5998c59a2aca0f6119cf5ad2f32f2a744b4329/Obscura/scripts/camera_controllers/speedup_push_zone.gd#L30).

#### Best Practices Exemplars

- Comments - Good use of comments to clarify parts of the camera movement algorithms such as [here](https://github.com/ensemble-ai/exercise-2-camera-control-cycyee/blob/5e5998c59a2aca0f6119cf5ad2f32f2a744b4329/Obscura/scripts/camera_controllers/speedup_push_zone.gd#L31) and [here](https://github.com/ensemble-ai/exercise-2-camera-control-cycyee/blob/5e5998c59a2aca0f6119cf5ad2f32f2a744b4329/Obscura/scripts/camera_controllers/lerp_target_focus.gd#L35).
