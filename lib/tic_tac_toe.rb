class TicTacToe
    attr_accessor :board

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [6,4,2],
    ]

    def initialize 
        @board =    [" ", " ", " ",
                    " ", " ", " ",
                    " ", " ", " "]
    end

    def display_board
        print [  [" #{@board[0]} | #{@board[1]} | #{@board[2]} "],
                "-----------", 
                [" #{@board[3]} | #{@board[4]} | #{@board[5]} "],
                "-----------",
                [" #{@board[6]} | #{@board[7]} | #{@board[8]} "],]
    end

    def input_to_index (str)
        str.to_i - 1
    end

    def move (num, str)
        @board[num] = str
    end

    def position_taken? (ind)
        @board[ind] != " " ? true : false
    end

    def valid_move? (ind)
        (ind >=0 && ind <= 8) ? !position_taken?(ind) : false
    end

    def turn_count ()
        @board.filter{ |s| s != " " }.length
    end

    def current_player ()
        turn_count % 2 == 0 ? "X" : "O"
    end

    def turn ()
        target = input_to_index(gets.strip)
        if valid_move?(target)
            move(target, current_player)
            display_board
        else
            turn
        end
    end

    def won?
        WIN_COMBINATIONS.any? do |winning_combo|
            if position_taken?(winning_combo[0]) && @board[winning_combo[0]] == @board[winning_combo[1]] && @board[winning_combo[1]] == @board[winning_combo[2]]
                return winning_combo
            end
        end
    end

    def full? 
        @board.filter{ |s| s != " " }.length == 9 ? true : false
    end

    def draw?
        full? && won? || !full? ? false : true
    end

    def over?
        draw? || won? ? true : false
    end

    def winner
        if won?
            if current_player == "X"
                return "O"
            elsif current_player == "O"
                return "X"
            else
                nil
            end
        end
    end

    def play
        turn until over?
        puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
    end

end