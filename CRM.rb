require "./contacts"
require "./database"
class CRM

	def initialize(name) 
    	@name= name
	end

	def main_menu
  		print_main_menu
  		user_selected = gets.to_i
  		call_option(user_selected)
	end

	def print_main_menu
	  puts "[1] Add a new contact"
	  puts "[2] Modify an existing contact"
	  puts "[3] Delete a contact"
	  puts "[4] Display all the contacts"
	  puts "[5] Display an attribute" 
	  puts "[6] Exit"
	  puts "Enter a number: "
	end

	def call_option(user_selected)
		add_new_contact if user_selected == 1 
		modify_existing_contact if user_selected == 2
		delete_contact if user_selected == 3
		display_all_contacts if user_selected == 4
		display_attribute if user_selected == 5
		exit if user_selected == 6 
		#main_menu 
	end

	def add_new_contact
	  puts "Enter First Name: "
	  first_name = gets.chomp
	  puts "Enter Last Name: "
	  last_name = gets.chomp
	  puts "Enter Email Address: "
	  email = gets.chomp
	  puts "Enter a Note: "
	  note = gets.chomp
	  contact = Contact.new(first_name, last_name, email, note)
	  Database.add_contact(contact)
	  main_menu
	end

	def modify_existing_contact
		print "Enter ID to modify:"
		modify_id= gets.chomp.to_i
		modified_contact_place=0 # to set it outside the if statment 
		if verify_id(modify_id)
			contact_counter=0
			Database.contacts.each do |contact|
				if contact.id ==modify_id
					puts "First Name: #{Database.contacts[contact_counter].first_name}"
					puts "Last Name: #{Database.contacts[contact_counter].last_name}" 
					puts "Email: #{Database.contacts[contact_counter].email}"
					puts "Note: #{Database.contacts[contact_counter].note}"
					modified_contact_place=contact_counter
				end
				contact_counter+=1
			end
			puts "Are you SURE you want to modify this contact? (Type 'yes' or 'no')"
			delete_confirmation = gets.chomp.downcase #either yes or no
			if delete_confirmation == "yes"
				puts "Enter new First Name: "
				Database.contacts[modified_contact_place].first_name= gets.chomp
				puts "Enter new Last Name: "
				Database.contacts[modified_contact_place].last_name= gets.chomp
				puts "Enter new email: "
				Database.contacts[modified_contact_place].email= gets.chomp
				puts "Enter new note: "
				Database.contacts[modified_contact_place].note= gets.chomp
	  			main_menu
			elsif delete_confirmation == "no"
				main_menu
			else
				puts "Wrong word entered. Please enter 'yes' or 'no'"
			end			
		else
			"You typed in a non existing id"
			main_menu
		end
	end

	def delete_contact
		puts "Enter ID to delete:"
		delete_id= gets.chomp.to_i
		if verify_id(delete_id)
			contact_counter=0
			Database.contacts.each do |contact|
				Database.contacts.delete_at(contact_counter) if contact.id ==delete_id
				contact_counter+=1
			end
			main_menu
		else
			main_menu
		end
	end

	def display_all_contacts
		puts "\e[H\e[2J"
		Database.contacts.each do |contact|
				puts "ID: #{contact.id}"
				puts "First Name: #{contact.first_name}" 
				puts "Last Name: #{contact.last_name}" 
				puts "email address: #{contact.email}" 
				puts "Note: #{contact.note}" 
				puts "\n"
		end
		main_menu
	end

	def display_attribute
		puts "\e[H\e[2J"
		puts "Enter an attribute (id, first_name, last_name, email or note)"
		attribute= gets.chomp.downcase
		Database.contacts.each do |contact|	
			puts contact.id if attribute== "id"
			puts contact.first_name if attribute== "first_name"
			puts contact.last_name if attribute== "last_name"
			puts contact.email if attribute== "email"
			puts contact.note if attribute== "note"
			puts "\n"
		end
		main_menu
	end

	def exit
		abort("Have a Nice Day!")
	end

	def verify_id(id)
		Database.contacts.each do |contact|
			return true if contact.id == id
		end
		return false
	end
end
crm= CRM.new("My CRM")
crm.main_menu

