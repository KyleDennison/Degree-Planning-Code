# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ----- Create some accounts -----

# Create a faculty member
User.create(email: "faculty@ncf.edu", password: "password", faculty: true, firstname: "John", lastname: "Doucette")

# Create a student
User.create(email: "student@ncf.edu", password: "password", faculty: false, firstname: "Jane", lastname: "Smith")

# ----- Create some majors, courses, and corresponding requirement areas -----

# Computer Science
cs = Major.create(title: "Computer Science", description: "Learn some computer stuff.")

calculus_3 = Course.create(title: "Calculus 3")
calculus_2 = Course.create(title: "Calculus 2", parent: calculus_3)
calculus_1 = Course.create(title: "Calculus 1", parent: calculus_2)
discrete_mathematics = Course.create(title: "Discrete Mathematics")

sql = Course.create(title: "Intro to SQL")
database_design = Course.create(title: "Database Design")

cs_maths_req = Requirement.new(name: "Mathematics", major: cs, num_required: 3)
cs_maths_req.courses << calculus_1
cs_maths_req.courses << calculus_2
cs_maths_req.courses << calculus_3
cs_maths_req.courses << discrete_mathematics
cs_maths_req.save

cs_databases_req = Requirement.new(name: "Databases", major: cs, num_required: 1)
cs_databases_req.courses << sql
cs_databases_req.courses << database_design
cs_databases_req.save

# Economics
economics = Major.create(title: "Economics", description: "Money makes the world go round.")
economics_maths_req = Requirement.new(name: "Mathematics", major: economics, num_required: 1)
economics_maths_req.courses << calculus_1
economics_maths_req.save

intermediate_micro = Course.create(title: "Intermediate Microeconomics")
intermediate_macro = Course.create(title: "Intermediate Macroeconomics")
intro_microeconomics = Course.create(title: "Introductory Microeconomics", parent: intermediate_micro)
intro_macroeconomics = Course.create(title: "Introductory Macroeconomics", parent: intermediate_macro)

economics_intro_reqs = Requirement.new(name: "Introductory Courses", major: economics, num_required: 2)
economics_intro_reqs.courses << intro_microeconomics
economics_intro_reqs.courses << intro_macroeconomics
economics_intro_reqs.save

economics_intermediate_reqs = Requirement.new(name: "Intermediate Courses", major: economics, num_required: 2)
economics_intermediate_reqs.courses << intermediate_micro
economics_intermediate_reqs.courses << intermediate_macro
economics_intermediate_reqs.save

# Philosophy
philosophy = Major.create(title: "Philosophy", description: "Would you like fries with that?")

analytic_req = Requirement.new(name: "Contemporary, analytic areas", major: philosophy, num_required: 2)
analytic_req.courses << Course.create(title: "Philosophy of language")
analytic_req.courses << Course.create(title: "Philosophy of science")
analytic_req.courses << Course.create(title: "Philosophy of mind")
analytic_req.save

logic_req = Requirement.new(name: "Deductive Logic", major: philosophy, num_required: 1)
logic_req.courses << Course.create(title: "Formal Logic")
logic_req.save

intro_ethics_req = Requirement.new(name: "Intro to Ethics", major: philosophy, num_required: 1)
intro_ethics_req.courses << Course.create(title: "Introduction to Ethics")
intro_ethics_req.save

value_req = Requirement.new(name: "Value Theory", major: philosophy, num_required: 2)
value_req.courses << Course.create(title: "Intro to Political Theory")
value_req.courses << Course.create(title: "Advanced Ethics")
value_req.courses << Course.create(title: "Virtues & Vices")
value_req.save

modern_req = Requirement.new(name: "Modern Philosophy", major: philosophy, num_required: 1)
modern_req.courses << Course.create(title: "Modern Philosophy")
modern_req.save