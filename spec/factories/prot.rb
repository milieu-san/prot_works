FactoryBot.define do
  factory :prot do
    title { 'タイトル1' }
    content { 'コンテント1' }
    private { false }
    accepts_review { true }
    association :user, factory: :user, name: 'taro'
  end

  factory :second_prot, class: Prot do
    title { 'タイトル2' }
    content { 'コンテント2' }
    private { true }
    accepts_review { true }
  end

  factory :third_prot, class: Prot do
    title { 'タイトル3' }
    content { 'コンテント3' }
    private { false }
    accepts_review { false }
  end
end
