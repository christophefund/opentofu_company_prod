resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length        = 12
  require_uppercase_characters   = true
  require_lowercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  allow_users_to_change_password = true

  max_password_age               = 180          # days before password expiration
  password_reuse_prevention      = 10           # number of previous passwords users can't reuse
  hard_expiry                    = false        # whether to require admin reset after expiration
}
