#print the header
def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

#input student information manually
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: :november}
    if students.count == 1
      puts "We have our first student!"
    else
      puts "Now we have #{students.count} students"
    end
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

#print the list of students
def print(students)
  students.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

#print the list of students whose name begins with a specific letter
def print_with_letter(students)
  #ask for a letter
  puts "Enter a letter to filter students or hit return to finish"
  letter = gets.chomp
  student_number = 1
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

#print the number of students
def print_footer(students)
  if students.count == 1
    puts "We have one great student"
  else
    puts "Overall, we have #{students.count} great students"
  end
end

#nothing happens until we call the methods
students = input_students
print_header
print(students)
# print_with_letter(students)
print_shorter_than_12(students)
print_footer(students)
