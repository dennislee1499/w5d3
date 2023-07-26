require 'singleton'
require 'sqlite3'

class QuestionsDBConnection < SQLite3::Database 
    include Singleton 
    
    def initialize 
        super('questions.db')
        self.type_translation = true 
        self.results_as_hash = true
    end
end

class User
    def self.all 
        data = QuestionsDBConnection.instance.execute("SELECT * FROM users")
        # data => [ {id: 1, fname: klodian, lname: b}, {id: 2, fname: dennis, lname: lee } ] 
        data.map { |datum| User.new(datum) }
        # => [ <User#12391928: id:> ]
    end

    def self.find_by_id(num)
        sql_query = "SELECT * FROM users WHERE id = " + num.to_s
        result = QuestionsDBConnection.instance.execute(<<-SQL, num)
        SELECT 
            *
        FROM 
            users
        WHERE
            id = ?
        SQL
        User.new(result.first)
    end

    def initialize(options) # hash
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def create 
        raise "#{self} already in database" if @id 
        QuestionsDBConnection.instance.execute(<<-SQL, @fname, @lname)
            INSERT INTO 
                users (fname, lname)
            VALUES
                (?, ?)
        SQL
        @id = QuestionsDBConnection.instance.last_insert_row_id
    end

    def update
        raise "#{self} not in database" unless @id
        QuestionsDBConnection.instance.execute(<<-SQL, @fname, @lname, @id)
            UPDATE
                user
            SET 
                fname = ?, lname = ?
            WHERE   
                id = ?
        SQL
    end

end