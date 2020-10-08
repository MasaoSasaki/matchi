module Public::UsersHelper

  def blind(password)
    i = 0
    bilind_password = ""
    while i < password.length
      bilind_password += "*"
      i += 1
    end

    bilind_password
  end

end
