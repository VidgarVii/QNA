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

  def extract_question_path(resource)
    return root_path if resource.is_a?(User)

    question = case resource.class.name
               when 'Question'
                 resource
               when 'Answer'
                 resource.question
               when 'Comment'
                 resource.commentable.is_a?(Question) ? resource.commentable : resource.commentable.question
               end

     question_path(question)
  end

  def gist(url)
    service = Services::Gist.new(url)

    if service.gist_found?
      simple_format(service.content)
    else
      "#{service.status} Not Found GIST"
    end
  end

  def collection_cache_key_for(model)
    klass = model.to_s.capitalize.constantize
    count = klass.count
    max_updated_at = klass.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "#{model.to_s.pluralize}/collection-#{count}-#{max_updated_at}"
  end
end
