# Engelhilf

A simple web application for tracking helpdesk requests.  Allows communication between admins and users via comments on each ticket, tracks urgency levels for tickets, and allows filtering by urgency level and whether a ticket is closed or not.

## Setup
1. Clone this repository.
2. Run `bundle install` and `rails db:migrate` from the command line.
3. Open db/seeds.rb, look for the line that begins with `User.create!`, and fill in an administrator username, email address and password inside the quotation marks.
4. Run `rails db:seed` in your console.  This creates the initial administrator account.