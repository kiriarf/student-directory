#require date class to get current month name in input_students method
require 'date'

#print the header
def print_header
  puts "The students of Villains Academy".center(50, "-")
  puts "--------------------------------".center(50, "-")
end

#input student information manually
def input_students
  puts "Please enter the name of a student".center(50, "-")
  puts "To finish, hit return".center(50, "-")
  # create an empty array
  students = []
  #default cohort value is current month -> used when no value provided
  default_cohort = Date.today.strftime("%B")
  # get the name
  name = gets.chomp
  if !name.empty?
    puts "Enter their height in cm".center(50, "-")
    height = gets.chomp
    puts "Enter cohort month or hit return for current month".center(50, "-")
    cohort = gets.chomp
  end
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {
      name: name,
      cohort: !cohort.empty? ? cohort : default_cohort,
      height: !height.empty? ? height + "cm" : "unknown"
    }
    if students.count == 1
      puts "We have our first student!".center(50, "-")
    else
      puts "Now we have #{students.count} students".center(50, "-")
    end
    # get another name and heightfrom the user
    puts "Enter another name or return to finish".center(50, "-")
    name = gets.chomp
    if !name.empty?
      puts "Enter their height in cm".center(50, "-")
      height = gets.chomp
      puts "Enter cohort month or hit return for current month".center(50, "-")
      cohort = gets.chomp
    end
  end
  # return the array of students
  students
end

#print the list of students whose name begins with a specific letter
def print_with_letter(students)
  #ask for a letter
  puts "Enter a letter to filter students or hit return to finish"
  letter = gets.chomp
  student_number = 1
  puts "Names starting with #{letter}:"
  while !letter.empty? do
    students.each_with_index do |student, index|
      if student[:name][0] == letter
        puts "#{student_number}. #{student[:name]} (#{student[:cohort]} cohort)"
        student_number += 1
      end
    end
    letter = gets.chomp
  end
end

#print students whose names are < 12 chars long
def print_shorter_than_12(students)
  puts "Names shorter than 12 characters:"
  student_number = 1
  students.each_with_index do |student, index|
    if student[:name].length < 12
      puts "#{student_number}. #{student[:name]} (#{student[:cohort]} cohort)"
      student_number += 1
    end
  end
end

#print the list of students
def print(students)
  unless students.empty?
    students.each_with_index do |student, index|
      puts "#{index + 1}. #{student[:name]}, height: #{student[:height]}cm (#{student[:cohort]} cohort)"
    end
  end
end

#print the students grouped by their cohort
def print_by_cohort(students)
  #create an empty cohorts array and populate it
  cohorts = []
  students.each do |student|
    if !cohorts.include?(student[:cohort])
      cohorts << student[:cohort]
    end
  end

  #groups students by cohort and outputs their info
  cohorts.each do |cohort|
    puts "#{cohort} cohort:"
    student_number = 1
    students.each do |student|
      if student.has_value?(cohort)
        puts "#{student_number}. #{student[:name]}, height: #{student[:height]}"
        student_number += 1
      end
    end
  end
end

#print the number of students
def print_footer(students)
  if students.count == 0
    puts "We don't have any students ;("
  elsif students.count == 1
    puts "We have one great student".center(50, "-")
  else
    puts "Overall, we have #{students.count} great students".center(50, "-")
  end
end

def interactive_menu
  students = []
  loop do
    #puts the menu options for user to choose
    puts "Options".center(50, "-")
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit"
    puts " "
    #saves user input into a variable
    puts "Enter your selection:"
    selection = gets.chomp
    puts " "
    #actions based on selection
    case selection
      when "1"
        students = input_students
      when "2"
        print_header if !students.empty?
        print_by_cohort(students)
        puts " "
        print_footer(students)
        puts " "
      when "9"
        exit
      else
        puts "Wrong selection, try again"
    end
  end
end

interactive_menu

#nothing happens until we call the methods
# students = input_students
# print_header if !students.empty?
# print_with_letter(students)
# print_shorter_than_12(students)
# print_by_cohort(students)
# print(students)
# print_footer(students)
