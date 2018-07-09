# README

### Who, What, Why, How?

This is a simple Rails API application that essentially acts as an intermediary between Slack and Zendesk to the smooth out the administrative task of updating a Zendesk ticket with a transcript for a specified Slack thread.

![gif of functionality](https://cl.ly/1P0A293g2n1P)

Why not copy/paste you say? Well, copying the thread text in one batch can "work" but the formatting it produces when attempting to paste into a Zendesk internal comment is very unfriendly for readability and would need major manual reformatting.  Copying and pasting each message individually would be no fun either :(

Use the "copy link" option from a context menu of a message in the thread you say? This can work but has some draw backs... the thread link will expire when the messages are archived so it won't work for preserving info inside the ticket, it is time consuming and annoying to both use the GUI to capture this link and then paste it into ZD, furthermore people who review the discussion have to be redirected from Zendesk back to their Slack app just to read the thread.  Also, having the thread text saved into the ticket as an internal comment makes its content searchable when looking through cases for related subject matter.

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

![slack app features](https://cl.ly/1c0M3D032p1B)

Choose to "create a command" and enter `/zd` as the command with your applications host path as the request URL:

![configure slash command](https://cl.ly/331m2Q3X1a0l)

Back under the "add features and functionality" section, generate your authentication token in the "Permissions" features section:

![generate token](https://cl.ly/0L2r3Z1l1n3a)

Set the token as your hosts `SLACK_TOKEN` environment variable.

Now you should be able to use the `/zd <ticketnumber>` command to send a thread containing a message "zd ticketnumber".

Done!
