#require date class to get current month name in input_students method
require 'date'
require 'CSV'

#create an empty array as an instance variable
@students = []

#print the header
def print_header
  puts "The students of Villains Academy".center(50, "-")
  puts "--------------------------------".center(50, "-")
end

#input student information manually
def input_students
  puts "Please enter the name of a student".center(50, "-")
  puts "To finish, hit return".center(50, "-")
  #default cohort value is current month -> used when no value provided
  default_cohort = Date.today.strftime("%B")
  # get the name
  name = STDIN.gets.chomp
  if !name.empty?
    puts "Enter their height in cm".center(50, "-")
    height = STDIN.gets.chomp
    puts "Enter cohort month or hit return for current month".center(50, "-")
    cohort = STDIN.gets.chomp
  end
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    @students << {
      name: name,
      cohort: !cohort.empty? ? cohort.downcase.capitalize : default_cohort,
      height: !height.empty? ? height + "cm" : "unknown"
    }
    if @students.count == 1
      puts "We have our first student!".center(50, "-")
    else
      puts "Now we have #{@students.count} students".center(50, "-")
    end
    # get another name and heightfrom the user
    puts "Enter another name or return to finish".center(50, "-")
    name = STDIN.gets.chomp
    if !name.empty?
      puts "Enter their height in cm".center(50, "-")
      height = STDIN.gets.chomp
      puts "Enter cohort month or hit return for current month".center(50, "-")
      cohort = STDIN.gets.chomp
    end
  end
end

#print the list of students whose name begins with a specific letter
def print_with_letter(arr)
  #ask for a letter
  puts "Enter a letter to filter students or hit return to finish"
  letter = STDIN.gets.chomp
  student_number = 1
  puts "Names starting with #{letter}:"
  while !letter.empty? do
    arr.each_with_index do |student, index|
      if student[:name][0] == letter
        puts "#{student_number}. #{student[:name]} (#{student[:cohort]} cohort)"
        student_number += 1
      end
    end
    letter = STDIN.gets.chomp
  end
end

#print students whose names are < 12 chars long
def print_shorter_than_12(arr)
  puts "Names shorter than 12 characters:"
  student_number = 1
  arr.each_with_index do |student, index|
    if student[:name].length < 12
      puts "#{student_number}. #{student[:name]} (#{student[:cohort]} cohort)"
      student_number += 1
    end
  end
end

#print the list of students
def print_students(arr)
  unless arr.empty?
    arr.each_with_index do |student, index|
      puts "#{index + 1}. #{student[:name]}, height: #{student[:height]} (#{student[:cohort]} cohort)"
    end
  end
end

#print the students grouped by their cohort
def print_by_cohort(arr)
  #create an empty cohorts array and populate it
  cohorts = []
  arr.each do |student|
    if !cohorts.include?(student[:cohort])
      cohorts << student[:cohort]
    end
  end

  #groups students by cohort and outputs their info
  cohorts.each do |cohort|
    puts "#{cohort} cohort:"
    student_number = 1
    arr.each do |student|
      if student.has_value?(cohort)
        puts "#{student_number}. #{student[:name]}, height: #{student[:height]}"
        student_number += 1
      end
    end
  end
end

#print the number of students as a footer
def print_footer(arr)
  if arr.count == 0
    puts "We don't have any students ;("
  elsif arr.count == 1
    puts "We have one great student".center(50, "-")
  else
    puts "Overall, we have #{arr.count} great students".center(50, "-")
  end
end

#Prints the menu of the application
def print_menu
  puts "Options".center(50, "-")
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Show the students by cohort"
  puts "4. Save the list to students.csv"
  puts "5. Load the list from students.csv"
  puts "9. Exit"
  puts " "
  puts "Enter your selection:"
end

#Prints the header, student list and footer
def show_students
  print_header if !@students.empty?
  print_students(@students)
  puts " "
  print_footer(@students)
  puts " "
end

#Same as above but by cohort
def show_by_cohort
  print_header if !@students.empty?
  print_by_cohort(@students)
  puts " "
  print_footer(@students)
  puts " "
end

#Saves the list of students to students.csv
def save_students
  #open file for writing
  file = File.open("students.csv", "w")
  #add header row
  header_row = "Name, Height, Cohort"
  file.puts header_row
  #iterate over @students
  @students.each do |student|
    student_data = [student[:name], student[:height], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

#load the list from students.csv
def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each_with_index do |line, index|
    if index > 0
      name, height, cohort = line.chomp.split(',')
        @students << {name: name, height: height, cohort: cohort}
    end
  end
  file.close
end

#if user provides filename argument in cmd line, will try to load list
def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename)
    load_students(filename)
     puts "Loaded #{@students.count} students from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end


#Actions based on user selection
def process(selection)
  puts " "
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      show_by_cohort
    when "4"
      save_students
      puts "File saved!"
    when "5"
      load_students
      puts "File loaded!"
    when "9"
      exit
    else
      puts "Wrong selection, try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end



#nothing happens until we call the methods
try_load_students
interactive_menu
# students = input_students
# print_header if !students.empty?
# print_with_letter(students)
# print_shorter_than_12(students)
# print_by_cohort(students)
# print(students)
# print_footer(students)
