class Question
  attr_accessor :prompt, :answer

  def initialize(prompt, answer)
    @prompt = prompt
    @answer = answer
  end
end


p1 = "\n\n ========== Select an IDE ========= \n\n 1. VsCode \n 2. RubyMine \n 3. Exit \n\n ==================================\n\n \n\n Compatibility: Mac OS Only - sorry Windows/Linux folks \n\n"

@questions = [
  Question.new(p1, '')
]

def run_cred(questions)
  answer = ''

  prompt_2 = [
    Question.new("\n\n ========== Select Environment for Vs Code ========= \n\n 1. Development \n 2. Staging \n 3. Production \n 4. No Environment \n 5. Test \n 6. start over \n 7. Exit \n\n ===================================================\n\n", ''),
  ]
  prompt_3 = [
    Question.new("\n\n ========== Select Environment for RubyMine ========= \n\n 1. Development \n 2. Staging \n 3. Production \n 4. No Environment \n 5. Test \n 6. start over \n 7. Exit \n\n ==================================================\n\n", '')
  ]

  questions.each do |question|
    puts question.prompt
    answer = gets.chomp
    case answer
    when '1'
      env_select_vs_code(prompt_2)
    when '2'
      env_select_rubymine(prompt_3)
    when '3'
      puts 'cool, thanks for wasting my neuro net processing power, cya'
      exit
    else
      puts 'cool, thanks for wasting my neuro net processing power, cya'
      exit
    end
  end
end

def env_select_vs_code(questions)
  questions.each do |question|
    puts question.prompt
    answer = gets.chomp
    case answer
    when '1'
      `EDITOR="code --wait" rails credentials:edit --environment development`
    when '2'
      `EDITOR="code --wait" rails credentials:edit --environment staging`
    when '3'
      `EDITOR="code --wait" rails credentials:edit --environment production`
    when '4'
      `EDITOR="code --wait" rails credentials:edit`
    when '5'
      `EDITOR="code --wait" rails credentials:edit --environment test`
    when '6'
      run_cred(@questions)
    else
      puts 'cool, thanks for wasting my neuro net processing power, cya'
      exit
    end
  end
end

def env_select_rubymine(questions)
  questions.each do |question|
    puts question.prompt
    answer = gets.chomp
    case answer
    when '1'
      `EDITOR="/Applications/RubyMine.app/Contents/MacOS/rubymine --wait" rails credentials:edit --environment development`
    when '2'
      `EDITOR="/Applications/RubyMine.app/Contents/MacOS/rubymine --wait" rails credentials:edit --environment staging`
    when '3'
      `EDITOR="/Applications/RubyMine.app/Contents/MacOS/rubymine --wait" rails credentials:edit --environment production`
    when '4'
      `EDITOR="/Applications/RubyMine.app/Contents/MacOS/rubymine --wait" rails credentials:edit`
    when '5'
      `EDITOR="/Applications/RubyMine.app/Contents/MacOS/rubymine --wait" rails credentials:edit --environment test`
    when '6'
      run_cred(@questions)
    else
      puts 'cool, thanks for wasting my neuro net processing power, cya'
    end

  end
end

run_cred(@questions)
