resource "github_membership" "admins" {
  for_each = toset(["erkannt"])
  username = each.key
  role     = "admin"
}
