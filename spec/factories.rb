Factory.define :user do |user|
  user.name                  "Michael Hartl"
  user.email                 "mhartl@example.com"
  user.password              "foobar"
end

Factory.define :email_account do |email_account|
  email_account.association :user
  email_account.email        "ButuzGOL@mail.com"
  email_account.password     "welcome777"
end