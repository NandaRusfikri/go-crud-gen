package pkgConfig

type DatabaseCfg struct {
	Name     string `yaml:"name" env:"DB_NAME"`
	Driver   string `yaml:"driver" env:"DB_DRIVER"`
	Host     string `yaml:"host" env:"DB_HOST"`
	Port     int    `yaml:"port" env:"DB_PORT"`
	Username string `yaml:"username" env:"DB_USERNAME"`
	Password string `yaml:"password" env:"DB_PASSWORD"`
	Schema   string `yaml:"schema" env:"DB_SCHEMA"`
}

type Database struct {
	Template DatabaseCfg `yaml:"template"`
	Oracle   DatabaseCfg `yaml:"oracle"`
}
