ActiveAdmin.register User do
  permit_params :email, :name, :initials, :username, :locale,
    :time_zone, :authy_enabled, :password, :password_confirmation,
    :role

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :initials
    column :username
    column :role
    column :authy_enabled
    column do |user|
      link_to("Sign in as #{user.name}", impersonate_engine.impersonate_user_path(user))
    end
  end

  filter :email
  filter :name
  filter :username

  form do |f|
    f.inputs 'User Details' do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :name
      f.input :initials
      f.input :username
      f.input :role, collection: User.role.options
      f.input :locale, collection: I18n.available_locales
      f.input :time_zone
      f.input :authy_enabled
    end
    f.actions
  end

  sidebar 'Team Details', only: %i[show edit] do
    ul do
      li link_to 'Memberships', manage_user_memberships_path(resource)
      li link_to 'Enrollments', manage_user_enrollments_path(resource)
    end
  end
end
