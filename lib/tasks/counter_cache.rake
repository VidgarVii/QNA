desc 'Counter cache for question has many answers'

task answer_counter: :environment do
  Question.reset_column_information
  Question.find_each do |question|
    Question.reset_counters question.id, :answers
  end
end
