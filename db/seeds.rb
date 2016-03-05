# Create admin user
admin = User.find_or_create_by!(email: 'admin@alexakids.com') do |user|
  user.name = 'Admin user'
  user.password = 'abcd1234'
  user.password_confirmation = 'abcd1234'
  user.role = :admin
end

# Create player user
player = User.find_or_create_by!(email: 'player@alexakids.com') do |user|
  user.name = 'Player user'
  user.password = 'abcd1234'
  user.password_confirmation = 'abcd1234'
  user.role = :player
end

# Create owner user
owner = User.find_or_create_by!(email: 'owner@alexakids.com') do |user|
  user.name = 'Doctor user'
  user.password = 'abcd1234'
  user.password_confirmation = 'abcd1234'
  user.role = :owner
end

# Create game
game = Game.where(
  problem: 'Back problem',
  owner_id: owner.id,
).first_or_create

#Create game questions
QUESTION_1 = 'On a scale from 1 to 10 how bad is your back today?'
QUESTION_2 = 'Could you tell more details about your feelings?'
QUESTION_3 = 'On a scale from 1 to 10 how was your sleep last night?'

question_1 = game.questions.find_or_create_by(question: QUESTION_1) do |q|
  q.low_threshold = 3,
  q.high_threshold = 8,
  q.number!
end

question_2 = game.questions.find_or_create_by(question: QUESTION_2) do |q|
  q.risky_keywords = ['a lot', 'hurts', 'bad']
  q.string!
end

question_3 = game.questions.find_or_create_by(question: QUESTION_3) do |q|
  q.low_threshold =  2,
  q.high_threshold =  7,
  q.number!
end

date_range = ((Date.today - 14)..Date.today)
rating_scale = *(1..10)

answers =  [
  'Today I feel bad and I need to take painkillers.',
  'I feel better than yesterday but still need some painkillers to sleep.',
  'Today I fell worse than yesterday, my back hurts me very much.',
  'I think medicaments started to work, I feel better than before but still taking painkillers.',
  'I feel much better that before, I forgot about painkillers',
  'Yesterday I started my first training and back hurts me again, I need to take painkillers again.',
  'I feel very bad, back hurts me the most when I lie in bed.',
  'I feel better than yesteday, but still need to take painkillers.',
  'I feel much better than before but I still need to take painkillers.',
  'I feel better and I use painkillers only when I want to sleep',
  'I feel great, I stopped using painkillers.',
  'I feel very good, my back does not hurt.',
  'I make my first training again, back does not hurt and I feel great.',
  'I make my trainings like usual and I feel great.',
  'I feel very good.'
]

# Create an answers for questions
date_range.each_with_index do |date, index|
  question_1.answers.create(
    answer: rating_scale.sample,
    created_at: date
  )

  answer = question_2.answers.create(
    answer: answers[index],
    created_at: date
  )

  answer.create_alchemy!(FetchAlchemyKeywordsAndSentimentService.new.call(answer))

  question_3.answers.create(
    answer: rating_scale.sample,
    created_at: date
  )
end
