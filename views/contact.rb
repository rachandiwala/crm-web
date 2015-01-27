class Contact

  attr_accessor :id, :first_name, :last_name, :email, :note

  def initialize (id, first_name, last_name, email, note)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @email = email
    @note = note
  end

end
