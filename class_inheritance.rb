require 'byebug'

class Employee

  attr_reader :name, :title, :salary, :boss

  def initialize (name , title, salary, boss = nil)
    @name, @title, @salary, @boss = name , title, salary, boss
  end

  def bonus(multiplier)
    salary * multiplier
  end


end

class Manager < Employee
  attr_reader :employees

  def initialize(name , title, salary, boss = nil, employees)
    super(name , title, salary, boss)
    @employees = employees
  end

  def bonus(multiplier)
    # debugger
    new_salary = 0
    employees.each do |employee|
     new_salary += employee.salary
    end
    new_salary * multiplier
  end
end

shawna = Employee.new("Shawna", "TA", 12000)

david = Employee.new("David", "TA", 10000)


darren = Manager.new("Darren", "TA Manager", 78000, [shawna, david])


ned = Manager.new("Ned", "Founder", 1000000, boss = nil, [darren, shawna, david])




puts "Ned's bonus is #{ned.bonus(5)}!"
puts "Darren's bonus is #{darren.bonus(4)}!"
puts "David's bonus is #{david.bonus(3)}!"
