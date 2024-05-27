package model

import (
	"gorm.io/gorm"
)

type Database struct {
	Template *gorm.DB
	Oracle   *gorm.DB
}
