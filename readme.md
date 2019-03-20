# Bowling Game - A Ruby TDD Story
Ever since I started the quest to become agile after reading ['Agile Principles, Patterns, and Practices in C#' by Robert "Uncle Bob Martin and Micah Martin][1], whenever I wanted to learn a new language I began with the reliable bowling game example.  When I became interested in learning Ruby back in 2015, I figured doing TDD in Ruby would be the best way so I became interested in a [tutorial][2] and [example][3] I found.  Hopefully, my take becomes a good tutorial for anyone who wants to learn [TDD/BDD][8].  I'll complete this tutorial when time permits.  Tentatively shooting for late April 2019.

All of my instructions will be for Debian based systems (Ubuntu, Linux Mint, etc.).  Ctrl-T to open up your terminal, we are going to live at the command-line.  You don't need to grasp much of what we are doing until we arrive to the programming portion of the tutorial.  For editing code, we will be using Vim.  I'm going to be bold here:  if you learn to live at the command-line and use Vim or Emacs, you will become a more productive programmer.  There, I said it.  If you aren't familiar with Vi or Vim, there are many wonderful [tutorials][7] online.

### Specification
Before we write a single line of code, let's write our "specs".  What are we attempting to design?

    1) Scoring basics - 10 frames, 10 pins used for scoring, minimum score is 0 and a max is 300.
    2) Implement basic scoring - 10 frames of 2 rolls each.  Normal rolls are 1 point per pin.
    3) Strikes and spare strikes - 1 roll to knock all 10 are strikes (X), 2 rolls to knock all 10 are spares (/).
    4) Scoring strikes - If first throw, (10+a).  If spare, 10 + a.  Max 30 for first, max 20 for second.
    5) Focus on frames for scoring - score is a sum of individual frames.  Note: strikes causes frame crossover.
    6) Implement spare scoring - Spare scoring crossing frames still count for that frame.
    7) Scoring a strike - Finish implementing logic from #3.
    8) Implement scoring considering strikes - Strike scoring crossing frames still count for that frame.
    9) 10th Frame - If strike or spare is rolled, bowler gets extra ball.  This should make it 21 or less rolls.

### Install Ruby via Rvm
Also we'll be adding "~/.rvm/scripts/rvm" to your path.

    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB       
    sudo apt update && apt upgrade -y
    curl -sSL https://get.rvm.io | bash -s stable --ruby
    
    echo -e "source $HOME/.rvm/scripts/rvm " >> ~/.bashrc 
    source $HOME/.rvm/scripts/rvm      

### Install [Bundler][5] globally. 
Bundler is a package....errrr...gem manager.  

    gem install bundler
    
### Setup your project.     
    PROJECT=$HOME/Projects/rubydev/bowling_game
    mkdir -p $PROJECT $PROJECT/app $PROJECT/spec
    
    cd $PROJECT
  
    echo "*.gem
    *.rbc
    *.lock" >> .gitignore

    git init .
    
    echo "class Game end" >> app/game.rb
    
### Add the [RSpec][6] gem.
RSpec is a testing framework.  We'll add the gem to our project.

    echo "source 'https://rubygems.org'

    gem 'rspec'" >> $PROJECT/Gemfile

    bundle install   
    
    touch .rspec $PROJECT/spec/bowling_game_spec.rb
    
Open Vim.  As mentioned earlier, we will be living at the command-line.
    
    vim $PROJECT/spec/spec_helper.rb
    
Once the editor is open, hit the 'i' key to begin editing our specs configuration file.

    RSpec.configure do |config|
      config.warnings = true
      config.order = :random  #random test order to ensure no order dependency
    end
    
### Write your first test.

    vim $PROJECT/spec/bowling_game_spec.rb
    
Now let's edit the file and write our test.

    require 'spec_helper'
    require_relative '../app/game'

    describe Game do
      before :each do
        @game = Game.new
      end

      describe '#new' do
          it 'just works' do
              expect(@game).to be_an_instance_of Game
          end
      end
    end
    
While still in Vim, type ':wq' to close it.  Now, time to check our test.

    rspec
    
Of course, this will pass.  For now on, we'll begin the 'fail-pass-refactor' paradigm when writing tests.  
    
### TODO:  The rest of this tutorial when I find the time....
    To be continued....    
    
[1]: https://www.goodreads.com/book/show/84983.Agile_Principles_Patterns_and_Practices_in_C_
[2]: http://butunclebob.com/files/downloads/Bowling%20Game%20Kata.ppt
[3]: https://github.com/k00ka/bowling-game-kata/tree/david_final
[4]: https://github.com/WillSams/ruby_bowling_game_kata
[5]: https://bundler.io/
[6]: http://rspec.info/
[7]: https://www.openvim.com/
[8]: https://www.toptal.com/freelance/your-boss-won-t-appreciate-tdd-try-bdd
