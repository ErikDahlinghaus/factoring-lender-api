# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

Borrower.create([{ name: "Landscape Business" }, { name: "Donuts Business" }])
Invoice.create([
    { borrower: Borrower.first, amount: 100, fee_percentage: 0.02, due_date: Date.current - 4.days },
    { borrower: Borrower.first, amount: 100, fee_percentage: 0.02, due_date: Date.current - 4.days },
    { borrower: Borrower.first, amount: 100, fee_percentage: 0.04, due_date: Date.current - 2.days },
    { borrower: Borrower.first, amount: 100, fee_percentage: 0.02, due_date: Date.current - 8.days },
    { borrower: Borrower.second, amount: 100, fee_percentage: 0.02185, due_date: Date.current + 4.days },
])


# TODO: Clean this up, I have to transition the states manually for AASM
# But there are better ways to create and manage these records
invoice = Invoice.find(2)
invoice.approve!
invoice.purchase!

invoice = Invoice.find(3)
invoice.approve!
invoice.purchase!
invoice.close!

invoice = Invoice.find(4)
invoice.approve!
invoice.purchase!
invoice.close!

invoice = Invoice.find(5)
invoice.reject!