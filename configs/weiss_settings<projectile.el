(projectile-global-mode 1)

(with-eval-after-load 'projectile
  (projectile-register-project-type 'go '("go.mod")
                                    :compile "go build"
                                    :test "go test"
                                    :run "go run main.go")
  )

(provide 'weiss_settings<projectile)
