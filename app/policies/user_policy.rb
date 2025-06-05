# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  %i[index show update destroy].each do |action|
    define_method("#{action}?") do
      user.admin? || user == record
    end
  end
end
