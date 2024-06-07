package pkgConfig

type (
	Config struct {
		AppConfig AppConfig `yaml:"app"`
		Database  Database  `yaml:"database"`
	}
)
