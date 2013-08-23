class Contact
  def initialize(first_name, last_name, email, note)
    @first_name = first_name
   	@last_name = last_name
    @email = email
    @note = note
  end

  attr_accessor :id, :first_name, :last_name, :email, :note

  # def id
  # 	return @id
  # end

  # def id=(new_id)
  # 	@id = new_id
  # end
end