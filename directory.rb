#require date class to get current month name in input_students method
require 'date'
#require to work with .csv files
require 'CSV'

#create an empty array as an instance variable
@students = []

#main menu
def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
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

#input student information manually
def input_students
  puts "Please enter the name of a student".center(50, "-")
  puts "To finish, hit return".center(50, "-")
  user_input
  populate_array
end

#in this method user is prompted for input and result saved in instance vars
def user_input
  @name = STDIN.gets.chomp
  if !@name.empty?
    puts "Enter their height in cm".center(50, "-")
    @height = STDIN.gets.chomp
    puts "Enter cohort month or hit return for current month".center(50, "-")
    @cohort = STDIN.gets.chomp
  end
end

#user input is inserted into @students array until user finishes
def populate_array
  default_cohort = Date.today.strftime("%B")
  while !@name.empty? do
    # add the student hash to the array
    @students << {
      name: @name,
      cohort: !@cohort.empty? ? @cohort.downcase.capitalize : default_cohort,
      height: !@height.empty? ? @height + "cm" : "unknown"
    }
    if @students.count == 1
      puts "We have our first student!".center(50, "-")
    else
      puts "Now we have #{@students.count} students".center(50, "-")
    end
    # get another name and heightfrom the user
    puts "Enter another name or return to finish".center(50, "-")
    user_input
  end
end

#Prints the header, student list and footer
def show_students
  print_header if !@students.empty?
  print_students(@students)
  puts " "
  print_footer(@students)
  puts " "
end

#print the header
def print_header
  puts "The students of Villains Academy".center(50, "-")
  puts "--------------------------------".center(50, "-")
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

#print the list of students
def print_students(arr)
  unless arr.empty?
    arr.each_with_index do |student, index|
      puts "#{index + 1}. #{student[:name]}, height: #{student[:height]} (#{student[:cohort]} cohort)"
    end
  end
end

#Same as above but by cohort
def show_by_cohort
  print_header if !@students.empty?
  print_by_cohort(@students)
  puts " "
  print_footer(@students)
  puts " "
end

#print the students grouped by their cohort
def print_by_cohort(arr)
  populate_cohorts(@students)
  group_by_cohort(@cohorts, @students)
end

#create an empty cohorts array and populate it
def populate_cohorts(students_arr)
  @cohorts = []
  students_arr.each do |student|
    if !@cohorts.include?(student[:cohort])
      @cohorts << student[:cohort]
    end
  end
end

#groups students by cohort and outputs their info
def group_by_cohort(cohorts_arr, students_arr)
  cohorts_arr.each do |cohort|
    puts "#{cohort} cohort:"
    student_number = 1
    students_arr.each do |student|
      if student.has_value?(cohort)
        puts "#{student_number}. #{student[:name]}, height: #{student[:height]}"
        student_number += 1
      end
    end
  end
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
  ARGV.include?(ARGV.first) ? filename = ARGV.first : filename = "students.csv"
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} students from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
  end
end

try_load_students
interactive_menu
