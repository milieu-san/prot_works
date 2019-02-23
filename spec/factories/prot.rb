FactoryBot.define do
  factory :prot do
    title { 'タイトル１' }
    content { 'コンテント１' }
    association :user, factory: :user, name: 'john'
  end

  factory :second_task, class: Task do
    title { 'タイトル２' }
    content { 'コンテント２' }
  end
end
