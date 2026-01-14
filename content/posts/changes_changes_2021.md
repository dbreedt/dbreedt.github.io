---
title: "Changes, Changes everywhere"
date: 2021-08-19
draft: false
author: "Derik"
categories: ["Engineering"]
tags: ["DevOps", "Agile", "Software Development", "Cloud"]
---

An adage goes: “*The more things change, the more they stay the same*” — that kind of holds true for Software Development.

Back in the day, we used to design our systems, write the code, compile it, run it, get it tested and then deploy it. We still do all of that today, regardless of what we are building, be it microservices, large scale monolith systems, mobile apps, websites or firmware for IOT things.

So nothing has changed, okay cheers, 10 minute read my ass. Not so fast; a lot indeed has changed, albeit under the hood of those old school development pillars.

Some of the things that have changed are:

* How we safeguard the code
* Where the code is executed
* How the code is built and moved
* How we plan
* How we manage to burnout developers faster
* How we care about the code we write

## How we safeguard the code

Many, many different ways exist to version control your code; the following is a list of things that I have experienced and that I don’t recommend you try:

* A shared folder contains all source files
* Everyone has an offline copy
* Visual Source Safe on a shared folder
* StarTeam
* TFS over VSS
* TFS before they adopted git
* CVS
* Subversion in large teams
* Google Drive folder with change tracking

