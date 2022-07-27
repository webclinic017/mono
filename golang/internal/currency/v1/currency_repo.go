package v1

import (
	"log"
	"os"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

type User struct {
	gorm.Model
	Name       string
	Currencies []*Currency `gorm:"many2many:user_currencies;"`
}

type Currency struct {
	gorm.Model
	Name  string
	Users []*User `gorm:"many2many:user_currencies;"`
}

func CreateUserAndCurrencyData() {
	_, err := gorm.Open(
		postgres.Open(os.Getenv("DATABASE_URL")+"&application_name=$ docs_simplecrud_gorm"),
		&gorm.Config{},
	)
	if err != nil {
		log.Fatal(err)
	}
}
