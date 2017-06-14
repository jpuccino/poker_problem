#Notes:
To run the script to calculate the answer do one of the following:

`$ ./calculate_wins.rb`

`$ ./calculate_wins.rb poker.txt`

`$ ruby calculate_wins.rb`

`$ ruby calculate_wins.rb poker.txt`

To run without the explicit call to `ruby`, be sure to properly set the file permissions to make the script executable.

The script assumes that if you do not supply a filename, then 'poker.txt' is in the current directory.

To run the tests for the classes involved, please be sure that the `rspec` gem is installed and execute the following in the root of the project:

`$ rspec`

The result for the file supplied in the problem should be as follows:

    $ ./calculate_wins.rb
    Player 1 won 376 of 1000 games
    
[Reference link for the problem](https://projecteuler.net/problem=54) 

