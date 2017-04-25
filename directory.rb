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
    puts "The students of Villain Academy".center(150)
    puts "-------------".center(150)
end

def print(students)
    students.each_with_index do |student, index|
    puts "#{index + 1} #{student[:name]} (#{student[:cohort]} cohort), Born in: #{student[:country]}, Height: #{student[:height]}, Hobbies: #{student[:hobbies]}"
    end
end

def print_footer(students)
    if students.length > 1
    puts "Overall, we have #{names.count} great students!".center(150)
    elsif students.length == 1
    puts "Overall, we have #{names.count} great student!".center(150)
    else
    puts "Sadly we have no students, great or otherwise :(".center(150)
    end
end

def input_instructions
    puts "Enter 'student' to add a new student"
    puts "Enter 'filter' to filter students"
    puts "Enter 'end' to finish"
end

def student_entry(students, cohorts)
    input = ""
    until input.downcase == "stop"
                puts "Please enter the name of the student"
                    name = gets.chomp
                        while name == ""
                        puts "ERROR: Please enter the student's full name"
                        name = gets.chomp
                        end
                        
                puts "Please input student's cohort month"
                    cohort = gets.chomp
                        until cohorts.any?{|month| month == cohort.downcase.to_sym}
                            puts "ERROR: Please enter full name of month and check for typos"
                            cohort = gets.chomp
                        end
                    cohort = cohort.downcase.to_sym
                    
                puts "Please input student's country of birth"
                    country = gets.chomp
                        while country == ""
                        puts "ERROR: Please enter the student's country of origin"
                        country = gets.chomp
                        end
                        
                puts "Please input the student's height in cm"
                    height = gets.chomp
                        while height == ""
                        puts "ERROR: Please enter the student's height in cm"
                        height = gets.chomp
                        end
                    
                puts "Please add the student's hobbies"
                    hobbies = gets.chomp
                    hobbies = "none" if hobbies == ""
                    
                students << {name: name, cohort: cohort, country: country, height: height, hobbies: hobbies}
                puts "We now have #{students.count} students"
                #get another name from the user
                puts "Enter 'stop' to finish or press return again to continue"
                input = gets.chomp
    end
end

def student_filter(students)
    if students.empty?
        puts "ERROR: There are no students to filter"
    else
    puts "Enter 'letter' to filter by letter or 'length' to filter by length"
    input = gets.chomp
            if input.downcase == "letter"
                puts "Please enter a letter to filters for names beginning with that letter"
                letter = gets.chomp
                print_header
                students.each{|x| x.each_value{|value| puts "#{value} (#{x[:cohort]} cohort)" if value[0].downcase == letter.downcase }}
            elsif input.downcase == "length"
                puts "Please enter a number to filter for names of that length or less"
                number = gets.chomp
                print_header
                students.each{|x| x.each_value{|value| puts "#{value} (#{x[:cohort]} cohort)" if value.length <= number.to_i && value != :november }}
            end 
    end

end

def input_students
    input_instructions
    #ccreates and empty array
    students = []
    cohorts = [:january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december]
    #gets the first name
    input = gets.chomp
    #while the name is not emtpty, repeat this code
    until input.downcase == "end"  do
        #add the student hash to the array
        if input.downcase == "filter"
            student_filter(students)
            input_instructions
            input = gets.chomp
        elsif input.downcase == "student"
            student_entry(students, cohorts)
            input_instructions
            input = gets.chomp
        else
            input_instructions
            input = gets.chomp
        end
    end
    #return the array of students
    students
end
#nothing happens untill we call the methods

students = input_students
print_header
print(students)
print_footer(students)


