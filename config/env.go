package config

import (
	"github.com/caarlos0/env/v7"
)

var EnvConfig = envConfig{}

type envConfig struct {
	// App Configuration
	Environment string `env:"ENVIRONMENT" envDefault:"development"`
	Port        string `env:"PORT" envDefault:"8080"`

	// Server Configuration
	RunMode string `env:"GIN_MODE" envDefault:"release"`

	// Database Configuration
	DBName     string `env:"DB_NAME" envDefault:"dev"`
	DBUser     string `env:"DB_USER" envDefault:"dev"`
	DBPassword string `env:"DB_PASSWORD" envDefault:"password"`
	DBHost     string `env:"DB_HOST" envDefault:"localhost:3306"`
}

func init() {
	if err := env.Parse(&EnvConfig); err != nil {
		panic(err)
	}
}
