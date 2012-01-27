class User

  include Mongoid::Document
  field :provider, :type => String
  field :uid, :type => String
  field :name, :type => String
  field :email, :type => String
  field :nickname, :type => String
  field :url, :type => String

  def self.create_with_omniauth(auth)
    # logger.info("AUTH_INFO: #{auth}")
    # logger.info "-"*80
    # logger.info "#{auth.provider}"
    # logger.info "#{auth.uid}"
    # logger.info "#{auth.info.name}"
    # logger.info "#{auth.info.email}"
    # logger.info "#{auth.info.nickname}"
    # logger.info "#{auth.info.urls['GitHub']}"

    begin
      create! do |user|
        user.provider = auth['provider']
        user.uid = auth['uid']
        if auth['info']
          user.nickname = auth['info']['nickname'] || ""
          user.email = auth['info']['email'] || ""
          user.name = auth['info']['name'] || ""
          user.url = auth['info']['urls']['GitHub'] || ""
        end
      end
    rescue Exception
      raise Exception, "Cannot create user record!"
    end
  end

end
