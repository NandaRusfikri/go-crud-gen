package pkgConfig

import "time"

type (
	AppConfig struct {
		ServiceVersion     string        `yaml:"version" env:"APP_VERSION" required:"true"`
		ServiceName        string        `yaml:"name" env:"APP_NAME" required:"true"`
		BasePath           string        `yaml:"base-path" env:"APP_BASE_PATH" default:"sample-project"`
		ServerPort         int           `yaml:"port" env:"APP_PORT" default:"8090"`
		GracefullyDuration time.Duration `yaml:"gracefull-duration" env:"APP_GRACEFULL_DURATION" default:"10s"`
	}
)
