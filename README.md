# README

### Who, What, Why, How?

This is a simple Rails API application that essentially acts as an intermediary between Slack and Zendesk to the smooth out the administrative task of updating a Zendesk ticket with a transcript for a specified Slack thread.

![gif of functionality](https://dha4w82d62smt.cloudfront.net/items/2F3P1r1K3O3d3u0V2O08/Screen%20Recording%202018-04-29%20at%2006.12%20PM.gif?X-CloudApp-Visitor-Id=2889026&v=21ab20d0)

Why not copy/paste you say? Well, copying the thread text in one batch can "work" but the formatting it produces when attempting to paste into a Zendesk internal comment is very unfriendly for readability and would need major manual reformatting.  Copying and pasting each message individually would be no fun either :(

Use the "copy link" option from a context menu of a message in the thread you say? This can work but has some draw backs... 
![gif of functionality](https://dha4w82d62smt.cloudfront.net/items/2B0Z3C2o261o0l1P2m1f/Image%202018-05-27%20at%206.20.05%20PM.png?X-CloudApp-Visitor-Id=2889026&v=6190bbfe)

The thread link will expire when the messages are archived so it won't work for preserving info inside the ticket, it is time consuming and annoying to both use the GUI to capture this link and then paste it into ZD, furthermore people who review the discussion have to be redirected from Zendesk back to their Slack app just to read the thread.  Also, having the thread text saved into the ticket as an internal comment makes its content searchable when looking through cases for related subject matter.

** Deployment instructions **

This is essentially middleware so it needs to be hosted with the Rails server running to listen for slash command messages from a Slack account and then send them to Zendesk.

It is built with:

Ruby version: 2.5.0

Rails version: 5.1.6

The application is configured to handle Slack and Zendesk authentication via environment variables on the host.  Set the values of the following variables:

```
SLACK_TOKEN = <generated on "install" of app via Slack account>
ZD_EMAIL = <admin email for zd account access>
ZD_PASS = <corresponding password>
```

To run the application download this repository to your host and, from inside the project directory, run:

```
# install dependencies based on gemfile
bundle install

#run the rails server
rails s
```

To "install" the application as a "Slack app" visit here and select the "Create a Slack app" button:

https://api.slack.com/slack-apps

Name the app, select the workspace where you wish to use it, please **DO NOT LIST THIS APP IN THE SLACK APP DIRECTORY** since you are not the creator.

Once the app is created in Slack, access the features and functionality section to enable slash commands:

![slack app features](https://dha4w82d62smt.cloudfront.net/items/172h371u3N293u2h1F0F/Image%202018-07-08%20at%206.11.31%20PM.png?X-CloudApp-Visitor-Id=2889026&v=dc9817ec)

Choose to "create a command" and enter `/zd` as the command with your applications host path as the request URL:

![configure slash command](https://dha4w82d62smt.cloudfront.net/items/143I3C2r2P0c2Q3N0u0R/%5Be5152b62f4329990e6544c8f211a3ab7%5D_Image+2018-07-08+at+9.44.35+PM.png?X-CloudApp-Visitor-Id=2889026&v=d49f89e5)

Back under the "add features and functionality" section, generate your authentication token in the "Permissions" features section:

![generate token](https://dha4w82d62smt.cloudfront.net/items/2z3W2N0m1g3d3u3v1s3M/%5B436e0dc01aed5280f051237bf0474f3b%5D_Image+2018-07-08+at+11.05.38+PM.png?X-CloudApp-Visitor-Id=2889026&v=e460e0b4)

Set the token as your hosts `SLACK_TOKEN` environment variable.

Now you should be able to use the `/zd <ticketnumber>` command to send a thread containing a message "zd ticketnumber".

Done!
