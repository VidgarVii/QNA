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

  def gist(url)
    service = GistService.new(url)

    if service.gist_found?
      simple_format(service.content)
    else
      "#{service.status} Not Found GIST"
    end
  end
end
