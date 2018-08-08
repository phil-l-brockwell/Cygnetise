# frozen_string_literal: true

FactoryBot.define do
  factory :vote do
    validity :during
    choice :Spiderman
    association :campaign, factory: :campaign

    trait :invalid do
      validity :pre
    end
  end
end
