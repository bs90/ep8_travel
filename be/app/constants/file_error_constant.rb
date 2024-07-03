module FileErrorConstant
  INVALID_CONTENT_TYPE = {
    code: I18n.t('errors.codes.invalid_content_type'),
    message: I18n.t('errors.messages.invalid_content_type'),
    resource: I18n.t('errors.resources.invalid_content_type'),
    field: 'content_type'
  }.freeze

  FILE_EMPTY = {
    code: I18n.t('errors.codes.file_empty'),
    message: I18n.t('errors.messages.file_empty'),
    resource: I18n.t('errors.resources.upload_file'),
    field: 'presigned_url'
  }.freeze
end
