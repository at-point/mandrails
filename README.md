# Mandrails - The Mandrill/ActionMailer connector

A delivery method implementation which uses the Mandrill REST API. This allows
to simply send e-mails from a Rails app using Mandrill instead of SMTP or
sendmail.

### Open items

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

Thanks to the team at [Mailchimp][mc] which provides the [mandrill-api gem][gem]
and of course the [Mandrill service][ma] itself. FYI - the maintainers of this
gem are in no way affiliated with Mailchimp or Mandrill.

## License

MIT License. Copyright 2013 at-point ag. http://at-point.ch

[mc]: http://mailchimp.com/
[gem]: https://bitbucket.org/mailchimp/mandrill-api-ruby/
[ma]: https://mandrillapp.com/
