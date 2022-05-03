# iOS Onboarding

Hey, welcome! If you're reading this, you're a new part of the iOS team, congrats!

Below, you can find a list of tasks that you will need to complete in order to finish your onboarding. Don't worry though, feel free to ask anyone in the team for help at any time.

## Onboarding

### 0. Setup

Before you start, just make sure you have your workplace set up for work. [Our handbook](https://handbook.infinum.co/books/ios) might be a good place to start. You might need to log in before you can see it.

We expect you to be familiar with the handbook material, but no need to read it page from page.

#### Links

https://handbook.infinum.co/books/ios

### 1. Master you Git (Optional)

In Infinum we use Git (and Github) for version control. If you are not familiar with basic Git shell commands and how to push to Github, we would recommend you download [Git-it](https://github.com/jlord/git-it-electron), a desktop app for learning Git and GitHub.   
To truly start mastering Git we urge you to solve all the exercises from https://learngitbranching.js.org/

In case that you're already fluent with Git and know your way around, feel free to skip this step.

### 2. Getting to know VIPER 🐍

Let's dive in. The entire onboarding process revolves around our training app (which you might have seen already) - [TV Shows](https://github.com/infinum/iOS-tv-shows-assignment). Your assignment is to write the app using our own [VIPER](https://github.com/infinum/iOS-VIPER-Xcode-Templates) architecture. If you've already written the app without using VIPER, then your job will be to rewrite that into VIPER. Sounds good? Great!

Before jumping right into it please install the templates for Xcode. Once you do that, Xcode will allow you to create a new module via new file menu.

#### Links

https://github.com/infinum/iOS-VIPER-Xcode-Templates

https://github.com/infinum/iOS-tv-shows-assignment

### 3. RxSwift

If you haven't heard of reactive programming, you're in for a treat. Although it might look intimidating on the first look, once you get familiar with reactive way of solving issues, you'll never want to look back. There are two major frameworks for reactive on iOS [RxSwift](https://github.com/ReactiveX/RxSwift) and [ReactiveSwift](https://github.com/ReactiveCocoa/ReactiveSwift/). We settled on RxSwift.

To get you started, we developed a workshop over here: 

https://github.com/infinum/iOS-RxWorkshop-2019

Each lecture consists of a lecture (keynote + video) and some homework. Your assignment is to finish the workshop. Good luck, and don't forget, we're here if you get stuck!

### 5. Puting it all together

By now, you will be vaguely familiar with both **VIPER** and **RxSwift**. Don't worry, it's ok if you aren't completely comfortable with either yet. Your assignment is to rewrite the networking part and one module to use RxSwift. We suggest refactoring the list of the shows.

Rewrite the networking to make use of the _Single trait_. 

Rewrite the show list to make use of _Driver and Observable traits_.

Of course, if you need any help, just ask anyone around you. Good luck!
