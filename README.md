# Mandrails - The Mandrill/ActionMailer connector

A delivery method implementation which uses the Mandrill REST API. This allows
to simply send e-mails from a Rails app using Mandrill instead of SMTP or
sendmail.

Currently this gem is in alpha quality, things we are still working:

- [ ] Implement Railtie which automatically hooks delivery method into AM
- [ ] Attachment support for image/* and application/pdf (Mandrill API restriction)
- [ ] Support for custom `X-` headers
- [ ] Ability to override Mandrill settings, e.g. click tracking, per mail
- [ ] Improve test cases :)

## Installation

Add mandrails to your Gemfile and run `bundle` afterwards:

```ruby
    gem 'mandrails'
```

## Usage

TODO: Write usage instructions here

## Additional information

### Mailchimp & Mandrill

Thanks to the team at [Mailchimp][1] which provides the [mandrill-api gem][2]
and of course the [Mandrill service][3] itself. FYI - the maintainers of this
gem are in no way affiliated with Mailchimp or Mandrill.

## License

MIT License. Copyright 2013 at-point ag. http://at-point.ch

[1] http://mailchimp.com/
[2] https://bitbucket.org/mailchimp/mandrill-api-ruby/
[3] https://mandrillapp.com/
