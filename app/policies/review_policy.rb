class ReviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.present?
  end

  def update?
    user.present? && (user.admin? || record.user == user)
  end

  def destroy?
    user.present? && user.admin?
  end
  def show_all?
    true # Разрешить всем пользователям просмотр всех отзывов
  end
end
