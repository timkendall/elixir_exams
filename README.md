# WiMF

This is a small app I made to learn Elixir and the Phoenix framework. It works by
using [Twilio](https://www.twilio.com/) to receive SMS messages and match against
a database of course ID's to text back when the final is.

The project also includes a barebones webapp served at `/dashboard`. This app
demonstrates basic CRUD operations by providing a minimal UI for adding final exam times.
It also demonstrates [Phoenix's awesome Channels](http://www.phoenixframework.org/docs/channels) with a live feed of incoming
SMS messages.

I had a lot of fun with this project and look forward to using Elixir/Phoenix in
more of my projects!

## TODO

- [x] Create `/exam_times` endpoints
- [ ] Exam time matching and response logic
- [ ] Create simple CRUD management console at `/dashboard`
- [ ] Dockerize

## Running

Make sure you have Elixir, Node.js, and Postgres installed.

1. Install dependencies with `mix deps.get`
2. Create and migrate your database with `mix ecto.create && mix ecto.migrate`
3. Start application with `mix phoenix.server`

To be able to accept SMS messages locally you will need to use [ngrok](https://ngrok.com/)
or a similar service. Once you have your tunnel setup you can [setup that URL as the
webhook destination for Twilio](https://www.twilio.com/docs/quickstart/php/sms/hello-monkey).

## Deploying

TODO
