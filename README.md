[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/7io8ezdF)
**CMSI 2022** Mobile Application Development, Spring 2026

## Due Date: May 08, 2026, 11:59 PM

# Assignment 0508
This is it, this is what we have been building toward: a mobile app fully conceived, designed, and implemented by you. By doing so, you will demonstrate the ability to ideate, design, and implement a beautiful, secure mobile application of your choice, using both a third-party API and a secure database, in a team of students, with well-defined roles, following modern development practices.

## Background Reading
All prior readings and resources can come into play here; no new baseline technical information is involved. Keep all prior links from all prior assignments handy.

New information may be required for specific solutions to specific issues in your specific app, and for that, we’ll want you to exercise the ability to search the web on your own while also knowing when the most effective overall use of everyone’s time is to ask questions directly.

## For Submission
Create a mobile app—that’s it!

🤔

Welllll, we _do_ want this app to be the culmination of what has been learned this semester. As such, your app must:
- Properly use authentication
- Communicate with at least one third-party web service API
- Use a database to persist application-specific information

In addition, we will have you follow a [specific process](https://cs.lmu.edu/~ray/notes/ideation/) for _ideating_ your app. You will document this process as follows:
- Develop an _ideation.md_ file that records the results of your team’s _preliminary ideation_ process (we will work on this during the 0408 class session)
- Participate in classtime _sharing/feedback pairings_ to crystallize your idea (it’s OK to already be at work on your idea by this time—the exercise is more about refining the way you express your idea). We will do this during the 0407 class session
- Develop an _elevator pitch_ for your app, three (3) minutes max. Submit its outline/salient points in a _pitch.md_ file. We will share our pitches with each other on **0409**
- During the final exam slot designated by the registrar for the respective course, teams will give a final presentation and demo of their respective apps, five (5) minutes max. The content of this presentation will be captured in an _about.md_ file

👉🏽 _If you are unable to attend the final exam slot, please notify me as soon as possible so that we can make other arrangements!_

Note that the above activities demand attendance due to both the nature of the process and out of respect to your teammates and fellow students. Please plan accordingly.

As before, continue to reinforce and build upon the skills you have already learned:
* Use of model objects to convert back-end information representations into structures that work well with SwiftUI views
* Retrieval from and interaction with different back-ends
* Abstraction of back-end operations behind classes, objects, methods, and functions (async where appropriate)
* Appropriate user interface feedback for operations-in-progress
* Correct error handling with messaging to the user when appropriate
* Effective layout via proper composition of stacks, spacers, padding, and other SwiftUI features
* Appealing color choices and visuals—demonstrate your mastery of views and their properties (without violating any iOS Human Interface Guidelines 😅)
* Proper choice of input views and controls
* Well-chosen animations or transitions beyond the standard SwiftUI view behaviors
* Well-chosen programmed graphics using paths, gradients, and related functions
* Custom app icon

Due to the open-endedness of what your web app can be, we no longer have an all-or-nothing section. But please do use every possible technology, attribute, property, and technique at your disposal in order to make the best possible version of your app idea! 🖍️🛠️🧰🖌️

## Documentation Outlines/Templates
Use the following outlines to drive what goes into _ideation.md_, _pitch.md_, and _about.md_. Note that the first two items are clearly derived from the [ideation process](https://cs.lmu.edu/~ray/notes/ideation/) on Dr. Toal’s website. The _about.md_ outline should also serve as a guide to your final presentation.

### _ideation.md_—Preliminary Ideation Results (due 0409)
1. Which audiences did you consider, and which one did you settle on for your app?
2. List the ten needs that you identified for your chosen audience
3. State the three needs that were chosen out of the ten, and state the projects that you mapped to those needs
4. For each of the three projects, list the goals/ideas that you brainstormed for them
5. State the “winner” of this process

### _pitch.md_—Pitch Exercise Results (due 0409)
Combining your preliminary ideation content and the feedback heard on 0407…
1. State the final inspiration statement that you crafted for your chosen audience
2. State the possible solutions from preliminary ideation that you considered
3. State the final app idea that your team has decided to do

### _about.md_—Final Presentation/Description of Your Mobile App
* Provide a title for your overall project (it doesn’t have to be the app’s name, but it should certainly describe it)
* List your team and supply your general roles
* Explain your user audience and their needs
* Show your app in action
    * **In the _about.md_ file:** Provide screenshots of your app, with captions/commentary as appropriate
    * **During the finals week presentation:** Show a brief demo of your app
* State technology highlights: the API(s) you use, what you store in your database, anything cool, hot, challenging, or annoying/frustrating
* List any acknowledgements/thanks/credits
* 👏🏼👏🏼👏🏼

## Operational Tips/Suggestions
* Preliminary ideation should give you sufficient scope to start developing the software, so don’t wait to do that with your team so that software development can commence! The semester will be over before you know it. The ideation exercises and elevator pitch will refine your app idea and how you express it to others but are not expected to cause your app to change drastically
* Note again that the wealth of possibilities means that self-study and experimentation are built into the work involved with this assignment. Make sure to plan accordingly! Learning the material together will help, with multiple eyes looking at the same documentation
* You _will_ make mistakes, change your mind about features, or run into dead ends, all of which will take time—ideally, _build that time in_ when planning out how you will work on the app
* Many operational tips and suggestions from the past assignments also still apply—don’t hestitate to review them!

### Initial setup: Unifying your GitHub and Xcode repositories
This is routine for you now right??? 🤨 For completeness this section is copied from the first assignment’s instructions, and remains relevant if you need to merge an Xcode-created _git_ repository and the GitHub Classroom assignment repo so it is reproduced here.

> The repository for this assignment comes _only_ with this _README.md_ by design, so that you can go through the motions of creating the app project in Xcode yourself. Checking _Create Git repository on my Mac_ will set things up properly but as a _separate_ repository from the one that you get with the assignment, and it takes some specialized _git_ commands to “cross the streams” successfully 👻
>
> Note also that **if you are working in a group**, _only one of you_ needs to do this to the group assignment repository. Once it has been set up, everyone can then clone that repository and should be good to go.
>
> Depending on how much _git_ you have done, you may encounter some “wrinkles” that will feel unfamiliar. Make sure to look at the “`pull` wrinkle” subsections for instructions on how to handle them.
>
> So when setting up for the first time, instead of the usual `git clone` command, do the following:
> 1. Create your initial Xcode project on your machine with the _Create Git repository on my Mac_ option checked
> 2. Acquire the URL of your assignment repository from the green `Code` button on GitHub—let’s call this `YOUR_REMOTE_URL` (this is also what you would do before doing an initial `git clone`, but in this case we will do something different with it—read on)
> 3. Make sure that you don’t have any pending changes on your Xcode project—if so, commit them
> 4. From the command line, `cd` into your Xcode project’s folder and type the following three commands:
>
> ```
> git remote add origin YOUR_REMOTE_URL
> git pull origin main --allow-unrelated-histories
> git branch --set-upstream-to=origin/main main
> ```
>
> (don’t forget to substitute `YOUR_REMOTE_URL` above for the specific URL of your GitHub repository)
>
> That should do it! The repository created by Xcode and the assignment repository that GitHub Classroom gave you should now be “as one.” You should now be able to use _git_ on this folder as if you had `git clone`-d it normally.

Because you will have already done this at least once from prior assignments, you should no longer see the “You have divergent branches…” message upon doing the `git pull`, but if you do, invoke `git config pull.rebase false` then attempt the `pull` again.

And remember that <kbd>:</kbd><kbd>w</kbd><kbd>q</kbd><kbd>⏎</kbd> is the key sequence that gets you out of the _vi_ auto-generated commit message display, in case that comes up.

## How to Turn it In
Commit the following to your repository:
- Complete Xcode project with all code, raw data, and assets
- _ideation.md_—must be submitted/committed by **0409**
- _pitch.md_—must be submitted/committed by **0409**, will be delivered in class on Thursday, **04/09**
- _about.md_—you may use different visuals for your final presentations (e.g., a slide or video presentation), but your presentation’s _content_ must be delivered in a form suitable for reading as this Markdown file

## Specific Point Allocations
For this particular assignment, graded categories are as follows:

| Category | Points |
| -------- | -----: |
| _ideation.md_ | 30 points total |
| • Developed and workshopped in class | deduction only (if not fulfilled) |
| • Audiences | 5 points |
| • Ten (10) needs | 10 points |
| • Three (3) projects | 6 points |
| • Three (3) sets of goals/ideas | 6 points |
| • Project choice | 3 points |
| • Submitted by designated date | deduction only (if not fulfilled) |
| _pitch.md_ | 30 points total |
| • Inspiration statement | 10 points |
| • Possible solutions | 12 points |
| • Final app idea | 8 points |
| • Presented in class | deduction only (if not fulfilled) |
| • Submitted by designated date | deduction only (if not fulfilled) |
| _about.md_ | 50 points total |
| • Project title | 2 points |
| • Team names and roles | 8 points |
| • Audience and their needs | 10 points |
| • App screenshots/video/demo | 20 points |
| • Technology highlights | 10 points |
| • Credits where appropriate | deduction only (if not done) |
| • Presented successfully on finals week | deduction only (if not fulfilled) |
| Baseline functionality | 40 points total |
| • Third-party web service API | 15 points |
| • Authentication | 10 points |
| • Database | 15 points |
| Baseline code quality | 50 points total |
| This is a composite score indicating how successfully the code has:<br/>• Model objects<br/>• Abstraction of back-end functionality<br/>• Feedback for operations-in-progress<br/>• Error handling and messaging | |
| Design & usability | 50 points total |
| This is a composite score indicating how successfully the app demonstrates:<br/>• Layout and composition<br/>• Colors and other visuals<br/>• Proper choice of input views and controls<br/>• Well-chosen animations or transitions<br/>• Well-chosen programmed graphics<br/>• Custom app icon | |
| Hard-to-maintain or error-prone code | deduction only |
| Hard-to-read code | deduction only |
| Version control | deduction only |
| Punctuality | deduction only |
| **Total** | **250** |

### Due Date: May 08, 2026, 11:59 PM

Note that inability to compile and run any code to begin with will negatively affect other criteria, because if we can’t run your code, we can’t evaluate related remaining items completely.
