# -*- coding: utf-8 -*-

class User

  include Mongoid::Document
  field :provider, :type => String
  field :uid, :type => String
  field :name, :type => String
  field :email, :type => String
  field :nickname, :type => String
  field :url, :type => String

  def self.from_omniauth(auth)
    #find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
    where(:provider => auth['provider'], :uid => auth['uid']).first || create_with_omniauth(auth)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]

      user.nickname = auth['info']['nickname']
      user.email = auth['info']['email']
      user.name = auth['info']['name']
      user.url = auth['info']['urls']['GitHub']
    end
  end

  def admin?
    uid == 8049 # mój id na githubie
  end

  def student?
    uid != 8049
  end

end
