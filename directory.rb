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
  # get the name
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
print_footer(students)
