# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :idea do
    title "Happy Yoga Feet"
    content "<p>THIS is a line of products surrounding the Miswak, an ancient tooth-cleaning twig still used in several countries around the world. The collection starts with a carrying case designed to help Miswak-users cut and peel the bark around the stick on-the-go. We are also working on creating interchangeable caps that serve different purposes, like cleaning, cutting and softening the bristles.

THIS started off as a student project at the School of Visual Arts in NYC, but quickly gained a lot of interest from press and individuals around the world who were excited about a modernized version of this age-old tradition.

We're currently a small team working on revisiting the design of the original carrying case, coming up with new ideas for the line, and seeking out like-minded manufacturers and suppliers.

Looking forward to your feedback, and feel free to sign up for updates about the project here.</p>"
    votes 1
  end
end
