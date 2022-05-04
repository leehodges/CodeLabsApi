

      ___  __  ____  ____  ____  __    ____   __   ____  ____     __   ____  __  
     / __)/  \(    \(  __)(  __)(  )  (  _ \ / _\ / ___)(  __)   / _\ (  _ \(  )
    ( (__(  O )) D ( ) _)  ) _)  )(    ) _ (/    \\___ \ ) _)   /    \ ) __/ )(  
     \___)\__/(____/(____)(__)  (__)  (____/\_/\_/(____/(____)  \_/\_/(__)  (__)

<hr>

<br>
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li><a href="#version">Requirements</a></li>
        <li><a href="#setup">Setup</a></li>
            <ol>
                <li><a href="#new">New Project</a></li>
                <li><a href="#existing">Existing Project</a></li>
            </ol>
    <li><a href="#environment">Environment Variables</a></li>
    <li><a href="#general">General Information</a></li>
<li><a href="#changes">Change Log</a></li>
  </ol>
</details>
<br><hr id="version">

## Version Requirements

<div id="version">
  
* Ruby 3.0.2
  
* Rails 6.1.4
  
</div>
<hr> 

## Setup

<div id="new">
  
### New Projects

1. Use template to create a new repo
   
2. Open in your IDE
3. run EDITOR="code --wait" bin/rails credentials:edit
    * This will create a new master.key and new credentials.yml.enc
    
4. Put in all environment variables below
    * all are needed, use place holders for time being and edit as you go
    
5. Edit this ReadME for your new project! to get rid of all this un needed information, you can keep the Existing project section if you like
</div>

<div id="existing">
  
### Existing Project

1. master.key already exist
    * Obtain master.key from Heroku
        * Or from your team lead if you do  not have access 
          
2. Paste the master.key from your team lead/heroku and save
3. run EDITOR="code --wait" bin/rails credentials:edit
    * If it opens you are good to go
    * If not, your master.key is wrong
        * Check with your team lead
        * Do not attempt to generate a new master.key
    
  </div>  
<hr>

<div id="environment">

## Environment Variables

    invitation:
         url: 'https://urlhere'

    twilio:
        default_number: '555-555-5555'
        account_sid: 'sid_here'
        auth_token: 'auth_token'

    sendgrid:
        default_email: 'fillthisout@email.com'
        domain: 'domain.com'
        address: 'smtp.sendgrid.net'
        username: 'apikey' #apikey actually is the username to authenticate with api secret token below
        password: 'api_token'

    sidekiq:
        auth_username: 'username'
        auth_password: 'password'

    workers:
        max_threads: #
        min_threads: #

## Access Rails Environment Variables

    EDITOR="code --wait" bin/rails credentials:edit

If this is a new project use the above command. Copy the above Environment Variables and set appropriately. Make sure the master key generated in master.key is copied over to the 
project on Heroku, if not Heroku can not decrypt the environment variables. If this is not a new project, before running
the above command make sure you have the master key copied from Heroku, and/or speak with your Team Lead to set the project
up correctly.
</div>

<hr>

<div id="general">

## Test Suite

You can run the test suite by calling `rails test`. This project uses MiniTest.

## Background Processing

This project comes with Sidekiq and Sidekiq scheduler built-in as gems. Sidekiq leverages Redis, and Redis is provided as a gem. When running the application, you'll need to run Sidekiq alongside the normal Rails server in order for the background processing to work locally.

You may want to look into utilizing something like Foreman to turn on and off all of your services at once. Otherwise, you can start Sidekiq in a new terminal by running `bundle exec sidekiq`.
</div>
<hr>

<div id="changes">

## Coming Soon

Rails 7 stable is almost ready for release in the upcoming months this template will be upgraded to Rails 7. Documentation will be provided with changes/features made on the transition. 

## Changes
11/23 - Whitelisted local host and .ngrok -Lee
</div>
<hr>
