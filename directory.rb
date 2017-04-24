#Let's put all the students into an array
students = [
    "Dr. Hannible Lecter",
    "Darth Vader",
    "Nurse Ratched",
    "Michael Corleone",
    "Alex DeLarge",
    "The Wicked Witch of the West",
    "Terminator",
    "Freddy Kruger",
    "The Joker",
    "Joffrey Baratheon",
    "Norman Bates"
    ]
#and then we print them
def print_header 
    puts "The students of Villain Academy"
    puts "-------------"
end

def print(names)
    names.each do |name|
    puts name
    end
end


def print_footer(names)
    puts "Overall, we have #{names.count} great students!"
end
#nothing happens untill we call the methods

print_header
print(students)
print_footer(students)

