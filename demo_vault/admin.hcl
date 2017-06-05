path "secret/*" {
  policy = "write"
}

path "auth/*" {
  policy = "sudo"
}

path "auth/token/lookup-self" {
  policy = "read"
}
