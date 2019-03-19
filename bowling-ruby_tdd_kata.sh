set -o nounset                        # unset variables are errors

__ScriptVersion="2018.02.19"
__ScriptName="bowling-ruby_tdd_kata-Debian.sh"
__ScriptFullName="$0"

if [ -d $HOME/.rvm ]; then
  echo "RVM /w Ruby is already installed on your machine."
else  
  echo "********************** RVM & RUBY INSTALL ************************"
  echo "RVM /w Ruby is not installed."
  echo "You may be prompted for root credentials to complete the install."
  echo "******************************************************************"
  
  sudo bash -c "apt update && apt upgrade -y"
  
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
  curl -sSL https://get.rvm.io | bash -s stable --ruby
  
  echo -e "source $HOME/.rvm/scripts/rvm " >> ~/.bashrc 
  source $HOME/.rvm/scripts/rvm
  
  gem install bundler  
  
  sudo bash -c "apt autoremove && apt clean -y"
fi

# Focus on the initial spec.  Implement the simplest code to make the test pass. Once test passes, refactor the code to simplify. 
# Here are the specs:
# 1) Scoring basics - 10 frames, 10 pins used for scoring, minimum score is 0 and a max is 300. 
# 2) Implement basic scoring - 10 frames of 2 rolls each.  Normal rolls are 1 point per pin.
# 3) Strikes and spare strikes - 1 roll to knock all 10 are strikes (X), 2 rolls to knock all 10 are spares (/).
# 4) Scoring strikes - If first throw, (10+a).  If spare, 10 + a.  Max 30 for first, max 20 for second.
# 5) Focus on frames for scoring - score is a sum of individual frames.  Note: strikes causes frame crossover.
# 6) Implement spare scoring - Spare scoring crossing frames still count for that frame.
# 7) Scoring a strike - Finish implementing logic from #3.
# 8) Implement scoring considering strikes - Strike scoring crossing frames still count for that frame.
# 9) 10th Frame - If strike or spare is rolled, bowler gets extra ball.  This should make it 21 or less rolls.

PROJECT=$HOME/Projects/ruby_bowling_game

createbranch() { 
  git checkout -b $1
}

mergebranch() {  
  git checkout master
  git merge $1
  git branch -D $1
}

if [ -d $PROJECT ]; then
  echo "Path '$PROJECT' already exists."
else

  mkdir $PROJECT && cd $PROJECT

  git init .
  
  echo "*.gem
*.rbc
*.lock" >> .gitignore
  
  echo "source 'https://rubygems.org'

gem 'rspec'" >> Gemfile

  bundle install  
  
  mkdir app spec

  touch .rspec app/game.rb spec/spec_helper.rb spec/bowling_game_spec.rb
  
  rspec #sanity check.  You should see '0 examples, 0 failures'

  #Not used but this kata is normally where our spec configuration goes
  echo "RSpec.configure do |config|
end" >> spec/spec_helper.rb

  echo "class Game
end" >> app/game.rb

  echo "require 'spec_helper'
require_relative '../app/game'

describe Game do
  before :each do
    @game = Game.new
  end

  describe '#new' do
      it 'just get ' do
          expect(@game).to be_an_instance_of Game
      end
  end
end" >> spec/bowling_game_spec.rb

  rspec #passes...we just want to get a test going for initial TDD.  Afterwards, we'll start the "fail/pass" paradigm.  
  
  git status
  git add -A && git commit -am "Initial commit."
  
  #****** TODO: Rest of "how we got here" in this script. *********
fi

echo "Script Complete."
