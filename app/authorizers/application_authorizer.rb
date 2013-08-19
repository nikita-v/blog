class ApplicationAuthorizer < Authority::Authorizer
  def self.default(adjective, user)
    user.admin?
  end
end
