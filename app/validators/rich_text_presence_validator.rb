# app/validators/rich_text_presence_validator.rb

class RichTextPresenceValidator < ActiveModel::Validator
  def validate(record)
    rich_text_attributes(record.class).each do |attribute|
      if record.public_send(attribute).body.blank?
        record.errors.add(attribute, 'can\'t be blank')
      end
    end
  end

  private

  def rich_text_attributes(model_class)
    case model_class
    when Podcast
      %i[about]
    when Episode
      %i[description]
    else
      []
    end
  end
end