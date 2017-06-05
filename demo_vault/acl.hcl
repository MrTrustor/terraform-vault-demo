path "secret/*" {
  policy = "write"
}

path "secret/foo" {
  policy = "read"
}

path "secret/bar" {
  policy = "deny"
}

path "auth/token/lookup-self" {
  policy = "read"
}
