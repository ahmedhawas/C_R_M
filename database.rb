class Database
  @contact_database = []
  @id = 1000

  def self.add_contact(contact)
    contact.id = @id
    @contact_database << contact
    @id += 1
  end

  def self.contacts
    @contact_database
  end
end