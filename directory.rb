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
puts "The students of Villain Academy"
puts "-------------"
students.each do |student|
    puts student
end
#finally we print the total number of students
puts "Overall, we have #{students.count} great students!"
#it's important that print() doesn't add new line characters

