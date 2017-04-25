#Let's put all the students into an array
#students = [
 #   {name: "Dr. Hannible Lecter", cohort: :november},
  #  {name: "Darth Vader", cohort: :november},
   # {name: "Nurse Ratched", cohort: :november},
    #{name: "Michael Corleone", cohort: :november},
    #{name: "Alex DeLarge", cohort: :november},
    #{name: "The Wicked Witch of the West", cohort: :november},
    #{name: "Terminator", cohort: :november},
    #{name: "Freddy Kruger", cohort: :november},
    #{name: "The Joker", cohort: :november},
    #{name: "Joffrey Baratheon", cohort: :november},
    #{name: "Norman Bates", cohort: :november},
    #]
#and then we print them


def print_header 
    #Displayers the centred header and a dividing line
    puts "The students of Villain Academy".center(150)
    puts "-------------".center(150)
end

def print_list(students)
    #iterates through all current entries in the students array
    students.each_with_index do |student, index|
        #Prints their numbered index + 1 (because the first index is 0) And then all subsequent info from each section of the student's info hash
        puts "#{index + 1}: #{student[:name]} (#{student[:cohort]} cohort), Born in: #{student[:country]}, Height: #{student[:height]}cm, Hobbies: #{student[:hobbies]}"
    end
end

def print_footer(students)
    #And if statement to print 3 centred versions of the footer one for an empty array, one for a single entry and one for multiple
    if students.length > 1
    puts "Overall, we have #{students.count} great students!".center(150)
    elsif students.length == 1
    puts "Overall, we have #{students.count} great student!".center(150)
    else
    puts "Sadly we have no students, great or otherwise :(".center(150)
    end
end

def input_menu
    #sets an empty array ready to recieve student data
    students = []
    #An array filled with immutable symbols for each month of the year. We can use this to ensure cohort data is consistent
    cohorts = [:january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december]
    #This loop ensures the program will always return to the menu until the user explicitly ends it.
    loop do
        #print the menu options
        puts "Please input a number"
        puts "1. Add a new student"
        puts "2. Display current students"
        puts "3. Filter students"
        puts "9. Exit"
        #records the users selection and then performs different actions depending on thei choice.
        selection = gets.chomp
        case selection
            when "1" 
                student_entry(students, cohorts)
                # input the students
            when "2"
                print_header
                print_list(students)
                print_footer(students)
                #displays the current students
            when "3" 
                student_filter(students, cohorts)
                #opens filter options
            when "9"
                exit
                #exits program
            else
                #ensures the user is aware they cannot select anything other than the presented options
                puts "ERROR: Sorry I don't understand, please try again"
        end
                
    end
end

def student_entry(students, cohorts)
    #creates an empty string
    input = ""
    #repeates the student entry until the user chooses to stop and return to the menu
    until input.downcase == "stop"
            #stores the name to a variable
                puts "Please enter the name of the student"
                    name = gets.chomp
                    #ensures the user can't add an empty name
                        while name == ""
                        puts "ERROR: Please enter the student's full name"
                        name = gets.chomp
                        end
        #stores the student's cohort in a variable
                puts "Please input student's cohort month"
                    cohort = gets.chomp
                    #because the cohorts are based on months and thus should only have 12 options. 
                    #This conditional ensures that the user can only enter recognized months
                        until cohorts.any?{|month| month == cohort.downcase.to_sym}
                            puts "ERROR: Please enter full name of month and check for typos"
                            cohort = gets.chomp
                        end
                    cohort = cohort.downcase.to_sym
            #stores the student's birth place in a variable        
                puts "Please input student's country of birth"
                    country = gets.chomp
                    #ensures there are no empty entries
                        while country == ""
                        puts "ERROR: Please enter the student's country of origin"
                        country = gets.chomp
                        end
             #stores the student's height in a variable, it asks for cm and numbers for consistency           
                puts "Please input the student's height in cm using numbers only"
                    height = gets.chomp
                        while height == "" || height.to_i.to_s != height 
                        puts "ERROR: Please enter the student's height in cm using numbers only"
                        height = gets.chomp
                        end
                # Stores the student's hobbies in a variable    
                puts "Please add the student's hobbies"
                    hobbies = gets.chomp
                    #Ensures hobby returns a default value if field left blank
                    hobbies = "none" if hobbies == ""
                
                #all of the info we have stored in the variables is concatinated to the students array in a hash with matching keys    
                students << {name: name, cohort: cohort, country: country, height: height, hobbies: hobbies}
                #Displays current student amount
                puts "We now have #{students.count} students"
                #get another name from the user or allow them to return to menu
                puts "Enter 'stop' to finish or press return again to continue"
                input = gets.chomp
    end
end

def student_filter(students, cohorts)
    #Gives an error if the user wants to filter without any students
    if students.empty?
        puts "ERROR: There are no students to filter"
    else
    puts "Please select what you want to filter by:"
    puts "1. Letter of first name"
    puts "2. Length of student name"
    puts "3. Student's cohort month"
    input = gets.chomp
        case input
            when "1"
                puts "Please enter a letter to filters for names beginning with that letter"
                letter = gets.chomp
                print_header
                students.each{|x| x.each_value{|value| puts "#{value} (#{x[:cohort]} cohort)" if value[0].downcase == letter.downcase }}
            when "2"
                puts "Please enter a number to filter for names of that length or less"
                number = gets.chomp
                print_header
                students.each{|x| puts "#{x[:name]} (#{x[:cohort]} cohort)" if x[:name].length <= number.to_i }
            when "3"
                puts "Please enter a month to select students from that cohort"
                requested_cohort = gets.chomp
                    until cohorts.any?{|month| month == requested_cohort.downcase.to_sym}
                            puts "ERROR: Please enter full name of month and check for typos"
                            requested_cohort = gets.chomp
                    end
                print_header
                students.each{|x| puts "#{x[:name]} (#{x[:cohort]} cohort)" if x[:cohort] == requested_cohort.downcase.to_sym}
            
            else
                puts "ERROR: Unrecognized filter"
        end
             
    end

end


input_menu

