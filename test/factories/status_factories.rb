FactoryBot.define do
  factory :status do
    message { Status::GREEN_MESSAGE }
    level { "green" }
  end
end
