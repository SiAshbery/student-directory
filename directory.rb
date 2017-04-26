require 'csv'

def cat_students
    @students = [] if @students.nil?  
 @students << {name: @name, cohort: @cohort.to_sym, country: @country, height: @height, hobbies: @hobbies}   
end

def save_students
    # open the file for writing
    puts "Please enter the file you wish to save to:"
    filename = STDIN.gets.chomp
    puts "WARNING: This file will be overwritten" if File.exist?(filename) #if it exists
    CSV.open(filename, "w") do |file|
    #iterates over the array of students
        @students.each do |student|
            file << [student[:name], student[:cohort], student[:country], student[:height], student[:hobbies]]
            
            end
    end
    puts "File has been successfully saved"
end

def try_load_students
    filename = ARGV.first #first argument from the command line
   return if filename.nil? # get out of this method if filename isn't present
    if File.exist?(filename) #if it exists
        load_students(filename)
        puts "Loaded #{@students.count} from #{filename}"
    else #if it doesn't exist
        puts "Sorry, #{filename} doesn't exist"
        exit #quits the program
    end
end

def load_students(filename = "students.csv")
        @students = [] if @students.nil?  
        puts "Please enter file you wish to load from"
        filename = STDIN.gets.chomp
        
            if !File.exist?(filename)
                puts "Sorry, this file does not exist" 
                return
            end
            
        CSV.foreach(filename) do |line|
            puts line
            @name, @cohort, @country, @height, @hobbies = line.join(",").chomp.split(",")
            cat_students
            end
        
   puts "File has been successfully loaded"
end

def print_header 
    #Displayers the centred header and a dividing line
    puts "The students of Villain Academy".center(150)
    puts "-------------".center(150)
end

def print_list#(students)
    #iterates through all current entries in the students array
    @students.each_with_index do |student, index|
        #Prints their numbered index + 1 (because the first index is 0) And then all subsequent info from each section of the student's info hash
        puts "#{index + 1}: #{student[:name]} (#{student[:cohort]} cohort), Born in: #{student[:country]}, Height: #{student[:height]}cm, Hobbies: #{student[:hobbies]}"
    end
end

def print_footer#(students)
    #And if statement to print 3 centred versions of the footer one for an empty array, one for a single entry and one for multiple
    if @students.length > 1
    puts "Overall, we have #{@students.count} great students!".center(150)
    elsif @students.length == 1
    puts "Overall, we have #{@students.count} great student!".center(150)
    else
    puts "Sadly we have no students, great or otherwise :(".center(150)
    end
end

def show_students
    @students = [] if @students.nil?
    print_header
    print_list#(students)
    print_footer#(students) 
end

def main_menu_options
        puts "Please input a number"
        puts "1. Add a new student"
        puts "2. Display current students"
        puts "3. Filter students"
        puts "4. Save the list to file"
        puts "5. Load students from file"
        puts "9. Exit"  
end

def filter_menu_options
    puts "Please select what you want to filter by:"
    puts "1. Letter of first name"
    puts "2. Length of student name"
    puts "3. Student's cohort month" 
end

def main_menu_process(selection)
    case selection
            when "1" 
                student_entry#(students, cohorts)
                # input the students
            when "2"
               show_students
                #displays the current students
            when "3" 
                student_filter#(students, cohorts)
                #opens filter options
            when "4"
                save_students
                #saves the current student list to file
            when "5"
                load_students
            when "9"
                exit
                #exits program
            else
                #ensures the user is aware they cannot select anything other than the presented options
                puts "ERROR: Sorry I don't understand, please try again"
    end 
end

