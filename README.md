

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
   <li> <a href="#enhance">Enhancements</a></li>
<li><a href="#changes">Change Log</a></li>
  </ol>
</details>
<br><hr id="version">

## Version Requirements

<div id="version">
  
* Ruby 3.2.0
  
* Rails 7.0.4.1
  
</div>
<hr> 

## Setup

<div id="new">
  
### New Projects

1. Use template to create a new repo
   
2. Open in your IDE
3. Delete credentials.yml.enc
4. run EDITOR="code --wait" bin/rails credentials:edit
    * This will create a new master.key and new credentials.yml.enc
      * WINDOWS USERS RUN:
            - EDITOR=“nano” bin/rails credentials:edit
    
5. Put in all environment variables below
    * all are needed, use place holders for time being and edit as you go
    
6. Edit this ReadME for your new project! to get rid of all this un needed information, you can keep the Existing project section if you like
</div>

<div id="existing">
  
### Existing Project

1. master.key already exist
    * Obtain master.key 
      *from your team lead if you do  not have access 
          
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

    swagger:
        username: 'username'
        password: 'password'

## Access Rails Environment Variables

    EDITOR="code --wait" bin/rails credentials:edit

If this is a new project use the above command. Copy the above Environment Variables and set appropriately. Make sure the master key generated in master.key is copied over to the 
project on Heroku, if not Heroku can not decrypt the environment variables. If this is not a new project, before running
the above command make sure you have the master key copied from Heroku, and/or speak with your Team Lead to set the project
up correctly.
</div>

<hr>

<div id="general">

## API Documentation

We are using swagger for API Documentaion. By default only the localhost server is setup. Going into swagger_helper to setup the production & staging urls

API documentation is available at `/api-docs` and is protected by basic auth. The username and password are set in the environment variables.


## Test Suite

You can run the test suite by calling `rspec`. This project uses RSpec for controller tests through swagger.

## Background Processing

This project comes with Sidekiq and Sidekiq scheduler built-in as gems. Sidekiq leverages Redis, and Redis is provided as a gem. When running the application, you'll need to run Sidekiq alongside the normal Rails server in order for the background processing to work locally.

You may want to look into utilizing something like Foreman to turn on and off all of your services at once. Otherwise, you can start Sidekiq in a new terminal by running `bundle exec sidekiq`.
</div>
<hr>

<div id="enhance">
      
## Enhancements
      
      
In the root directory there is now a credentials.rb file. Using:

`ruby credentials.rb`

The file will run allowing you to select an editor to edit rails credentials with.
<ol>
<li>You need to have master key already set in the project correctly</li>
<li>The script will need to be updated to match your credential layout</li>
<li>Make sure to have options for both VSCode & RubyMine</li>
<li>This only works on Macs</li>
</ol>

</div>
<hr>
<div id="changes">

## Coming Soon

Nothing on the horizon right now, if you can think of a feature that should be in the baseAPI, speak up! - [Lee](https://github.com/leehodges) :shipit:


## Changes
~~11/23 - Whitelisted local host and .ngrok - [Lee](https://github.com/leehodges) :shipit:~~
~~03/15/22 - Updated for Rails 7  - [Lee](https://github.com/leehodges) :shipit:~~
~~03/15/22 - Added script to easily access credentials - [Lee](https://github.com/leehodges) :shipit:~~
      <ul>
            <li>01/25/23 - Updated for Rails 7.0.4.1  - [Lee](https://github.com/leehodges) :shipit:</li>
            <li>01/25/22 - Upated for Ruby 3.2.0 - [Lee](https://github.com/leehodges) :shipit:</li>
            <li>01/25/22 - Add rswag gems - [Lee](https://github.com/leehodges) :shipit:</li>
            <li>01/25/22 - Add rswag docs - [Lee](https://github.com/leehodges) :shipit:</li>
            <li>01/25/22 - Add rspec testing - [Lee](https://github.com/leehodges) :shipit:</li>
      </ul>
</div>
<hr>
