class DoctorPolicy < ApplicationPolicy
  def index?
    true # Все пользователи могут видеть список докторов
  end

  def show?
    user.present? # Только зарегистрированные пользователи могут видеть профили докторов
  end

  def create?
    user.admin? # Только администраторы могут создавать профили докторов
  end

  def update?
    user.admin? || record == user # Только администраторы и сам доктор могут редактировать профиль
  end

  def destroy?
    user.admin? # Только администраторы могут удалять профили докторов
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