def filter_menu_process(input)
    case input
            #filters by first letter of name
            when "1"
                puts "Please enter a letter to filters for names beginning with that letter"
                letter = STDIN.gets.chomp
                print_header
                @students.each{|x| puts "##{x[:name]} (#{x[:cohort]} cohort)" if x[:name][0].downcase == letter.downcase }
            #filters by name length
            when "2"
                puts "Please enter a number to filter for names of that length or less"
                number = STDIN.gets.chomp
                print_header
                @students.each{|x| puts "#{x[:name]} (#{x[:cohort]} cohort)" if x[:name].length <= number.to_i }
            #filters by cohort month
            when "3"
                puts "Please enter a month to select students from that cohort"
                requested_cohort = STDIN.gets.chomp
                    until @cohorts.any?{|month| month == requested_cohort.downcase.to_sym}
                            puts "ERROR: Please enter full name of month and check for typos"
                            requested_cohort = STDIN.gets.chomp
                    end
                print_header
                @students.each{|x| puts "#{x[:name]} (#{x[:cohort]} cohort)" if x[:cohort] == requested_cohort.downcase.to_sym}
            
            #ensures the users cant select something not on the list
            else
                puts "ERROR: Unrecognized filter"
    end 
end

def input_menu
    #An array filled with immutable symbols for each month of the year. We can use this to ensure cohort data is consistent
    @cohorts = [:january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december]
    #This loop ensures the program will always return to the menu until the user explicitly ends it.
    loop do
        #print the menu options
        main_menu_options
        #records the users selection and then performs different actions depending on thei choice.
        selection = STDIN.gets.chomp
        main_menu_process(selection)
    end
end

def student_entry#(students, cohorts)
    #creates an empty string
    input = ""
    #repeates the student entry until the user chooses to stop and return to the menu
    until input.downcase == "stop"
            #stores the name to a variable
                until input.downcase == "y"
                    puts "Please enter the name of the student"
                       @name = STDIN.gets.chomp
                        #ensures the user can't add an empty name
                            while @name == ""
                            puts "ERROR: Please enter the student's full name"
                            @name = STDIN.gets.chomp
                            end
                    #stores the student's cohort in a variable
                    puts "Please input student's cohort month"
                        @cohort = STDIN.gets.chomp
                        #because the cohorts are based on months and thus should only have 12 options. 
                        #This conditional ensures that the user can only enter recognized months
                            until @cohorts.any?{|month| month == @cohort.downcase.to_sym}
                                puts "ERROR: Please enter full name of month and check for typos"
                                @cohort = STDIN.gets.chomp
                            end
                        @cohort = @cohort.downcase.to_sym
                #stores the student's birth place in a variable        
                    puts "Please input student's country of birth"
                        @country = STDIN.gets.chomp
                        #ensures there are no empty entries
                            while @country == ""
                            puts "ERROR: Please enter the student's country/planet/realm of origin"
                            @country = STDIN.gets.chomp
                            end
                 #stores the student's height in a variable, it asks for cm and numbers for consistency           
                    puts "Please input the student's height in cm using numbers only"
                        @height = STDIN.gets.chomp
                            while @height == "" || @height.to_i.to_s != @height 
                            puts "ERROR: Please enter the student's height in cm using numbers only"
                            @height = STDIN.gets.chomp
                            end
                # Stores the student's hobbies in a variable    
                    puts "Please add the student's hobbies"
                        @hobbies = STDIN.gets.chomp
                        #Ensures hobby returns a default value if field left blank
                        @hobbies = "none" if @hobbies == ""
                    
                    puts "Name: #{@name}, Cohort: #{@cohort}, Place of Origin: #{@country}, Height: #{@height}cm, Hobbies: #{@hobbies}."
                    puts "Is this information correct? If yes enter 'y' otherwise hit return"
                    input = STDIN.gets.chomp
                end
                #all of the info we have stored in the variables is concatinated to the students array in a hash with matching keys    
                cat_students
                #Displays current student amount
                puts "We now have #{@students.count} students"
                #get another name from the user or allow them to return to menu
                puts "Enter 'stop' to finish or press return again to continue"
                input = STDIN.gets.chomp
    end
end

def student_filter#(students, cohorts)
    #Gives an error if the user wants to filter without any students
    if @students.empty?
        puts "ERROR: There are no students to filter"
    else
    #gives the user options on how to filter names
    filter_menu_options
    #stoes the selection in a variable and then performs a different action based on which options was chosen.
    input = STDIN.gets.chomp
    filter_menu_process(input) 
    end

end

try_load_students
input_menu

