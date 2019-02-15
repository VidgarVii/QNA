module ApplicationHelper
  def delete_btn(resource)
    return unless current_user&.author_of?(resource)

    name = resource.model_name.human.downcase
    link_to "Delete #{name}", polymorphic_url(resource),
            role: 'button',
            class: 'btn btn-warning',
            method: :delete,
            remote: true,
            data: { confirm: 'Are you sure?'}
    end
end