Source control is, and probably will always be, an issue — until everyone wakes up and accepts that git is the only free version control you will probably ever need. I state this on the premise that you are tracking changes in standard human-readable programming language source files, not large ML data sets, and that you don’t store all your source code in a single repository. I’m looking at you, [Google](https://cacm.acm.org/magazines/2016/7/204032-why-google-stores-billions-of-lines-of-code-in-a-single-repository/fulltext).

I’m glad to report that I have not experienced any source code not stored in some flavour of git in the past ten years, so it appears that the world is waking up to decent free version control.

Along with the adoption of git came all the cloud-based git offerings — with GitHub being the biggest and most famous of them. With this git in the cloud business, developers can work from anywhere; they don’t need to be in the office or have VPN access. They can work from where and when they want and how they want. Finally, coding half-naked, eating Cheetos on your couch while watching Sam & Max can be a thing — if that is what you are into.

## Where the code is executed

Back in the day, we had to guess specifications for a physical server, and we had to care about the CPU, RAM, HDDs and even the Network cards. This server often sat at the customer’s premises running on their infrastructure with their BOFH’s controlling it. If you wrote okay code and your Systems Architect, the guy that specced the server, knew their stuff, the post-prod deployment was a nice place to be. 🤣🤣🤣 That seldom happened! Either the server was too small, the interwebs feeding the server was too small, the raid controller sucked, the code sucked etc. Anything that required more infrastructure (server, network, switches, internet bandwidth) had massive lead times. Getting a new server normally took 6+weeks. So the only way to fix the epic levels of suckitude was to run the following code in a loop for a couple of weeks:

```javascript
for(customer.Cry()) { 
    team.Optimize();
}
```

Most of the code we write nowadays runs in the cloud. The cloud is just a Hardware Abstraction Layer; you know you want 1vCPU and 2GB of RAM, and you have stopped caring if it runs a Xeon, Epyc, ECC Memory, Optane SSD, SATA, SCSI or SAS. All the specifics are now gone. If it sucks, stop the instance, change the instance type, start it up again, rinse and repeat. Rinsing and repeating is not the answer to every prod problem; sometimes, the code is so wrong that throwing more hardware at it won’t make it better, and you still have to go back to the optimise loop described above.

An even more significant benefit to executing the code in the cloud is the capability of having distributed development teams. These teams can all have a development and staging environment running the latest code change you pushed five minutes ago, without every UI developer needing to pull the newest backend changes, compiling and running them locally. Having distributed development teams means that teams collaborate better and faster. When you find a bug in UI or backend, you can raise it immediately before the dev moves to the next ticket in the backlog. I’m aware this model doesn’t work for all types of development, but it has done wonders for web and mobile app development to speed up development.

## How the code is built and moved

A senior developer used to compile the code in Release mode with optimisations tuned to the production server’s CPU and architecture, zip the binaries, copy the archive to a network folder and finally ssh or RDP into the production environment and manually perform the release. Since this process is prone to hit-by-a-bus failure, a new buzzword-filled section in software development was born. It is called DevOps and basically, what this entails is that an automated process builds, tests, packages and even deploys it. There are so many different tools to cater for almost all your needs; you can build on an on-prem server and deploy on-prem or build in the cloud and deploy wherever you want; the options are only limited to your imagination. The main drive behind this is to remove the hit-by-a-bus risk and, more importantly, increase the speed at which you can get new/fixed code into an environment.

This field is not without its problems; if you build in the cloud and Azure DevOps, GitHub Actions, or AWS is experiencing an outage, you can become stuck with no option to deploy your code until the outage is restored.

The other, more critical, problem with DevOps, in general, is security. Yup, you take company IP and move it into a non-company controlled infrastructure optionally using sensitive data (config, keys, connection strings etc.) to perform the testing, building and deployments. Security is such a significant oversight that big consulting houses are called upon to perform DevSecOps audits.

Probably the most impactful change DevOps has brought to the table, besides making some snowflake god-complex devs obsolete, is the exponential increase in unit/integration tests adopted by dev teams. To have confidence that the new code won’t break the perfectly working system, we write tests. These tests are executed as part of the DevOps pipeline. Only if these tests pass successfully are the built artefacts distributed. If the built artefacts are buggy as hell, developers *WILL ENHANCE* the test suite with more tests and the process repeats. We have come to a point where standard tests written by humans aren’t good enough for some people, and then they introduce chaos during testing, using fuzzers (see [sharpfuzz](https://github.com/Metalnem/sharpfuzz) and [gofuzz](https://github.com/google/gofuzz)). Introducing chaos during testing should not be confused with chaos engineering, which is something way more fun.

I have stopped counting the number of times tests have saved my new yet retarded code from destroying a perfectly working system. I don’t wonder if tests are worth it; I know they are, and I continue writing more. I have changed my attitude towards bug fixing from one of finding, fixing and manual testing to one of writing a test to verify the bug and then changing the code until the test passes.

This shift to automated testing has caused testing teams to be smaller and more efficient; however, it has caused some of them to lose their jobs. They will probably point and laugh at us when GitHub Copilot puts us out of a job.

## How we plan

In my experience, a Project Manager usually gets assigned the task of making developers build a poorly scoped system based on very bad thumb-sucked estimations and flawed assumptions. Waterfall, how I don’t miss thee.

Unfortunately, the PM role still exists, but fortunately, the devs have revolted and demanded that we want more realistic thumb-sucks. Developers’ demands for better estimations resulted in the birth of Agile and Agile-like methodologies that conned the PM into believing that smaller usable deliverables every fortnight will deliver the final product faster.

However, this has forced devs to be more conscious about the planning process. Don’t think that Agile has solved the devs-are-lazy-af problem for one minute. I have on numerous occasions seen senior devs lying, saying something will take them four hours to do when in fact, that same thing will take a greenhorn thirty minutes to do correctly. I feel the shift to Agile-like methodologies has made devs more pedantic about how they break down and scope large complex tasks. By reviewing the work at the end of the sprint to see what was scoped correctly or incorrectly and learning from that, it creates a positive feedback cycle that helps the dev become more reliable, accountable and even better at scoping.

Agile is a double-edged sword that takes care of inaccurate estimations and causes costs to align with actual effort. All roleplayers now have a better understanding of what they are getting themselves into beforehand and throughout. By no means has Agile methodologies made the estimates 100% accurate; they are mostly still off by some margin, but it is better than what it was.

## How we manage to burnout developers faster

The same tools we conned the PMs into using are also the cause for a steady increase in dev burnout. With Agile methodologies came a relentless pressure to deliver. The biggest culprit in the Agile world for this burnout is Sprints, and the clue to this burnout is in the name. A project comprises of N Sprints of Q weeks each. A Sprint starts typically on a Monday and ends Q weeks later on the Friday with a technical demo, Sprint planning and maybe a retrospective. That is, if there are no production bugs or testing bugs or unforeseen outages. All this pressure continues week after week, with no downtime, unless you go on leave or the project ends, where the whole process starts over again.

In toxic/unforgiving environments where the PM demands that you deliver on promised tasks each sprint, devs work longer and longer hours. Developers are punished for either bad planning, scoping or bugs they made in previous sprints. When under pressure, developers introduce even more bugs because they are overworked and burning out. To me, this scenario sounds very similar to thermal runaway.

In the days of the Waterfall SDLC, once development was completed, the project entered a lengthy testing period. Planning and design for new components scheduled for the next release cycle happened in this testing period. Now and again, developers would be interrupted by bugs found during testing, but in general, this time was stress-free and allowed developers to recharge.

## How we care about the code we write

In the past, only people with a bone to pick ran static code analysis tools and told you that some part of the system you wrote had a Cyclomatic complexity greater than 25 or that the Coupling was too high. Great, those things are “important”, but you only knew about them when someone actively chose to perform those checks.

More than ever before, we now have to care more about the quality of the code that we write. Not a single week goes by without reading about a company that has been hacked or had a data leak. And 9.999 out of 10 times, the primary cause for this is shitty code written by a dev that swears his code was peer-reviewed, that the snippet on StackOverflow had 2000+ upvotes and posted by none other than Jon Skeet.

These days, we have many tools at our disposal to help us find and address these things while we develop the code (okay, not coupling and cohesion; experience and SOLID design principles are the only fixes for those). The many tools at our disposal are, to name but a few: linters, automatic code analysers (C#’s Roslyn Compiler), exceptional race detection in Go, GitHub’s security advisories, GitHub’s dependabot and tools like SonarQube. All these tools, that are primarily free, are helping devs write better and safer code. Because these tools constantly update, code that was fine yesterday can be flagged as vulnerable today due to some buffer overflow exploit in a 3rd party library that you are using. You can choose to act on it or ignore it, but the power is in your hands. I have been on the receiving end of a couple of scathing penetration testing reports in my days. Still, since the advent of most of the tools listed above in the projects I have been part of, I no longer dread penetration tests. I welcome them. These tools are not pointing out my shitty code; they highlight weaknesses in the system, like misconfigured gateways, etc.

The Open-source movement has also caused developers to care more about the quality of their code. Making one’s code publicly visible is a vulnerable thing to do. Other people look at it and at times ridicule 🤣🤣🤣 you thought I might say admire. Though it might be hard to do, posting code publically builds a community that care about similar things together to make even bigger and better things. And who benefits from this collaboration? Everyone! Previously most things were closed-sourced and required a license; developers added features slower than humanity has added landers on Mars, and bugs were only fixed if enough people complained.

So don’t be that guy that hides all his code in private repos on bitbucket, because of GPT-3. Take the leap and make your code public, share it with others. The worst thing that can happen is that someone will make a PR to correct your bad spelling. I don’t believe that it is my fault my alter ego is Typo Man!, the writer of wrongs.
