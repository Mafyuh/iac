resource "authentik_stage_prompt_field" "username" {
  field_key = "username"
  label     = "Username"
  type      = "username"
  placeholder = "Username"
  name      = "default-source-enrollment-field-username"
  required  = true
  order = 100
}

resource "authentik_stage_prompt_field" "email" {
  field_key   = "email"
  label       = "Email"
  type        = "email"
  placeholder = "Email"
  name        = "default-user-settings-field-email"
  required    = true
  order = 202
  initial_value_expression = true
  initial_value = <<-EOT
    try:
        return user.email
    except:
        return ''
  EOT
}

resource "authentik_stage_prompt_field" "init-password" {
  field_key = "password"
  label     = "Password"
  type      = "password"
  placeholder = "Password"
  name      = "initial-setup-field-password"
  required  = true
  order = 300
}

resource "authentik_stage_prompt_field" "repeat-password" {
  field_key = "password_repeat"
  label     = "Password (repeat)"
  type      = "password"
  placeholder = "Password (repeat)"
  name      = "initial-setup-field-password-repeat"
  required  = true
  order = 301
}