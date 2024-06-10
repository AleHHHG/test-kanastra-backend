FactoryBot.define do
  factory :billing do
    name { 'Name' }
    document { '13991' }
    email { 'email@teste.com' }
    amount { 1_000 }
    due_date { Date.current }
    uuid { SecureRandom.hex(10) }
    sent { false }
  end
end
