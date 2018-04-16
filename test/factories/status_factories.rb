FactoryBot.define do
  factory :status do
    message { Status::GREEN_MESSAGE }
    level { "green" }

    factory :yellow_status do
      message { Status::YELLOW_MESSAGE }
      level { "yellow" }
    end

    factory :red_status do
      message { Status::RED_MESSAGE }
      level { "red" }
    end
  end
end
