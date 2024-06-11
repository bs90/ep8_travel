module SessionErrorConstant
  AUTHENTICATION_FAILED = {
    code: I18n.t('errors.codes.unauthenticated'),
    message: I18n.t('errors.messages.unauthenticated'),
    resource: I18n.t('errors.resources.user')
  }
  INVALID_TOKEN = {
    code: I18n.t('errors.codes.invalid_token'),
    message: I18n.t('errors.messages.invalid_token'),
    resource: I18n.t('errors.resources.user')
  }
  NOT_ALLOWED_EMAIL_DOMAIN = {
    code: I18n.t('errors.codes.invalid_email_domain'),
    message: I18n.t('errors.messages.invalid_email_domain'),
    resource: I18n.t('errors.resources.user')
  }
  INVALID_ACCESS_TOKEN = {
    code: I18n.t('errors.codes.invalid_access_token'),
    message: I18n.t('errors.messages.invalid_access_token'),
  }
end
